# Configuração: Modo Motorista Exclusivo

## 📌 Objetivo

Configurar o aplicativo para exibir **apenas a opção de acesso para Motorista**, ocultando completamente a opção de Colaborador na tela de seleção de acesso.

---

## 🔧 Implementação

### Opção 1: Redirecionar Diretamente (Recomendado)

Para uma experiência mais limpa, o app pode redirecionar diretamente para a tela de login do motorista, pulando a seleção de acesso.

**Arquivo:** `src/App.tsx`

Modifique a rota raiz para redirecionar:

```tsx
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";

// Dentro do componente App ou como middleware
useEffect(() => {
  // Se o usuário não está autenticado, redirecionar para login do motorista
  const isAuthenticated = localStorage.getItem("authToken");
  if (!isAuthenticated) {
    navigate("/login/driver");
  }
}, [navigate]);
```

---

### Opção 2: Ocultar Opção de Colaborador (Alternativa)

Se preferir manter a tela de seleção, mas ocultar a opção de Colaborador:

**Arquivo:** `src/pages/RoleSelection.tsx`

Modifique para comentar/remover a seção do Colaborador:

```tsx
// Remover ou comentar este bloco:
{/* 
<motion.div whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
  <Button onClick={() => navigate("/login/collaborator")} className="w-full h-auto py-6 px-6 bg-foreground hover:bg-foreground/90 text-background rounded-2xl group shadow-lg">
    <div className="flex items-center w-full">
      <div className="p-3 bg-background/15 rounded-xl mr-4"><Users className="h-6 w-6" /></div>
      <div className="text-left flex-1">
        <p className="font-semibold text-lg">{t("auth.collaborator")}</p>
        <p className="text-sm opacity-75 font-normal">{t("roleSelection.collaboratorDesc")}</p>
      </div>
      <ArrowRight className="h-5 w-5 opacity-50 group-hover:opacity-100 group-hover:translate-x-1 transition-all" />
    </div>
  </Button>
</motion.div>
*/}

// Manter apenas:
<motion.div whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
  <Button onClick={() => navigate("/login/driver")} variant="outline" className="w-full h-auto py-6 px-6 border-2 rounded-2xl group bg-card shadow-sm hover:shadow-md transition-all">
    <div className="flex items-center w-full">
      <div className="p-3 bg-muted rounded-xl mr-4 group-hover:bg-muted/80 transition-colors"><UserCircle className="h-6 w-6 text-muted-foreground" /></div>
      <div className="text-left flex-1">
        <p className="font-semibold text-lg text-foreground">{t("auth.driver")}</p>
        <p className="text-sm text-muted-foreground font-normal">{t("roleSelection.driverDesc")}</p>
      </div>
      <ArrowRight className="h-5 w-5 text-muted-foreground group-hover:text-foreground group-hover:translate-x-1 transition-all" />
    </div>
  </Button>
</motion.div>
```

---

### Opção 3: Bloquear Rotas de Colaborador (Segurança)

Para garantir que usuários não possam acessar rotas de colaborador mesmo digitando a URL:

**Arquivo:** `src/App.tsx`

Adicione proteção nas rotas:

```tsx
// Remover ou comentar rotas de colaborador
// <Route path="/login/collaborator" element={<CollaboratorLogin />} />
// <Route path="/register/collaborator" element={<CollaboratorRegister />} />

// Adicionar redirecionamento para rotas bloqueadas
<Route path="/login/collaborator" element={<Navigate to="/login/driver" />} />
<Route path="/register/collaborator" element={<Navigate to="/login/driver" />} />
```

---

## 🚀 Implementação Recomendada

**Combinar as três abordagens:**

1. ✅ **Redirecionar raiz** → `/login/driver`
2. ✅ **Ocultar botão** → Remover UI de Colaborador
3. ✅ **Bloquear rotas** → Redirecionar URLs de Colaborador

Isso garante que:
- Usuários veem apenas a opção de Motorista
- Não conseguem acessar telas de Colaborador
- Experiência é limpa e profissional

---

## 📱 Fluxo de Acesso no App Android

```
Iniciar App
    ↓
Verificar autenticação
    ↓
Não autenticado? → Redirecionar para /login/driver
    ↓
Tela de Login do Motorista
    ↓
Inserir credenciais
    ↓
Autenticado? → Redirecionar para /app/driver/home
    ↓
Dashboard do Motorista
```

---

## 🔐 Segurança

### Proteção no Backend

Certifique-se de que o servidor também valida:

1. **Autenticação:** Apenas motoristas podem acessar `/api/driver/*`
2. **Autorização:** Verificar role do usuário é `driver`
3. **CORS:** Permitir apenas origem do app

### Exemplo (Node.js/Express):

```javascript
app.get('/api/driver/home', authenticate, (req, res) => {
  if (req.user.role !== 'driver') {
    return res.status(403).json({ error: 'Acesso negado' });
  }
  // Retornar dados do motorista
});
```

---

## ✅ Checklist de Implementação

- [ ] Remover/comentar rota de Colaborador em `App.tsx`
- [ ] Remover/comentar botão de Colaborador em `RoleSelection.tsx`
- [ ] Adicionar redirecionamento de rotas bloqueadas
- [ ] Testar no emulador/dispositivo
- [ ] Verificar que apenas login de Motorista funciona
- [ ] Compilar nova versão do APK
- [ ] Atualizar na Play Store

---

## 🧪 Testes

```bash
# 1. Compilar projeto
npm run build

# 2. Sincronizar Capacitor
npx cap sync android

# 3. Instalar no emulador
cd android
./gradlew installDebug

# 4. Testar fluxo:
#    - Abrir app
#    - Deve redirecionar para login de motorista
#    - Fazer login com credenciais de motorista
#    - Verificar acesso ao dashboard
#    - Tentar acessar /login/collaborator (deve redirecionar)
```

---

## 📝 Notas

- Todas as mudanças devem ser feitas **antes** de compilar o APK final
- Testar thoroughly em dispositivo real antes de publicar
- Manter backup do código original antes de fazer mudanças

---

**Configurado em:** 26 de abril de 2026  
**Modo:** Exclusivo para Motoristas  
**Status:** Pronto para implementação

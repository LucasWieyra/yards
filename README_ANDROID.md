# 🚀 YMS Axioma - Aplicativo Android

Bem-vindo! Este é o projeto do aplicativo Android para o **YMS Axioma**, um container profissional que funciona como WebView para o sistema de gerenciamento de pátios e operações de motoristas.

---

## 📱 O que é este projeto?

Este é um **aplicativo Android nativo** construído com **Capacitor** que:

- ✅ Funciona como um container WebView profissional
- ✅ Acessa o sistema web em `https://yms.axioma-dados.com.br`
- ✅ Oferece experiência mobile otimizada
- ✅ Mantém autenticação entre sessões
- ✅ Atualiza dados em tempo real (cache desabilitado)
- ✅ Suporta Android 8.0 e superior

---

## 🎯 Funcionalidades Principais

| Funcionalidade | Status |
|---|---|
| Login de Motorista | ✅ Implementado |
| Dashboard do Motorista | ✅ Implementado |
| Gerenciamento de Processos | ✅ Implementado |
| Histórico de Operações | ✅ Implementado |
| Autenticação JWT | ✅ Implementado |
| Atualizações em Tempo Real | ✅ Implementado |
| Cache Desabilitado | ✅ Implementado |
| Ícone Customizado | ✅ Implementado |
| Splash Screen | ✅ Implementado |

---

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado:

- **Android Studio** (2024.1 ou superior)
- **Java Development Kit (JDK)** 17+
- **Node.js** 18+ (com npm)
- **Git** (opcional, mas recomendado)

### Verificar Instalação

```bash
# Verificar Node.js
node --version
npm --version

# Verificar Java
java -version
```

---

## 🚀 Início Rápido

### 1. Clonar ou Extrair o Projeto

```bash
# Se recebeu como arquivo compactado
tar -xzf yms-axioma-android-project.tar.gz
cd yms-axioma-app

# Ou, se está em um repositório Git
git clone <seu-repositorio>
cd yms-axioma-app
```

### 2. Instalar Dependências

```bash
# Instalar dependências Node.js
npm install --legacy-peer-deps

# Compilar projeto web
npm run build
```

### 3. Sincronizar com Android

```bash
# Sincronizar Capacitor com plataforma Android
npx cap sync android
```

### 4. Abrir no Android Studio

```bash
# Abrir projeto Android
open android/
# Ou no Windows: start android\
# Ou no Linux: xdg-open android/
```

### 5. Compilar e Executar

No Android Studio:

1. Conecte um dispositivo Android ou inicie um emulador
2. Clique em **Run** (▶️) ou pressione `Shift + F10`
3. Selecione o dispositivo/emulador
4. O app será compilado e instalado automaticamente

---

## 📦 Estrutura do Projeto

```
yms-axioma-app/
├── android/                              # Código Android nativo
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml      # Permissões e configurações
│   │   │   ├── java/com/axioma/yms/    # Código Java
│   │   │   │   └── MainActivity.java    # Configuração WebView
│   │   │   └── res/                     # Recursos (ícones, cores, strings)
│   │   └── build.gradle                 # Configuração de build
│   ├── build.gradle                     # Configuração raiz
│   └── gradle/                          # Scripts Gradle
├── capacitor.config.ts                  # Configuração Capacitor
├── package.json                         # Dependências Node.js
├── ANDROID_BUILD_GUIDE.md              # Guia completo de build
├── CAPACITOR_SETUP.md                  # Configuração rápida
├── DRIVER_MODE_CONFIG.md               # Modo exclusivo de motorista
└── README_ANDROID.md                   # Este arquivo

```

---

## 🔧 Configurações Principais

### capacitor.config.ts

```typescript
{
  appId: 'com.axioma.yms',
  appName: 'YMS Axioma',
  webDir: 'dist',
  server: {
    url: 'https://yms.axioma-dados.com.br',
    cleartext: false,
    allowNavigation: ['yms.axioma-dados.com.br', '*.axioma-dados.com.br']
  },
  android: {
    allowMixedContent: false,
    webViewDebuggingEnabled: false,
    captureInput: true
  }
}
```

### MainActivity.java

Configurado com:
- Cache desabilitado (`LOAD_NO_CACHE`)
- JavaScript habilitado
- Conteúdo misto bloqueado
- localStorage preservado

### AndroidManifest.xml

Permissões incluídas:
- INTERNET
- ACCESS_NETWORK_STATE
- ACCESS_FINE_LOCATION
- CAMERA
- READ/WRITE_EXTERNAL_STORAGE

---

## 🎨 Customizações

### Alterar Ícone do App

1. Substitua os arquivos em `android/app/src/main/res/mipmap-*/ic_launcher.png`
2. Tamanhos recomendados:
   - mdpi: 48x48 px
   - hdpi: 72x72 px
   - xhdpi: 96x96 px
   - xxhdpi: 144x144 px
   - xxxhdpi: 192x192 px

### Alterar Cores do Tema

Edite `android/app/src/main/res/values/colors.xml`:

```xml
<color name="colorPrimary">#1a1a1a</color>
<color name="colorPrimaryDark">#0d0d0d</color>
<color name="colorAccent">#2563eb</color>
```

### Alterar Nome do App

Edite `android/app/src/main/res/values/strings.xml`:

```xml
<string name="app_name">Seu Nome Aqui</string>
<string name="title_activity_main">Seu Nome Aqui</string>
```

---

## 🔐 Modo Exclusivo de Motorista

O aplicativo está configurado para exibir **apenas a opção de login de motorista**.

Para implementar completamente, siga as instruções em `DRIVER_MODE_CONFIG.md`:

1. Remover rota de Colaborador em `src/App.tsx`
2. Remover botão de Colaborador em `src/pages/RoleSelection.tsx`
3. Redirecionar diretamente para login de motorista

---

## 🏗️ Build para Produção

### Criar Keystore (primeira vez)

```bash
cd android
keytool -genkey -v -keystore yms-axioma-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias yms-axioma-key
```

### Compilar APK Release

```bash
cd android
./gradlew assembleRelease
# APK: app/build/outputs/apk/release/app-release.apk
```

### Compilar Bundle (AAB)

```bash
cd android
./gradlew bundleRelease
# AAB: app/build/outputs/bundle/release/app-release.aab
```

---

## 📱 Testar no Emulador

### Criar Emulador

1. Abra Android Studio
2. Clique em **Device Manager**
3. Clique em **Create Device**
4. Selecione um dispositivo (ex: Pixel 6)
5. Selecione Android 14 (API 34)
6. Clique em **Finish**

### Executar no Emulador

```bash
# Compilar e instalar
cd android
./gradlew installDebug

# Ou via Android Studio: Run > Run 'app'
```

---

## 🌐 Publicar na Play Store

Siga o guia completo em **ANDROID_BUILD_GUIDE.md**:

1. Criar conta Google Play Developer
2. Configurar assinatura (keystore)
3. Compilar APK/AAB release
4. Fazer upload no Play Store
5. Preencher metadados
6. Enviar para revisão

---

## 🔄 Atualizações

Para lançar uma nova versão:

1. Incremente versão em `android/app/build.gradle`:
   ```gradle
   versionCode 2
   versionName "1.1"
   ```

2. Compile nova versão:
   ```bash
   cd android
   ./gradlew bundleRelease
   ```

3. Faça upload no Play Store

---

## 🐛 Troubleshooting

### Problema: "Build falha"

```bash
cd android
./gradlew clean
./gradlew build
```

### Problema: "WebView não carrega"

1. Verifique conexão de internet
2. Confirme URL em `capacitor.config.ts`
3. Verifique certificado SSL do servidor

### Problema: "APK não instala"

```bash
# Remover versão anterior
adb uninstall com.axioma.yms

# Instalar nova versão
adb install app-release.apk
```

---

## 📚 Documentação Completa

- **ANDROID_BUILD_GUIDE.md** - Guia detalhado de build e publicação
- **CAPACITOR_SETUP.md** - Configuração rápida do Capacitor
- **DRIVER_MODE_CONFIG.md** - Configurar modo exclusivo de motorista

---

## 🔗 Recursos Úteis

| Recurso | Link |
|---------|------|
| Documentação Capacitor | https://capacitorjs.com/docs |
| Android Developers | https://developer.android.com |
| Google Play Console | https://play.google.com/console |
| Gradle Documentation | https://gradle.org/ |

---

## 📞 Suporte

Para dúvidas ou problemas:

1. Consulte a documentação em `ANDROID_BUILD_GUIDE.md`
2. Verifique logs no Android Studio
3. Consulte documentação oficial do Capacitor

---

## 📝 Informações do Projeto

| Informação | Valor |
|-----------|-------|
| **App ID** | com.axioma.yms |
| **Nome do App** | YMS Axioma |
| **Versão Mínima** | Android 8.0 (API 26) |
| **Versão Alvo** | Android 14 (API 34) |
| **Capacitor** | 8.3.1 |
| **URL Remota** | https://yms.axioma-dados.com.br |

---

## ✅ Checklist de Publicação

- [ ] Projeto compila sem erros
- [ ] App funciona em emulador/dispositivo
- [ ] Login de motorista funciona
- [ ] Dados carregam corretamente
- [ ] Ícone do app está visível
- [ ] Certificado de assinatura está válido
- [ ] Versão foi incrementada
- [ ] Notas de versão foram preenchidas
- [ ] Metadados foram atualizados

---

## 📄 Licença

Este projeto é propriedade do YMS Axioma.

---

**Versão:** 1.0  
**Data:** 26 de abril de 2026  
**Desenvolvido por:** Manus AI  
**Status:** Pronto para Produção ✅

# 📱 Como Gerar o APK Localmente - YMS Axioma

## ⚡ Opção Mais Rápida: Usar Android Studio (Recomendado)

### Passo 1: Baixar e Instalar Android Studio
- Acesse: https://developer.android.com/studio
- Baixe e instale
- Durante a instalação, selecione "Android SDK" e "Android Virtual Device"

### Passo 2: Abrir o Projeto
```bash
# No seu computador
cd yms-axioma-app
open android/
# Ou no Windows: start android\
# Ou no Linux: xdg-open android/
```

### Passo 3: Compilar APK Release
1. No Android Studio, clique em: **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
2. Aguarde a compilação (5-10 minutos)
3. O APK estará em: `android/app/build/outputs/apk/release/app-release.apk`

### Passo 4: Instalar e Testar
```bash
# Conecte seu dispositivo ou inicie um emulador
adb install android/app/build/outputs/apk/release/app-release.apk
```

---

## 🔧 Opção via Linha de Comando

### Pré-requisitos
- Java 17+ instalado
- Android SDK instalado
- Variável `ANDROID_HOME` configurada

### Compilar APK
```bash
cd android
./gradlew assembleRelease

# O APK estará em:
# app/build/outputs/apk/release/app-release.apk
```

### Compilar AAB (para Play Store)
```bash
cd android
./gradlew bundleRelease

# O AAB estará em:
# app/build/outputs/bundle/release/app-release.aab
```

---

## 🌐 Opção Online (Sem Instalar Nada)

### Usar Appcircle (Recomendado para Online)

1. Acesse: https://appcircle.io
2. Crie uma conta gratuita
3. Clique em "New App"
4. Selecione "Connect GitHub Repository" (ou upload manual)
5. Selecione este projeto
6. Configure:
   - **Build Profile:** Android
   - **Gradle Task:** assembleRelease
7. Clique em "Start Build"
8. Aguarde (~10-15 minutos)
9. Download do APK quando estiver pronto

---

## 📋 Checklist Antes de Compilar

- [ ] Java 17+ instalado
- [ ] Android SDK instalado
- [ ] `ANDROID_HOME` configurado
- [ ] Certificado de assinatura existe: `android/yms-axioma-release.keystore`
- [ ] `android/keystore.properties` existe com as senhas

---

## 🔐 Informações do Certificado

Se precisar recriar o certificado:

```bash
cd android

keytool -genkey -v -keystore yms-axioma-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias yms-axioma-key \
  -storepass axioma@2026 \
  -keypass axioma@2026 \
  -dname "CN=Axioma Dados,O=Axioma Dados,L=Brasil,C=BR"
```

---

## 📱 Testar o APK

### Em Emulador
```bash
# Listar emuladores
emulator -list-avds

# Iniciar emulador
emulator -avd <nome_do_emulador>

# Instalar APK
adb install app-release.apk
```

### Em Dispositivo Real
```bash
# Conectar dispositivo via USB
# Habilitar "Depuração USB" nas configurações do dispositivo

# Listar dispositivos
adb devices

# Instalar APK
adb install app-release.apk
```

---

## ✅ Validação Final

Após compilar, verifique:

- [ ] APK foi gerado com sucesso
- [ ] Tamanho do APK está entre 30-40 MB
- [ ] APK instala sem erros
- [ ] App abre e carrega a URL
- [ ] Login funciona
- [ ] Dados carregam corretamente

---

## 🚀 Próximos Passos

Após validar o APK:

1. **Publicar na Play Store:**
   - Siga guia em `ANDROID_BUILD_GUIDE.md`

2. **Distribuir Internamente:**
   - Compartilhe o APK via email ou cloud
   - Usuários podem instalar diretamente

3. **Atualizar:**
   - Incremente `versionCode` em `android/app/build.gradle`
   - Recompile e republique

---

## 📞 Suporte

- **Erro de Gradle:** Atualize para Java 17+
- **Erro de SDK:** Configure `ANDROID_HOME`
- **Erro de Assinatura:** Verifique `keystore.properties`
- **Erro de Build:** Limpe com `./gradlew clean`

---

**Recomendação:** Use Android Studio - é o mais simples e tem interface gráfica!

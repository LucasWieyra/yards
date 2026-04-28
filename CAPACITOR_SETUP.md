# Configuração Rápida do Capacitor - YMS Axioma

## ✅ O que foi feito

Este projeto foi configurado como um **container Android profissional** para o sistema YMS Axioma usando Capacitor. O aplicativo funciona como um WebView que acessa `https://yms.axioma-dados.com.br`.

### Configurações Implementadas

#### 1. **Capacitor Core**
- ✅ Inicializado com App ID: `com.axioma.yms`
- ✅ Nome do app: `YMS Axioma`
- ✅ Plataforma Android adicionada

#### 2. **WebView Remoto**
- ✅ URL configurada: `https://yms.axioma-dados.com.br`
- ✅ Cache desabilitado (`LOAD_NO_CACHE`)
- ✅ Atualizações em tempo real garantidas
- ✅ localStorage preservado para autenticação

#### 3. **Segurança**
- ✅ HTTPS obrigatório
- ✅ Conteúdo misto bloqueado
- ✅ JavaScript habilitado
- ✅ Permissões configuradas no AndroidManifest.xml

#### 4. **Interface**
- ✅ Ícone do app: Logo YMS Axioma
- ✅ Splash screen configurado
- ✅ Cores do tema: Preto (#1a1a1a) e Azul (#2563eb)
- ✅ Material Design aplicado

#### 5. **Permissões Android**
- ✅ INTERNET
- ✅ ACCESS_NETWORK_STATE
- ✅ ACCESS_FINE_LOCATION
- ✅ CAMERA
- ✅ READ_EXTERNAL_STORAGE
- ✅ WRITE_EXTERNAL_STORAGE

---

## 🚀 Próximos Passos

### Opção 1: Build Local (Recomendado para Testes)

```bash
# 1. Instalar dependências
npm install --legacy-peer-deps

# 2. Compilar projeto web
npm run build

# 3. Sincronizar com Android
npx cap sync android

# 4. Abrir Android Studio
open android/
# Ou no Windows:
# start android\

# 5. No Android Studio:
#    - Clique em "Build" > "Build Bundle(s) / APK(s)" > "Build APK(s)"
#    - Aguarde a compilação
#    - APK estará em: android/app/build/outputs/apk/release/app-release.apk
```

### Opção 2: Build via Gradle (Linha de Comando)

```bash
# 1. Navegar para diretório Android
cd android

# 2. Compilar APK debug (para testes)
./gradlew assembleDebug
# APK: app/build/outputs/apk/debug/app-debug.apk

# 3. Ou compilar APK release (para Play Store)
./gradlew assembleRelease
# APK: app/build/outputs/apk/release/app-release.apk

# 4. Ou compilar Bundle (recomendado para Play Store)
./gradlew bundleRelease
# AAB: app/build/outputs/bundle/release/app-release.aab
```

---

## 📋 Arquivos Importantes

| Arquivo | Descrição |
|---------|-----------|
| `capacitor.config.ts` | Configuração principal do Capacitor |
| `android/app/src/main/AndroidManifest.xml` | Permissões e metadados |
| `android/app/src/main/java/com/axioma/yms/MainActivity.java` | Configuração do WebView |
| `android/app/build.gradle` | Configuração de build e versão |
| `ANDROID_BUILD_GUIDE.md` | Guia completo de build e publicação |

---

## 🔐 Configurar Assinatura (Necessário para Play Store)

```bash
# 1. Gerar keystore (primeira vez)
cd android
keytool -genkey -v -keystore yms-axioma-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias yms-axioma-key

# 2. Criar arquivo keystore.properties
cat > keystore.properties << EOF
storeFile=./yms-axioma-release.keystore
storePassword=SUA_SENHA
keyAlias=yms-axioma-key
keyPassword=SUA_SENHA
EOF

# 3. Adicionar ao .gitignore
echo "keystore.properties" >> ../.gitignore
echo "*.keystore" >> ../.gitignore

# 4. Compilar APK assinado
./gradlew assembleRelease
```

---

## 📱 Testar no Emulador

```bash
# 1. Abrir Android Studio e criar emulador (se não tiver)
# 2. Iniciar emulador
# 3. Compilar e instalar
cd android
./gradlew installDebug

# 4. Ou via adb
adb install app/build/outputs/apk/debug/app-debug.apk
```

---

## 🌐 Publicar na Play Store

1. Crie conta em [Google Play Console](https://play.google.com/console)
2. Siga o guia completo em `ANDROID_BUILD_GUIDE.md`
3. Faça upload do `app-release.aab` (recomendado)
4. Preencha metadados e descrição
5. Envie para revisão

---

## 🔄 Atualizações Futuras

Para atualizar o app:

1. Incremente versão em `android/app/build.gradle`:
   ```gradle
   versionCode 2  // Incrementar
   versionName "1.1"  // Incrementar
   ```

2. Compile nova versão:
   ```bash
   cd android
   ./gradlew bundleRelease
   ```

3. Faça upload no Play Store

---

## 📞 Recursos Úteis

- **Documentação Capacitor:** https://capacitorjs.com/docs
- **Android Developers:** https://developer.android.com
- **Google Play Console:** https://play.google.com/console
- **Gradle Documentation:** https://gradle.org/

---

## ⚠️ Notas Importantes

1. **Cache Desabilitado:** O app sempre busca dados atualizados do servidor
2. **Autenticação:** JWT é armazenado em localStorage e persiste entre sessões
3. **Conectividade:** Requer conexão de internet para funcionar
4. **Versão Mínima:** Android 8.0 (API 26)
5. **Certificado SSL:** Servidor deve ter certificado válido

---

**Configurado em:** 26 de abril de 2026  
**Versão Capacitor:** 8.3.1  
**Android SDK:** API 34 (Android 14)

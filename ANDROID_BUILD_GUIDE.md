# Guia Completo: Build e Publicação do YMS Axioma Android

## 📋 Visão Geral

Este documento fornece instruções passo a passo para compilar o aplicativo YMS Axioma em um APK/AAB instalável e publicá-lo na Google Play Store. O aplicativo funciona como um container WebView profissional que acessa o sistema web em `https://yms.axioma-dados.com.br`, com foco no módulo do motorista.

---

## 🔧 Pré-requisitos

Antes de começar, certifique-se de que possui:

- **Android Studio** (versão 2024.1 ou superior) instalado em seu computador
- **Java Development Kit (JDK)** versão 17 ou superior
- **Android SDK** com API Level 34 (Android 14) configurado
- **Git** instalado para controle de versão
- Uma **conta Google Play Developer** (taxa única de $25 USD)
- Um **certificado de assinatura** (será criado durante o processo)

### Verificar Instalação do Android Studio

```bash
# Verificar versão do JDK
java -version

# Verificar Android SDK
$ANDROID_HOME/tools/bin/sdkmanager --list
```

---

## 📦 Estrutura do Projeto Capacitor

O projeto foi configurado com a seguinte estrutura:

```
yms-axioma-app/
├── android/                          # Código Android nativo
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml   # Permissões e configurações
│   │   │   ├── java/com/axioma/yms/  # Código Java (MainActivity.java)
│   │   │   └── res/                  # Recursos (ícones, strings, cores)
│   │   └── build.gradle              # Configuração de build
│   └── build.gradle                  # Configuração raiz
├── capacitor.config.ts               # Configuração do Capacitor
├── dist/                             # Arquivos web compilados
└── package.json                      # Dependências Node.js
```

### Configurações Principais

**capacitor.config.ts:**
- URL remota: `https://yms.axioma-dados.com.br`
- App ID: `com.axioma.yms`
- Cache desabilitado para atualizações em tempo real
- Permissões de internet e localização

**MainActivity.java:**
- WebView configurado com cache desabilitado (`LOAD_NO_CACHE`)
- Segurança: conteúdo misto bloqueado
- JavaScript habilitado para funcionalidade web

**AndroidManifest.xml:**
- Permissões: INTERNET, LOCATION, CAMERA, STORAGE
- Ícone: Logo do YMS Axioma
- Tema: Material Design

---

## 🚀 Passo 1: Preparar o Ambiente

### 1.1 Clonar ou Extrair o Projeto

```bash
# Se o projeto está em um repositório Git
git clone <seu-repositorio> yms-axioma-app
cd yms-axioma-app

# Ou, se recebeu como ZIP
unzip yms-axioma-app.zip
cd yms-axioma-app
```

### 1.2 Instalar Dependências Node.js

```bash
# Instalar dependências do projeto
npm install --legacy-peer-deps

# Compilar o projeto web
npm run build
```

### 1.3 Sincronizar Capacitor

```bash
# Atualizar arquivos Android com configurações Capacitor
npx cap sync android

# Ou, se precisar adicionar a plataforma novamente
npx cap add android
```

---

## 🔐 Passo 2: Criar Certificado de Assinatura

Para publicar na Play Store, você precisa assinar o APK com um certificado. Siga estes passos:

### 2.1 Gerar Keystore (primeira vez)

```bash
# Navegar para o diretório Android
cd android

# Gerar keystore (execute uma única vez)
keytool -genkey -v -keystore yms-axioma-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias yms-axioma-key

# Será solicitado:
# - Senha do keystore: [escolha uma senha forte]
# - Nome: [seu nome]
# - Organização: [sua empresa]
# - Localidade: [sua cidade]
# - Estado: [seu estado]
# - País: [código do país, ex: BR]
```

**⚠️ IMPORTANTE:** Guarde o arquivo `yms-axioma-release.keystore` e a senha em local seguro. Você precisará deles para atualizações futuras.

### 2.2 Configurar Gradle para Assinatura

Crie o arquivo `android/keystore.properties`:

```properties
storeFile=./yms-axioma-release.keystore
storePassword=SUA_SENHA_AQUI
keyAlias=yms-axioma-key
keyPassword=SUA_SENHA_AQUI
```

**⚠️ SEGURANÇA:** Adicione `keystore.properties` ao `.gitignore` para não expor senhas:

```bash
echo "keystore.properties" >> .gitignore
echo "*.keystore" >> .gitignore
```

### 2.3 Atualizar build.gradle

Edite `android/app/build.gradle` e adicione a configuração de assinatura:

```gradle
android {
    // ... configurações existentes ...
    
    signingConfigs {
        release {
            storeFile file("../yms-axioma-release.keystore")
            storePassword System.getenv("KEYSTORE_PASSWORD") ?: "default"
            keyAlias "yms-axioma-key"
            keyPassword System.getenv("KEY_PASSWORD") ?: "default"
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

---

## 📱 Passo 3: Compilar APK para Testes

### 3.1 Build Debug (para testes locais)

```bash
cd android

# Compilar APK debug
./gradlew assembleDebug

# O APK estará em: app/build/outputs/apk/debug/app-debug.apk
```

### 3.2 Testar em Emulador ou Dispositivo

```bash
# Listar dispositivos conectados
adb devices

# Instalar APK debug
adb install app/build/outputs/apk/debug/app-debug.apk

# Ou usando Gradle
./gradlew installDebug
```

---

## 🎯 Passo 4: Compilar APK para Produção

### 4.1 Build Release APK

```bash
cd android

# Compilar APK release assinado
./gradlew assembleRelease

# O APK estará em: app/build/outputs/apk/release/app-release.apk
```

### 4.2 Compilar Bundle Android (AAB)

O Bundle Android (AAB) é o formato preferido pela Play Store. Oferece menor tamanho de download:

```bash
cd android

# Compilar AAB release assinado
./gradlew bundleRelease

# O AAB estará em: app/build/outputs/bundle/release/app-release.aab
```

### 4.3 Verificar Assinatura

```bash
# Verificar se o APK foi assinado corretamente
jarsigner -verify -verbose app/build/outputs/apk/release/app-release.apk

# Resultado esperado: "jar verified."
```

---

## 🌐 Passo 5: Publicar na Google Play Store

### 5.1 Criar Conta Google Play Developer

1. Acesse [Google Play Console](https://play.google.com/console)
2. Clique em "Criar aplicativo"
3. Preencha as informações:
   - **Nome do app:** YMS Axioma
   - **Idioma padrão:** Português (Brasil)
   - **Categoria:** Negócios ou Produtividade
   - **Tipo de app:** Aplicativo

### 5.2 Preencher Informações do App

Na seção **Configuração do app:**

- **Ícone do app:** Upload do logo (512x512 px)
- **Título curto:** YMS Axioma (máx. 50 caracteres)
- **Descrição completa:**

```
YMS Axioma é um aplicativo profissional para gerenciamento de pátios e 
operações de motoristas. Acesse o sistema de forma segura e eficiente 
diretamente do seu dispositivo Android.

Funcionalidades:
- Acesso ao sistema YMS Axioma em tempo real
- Gerenciamento de processos do motorista
- Histórico de operações
- Autenticação segura com JWT
- Atualizações automáticas
```

- **Categoria:** Negócios
- **Classificação de conteúdo:** Selecione apropriadamente

### 5.3 Upload do APK/AAB

1. Na seção **Versão**, clique em **Criar nova versão**
2. Escolha **Produção** (ou **Teste interno** para testes iniciais)
3. Faça upload do arquivo `app-release.aab` (recomendado) ou `app-release.apk`
4. Preencha as notas de versão:

```
Versão 1.0 - Lançamento Inicial

- Container WebView para YMS Axioma
- Acesso ao módulo do motorista
- Autenticação segura
- Cache desabilitado para atualizações em tempo real
- Suporte a Android 8.0 e superior
```

### 5.4 Configurar Preço e Distribuição

1. **Preço:** Selecione "Gratuito"
2. **Distribuição:** Selecione os países onde o app será disponível
3. **Classificação de conteúdo:** Complete o questionário

### 5.5 Revisar e Enviar

1. Revise todas as informações
2. Clique em **Enviar para revisão**
3. Aguarde a revisão do Google (geralmente 2-4 horas)

---

## 📊 Passo 6: Monitorar e Manter

### 6.1 Acompanhar Revisão

No Google Play Console, você pode:

- Ver status da revisão em tempo real
- Receber notificações por email
- Acessar relatórios de instalações

### 6.2 Atualizar o App

Para lançar uma nova versão:

1. Incremente `versionCode` e `versionName` em `android/app/build.gradle`
2. Compile a nova versão: `./gradlew bundleRelease`
3. Faça upload na Play Store
4. Escreva notas de versão descrevendo as mudanças

### 6.3 Monitorar Crashes e Performance

No Google Play Console, acesse:

- **Vitals:** Monitore crashes, ANRs (travamentos)
- **Análise:** Veja dados de usuários, dispositivos, países
- **Avaliações:** Responda aos comentários dos usuários

---

## 🔄 Atualizações em Tempo Real

O aplicativo foi configurado para sempre refletir dados atualizados:

### Como Funciona

1. **Cache Desabilitado:** O WebView nunca armazena em cache
2. **URL Remota:** Sempre acessa `https://yms.axioma-dados.com.br`
3. **localStorage:** Mantém autenticação entre sessões
4. **Service Worker:** Respeitado se implementado no servidor

### Forçar Atualização

Os usuários podem forçar atualização:

```
1. Abrir o app
2. Pressionar Ctrl+Shift+Delete (ou Menu > Limpar Cache)
3. Reabrir o app
```

---

## 🛠️ Troubleshooting

### Problema: "Build falha com erro de Gradle"

**Solução:**

```bash
cd android
./gradlew clean
./gradlew build
```

### Problema: "APK não instala no dispositivo"

**Verificar:**

1. Versão mínima do Android (API 26+)
2. Espaço disponível no dispositivo
3. Permissões de instalação habilitadas

```bash
adb uninstall com.axioma.yms  # Remover versão anterior
adb install app-release.apk    # Instalar nova versão
```

### Problema: "WebView não carrega a URL"

**Verificar:**

1. Conexão de internet no dispositivo
2. URL em `capacitor.config.ts` está correta
3. Certificado SSL do servidor é válido

```bash
# Testar conectividade
adb shell ping yms.axioma-dados.com.br
```

### Problema: "Erro de assinatura no build release"

**Solução:**

1. Verifique se `keystore.properties` existe
2. Confirme senhas estão corretas
3. Regenere o keystore se necessário

```bash
keytool -list -v -keystore yms-axioma-release.keystore
```

---

## 📋 Checklist de Publicação

Antes de enviar para a Play Store, verifique:

- [ ] APK/AAB compila sem erros
- [ ] App funciona em emulador/dispositivo
- [ ] Login de motorista funciona
- [ ] Navegação entre telas funciona
- [ ] Dados carregam corretamente
- [ ] Certificado de assinatura está válido
- [ ] Ícone do app está visível
- [ ] Descrição do app está completa
- [ ] Notas de versão estão preenchidas
- [ ] Classificação de conteúdo foi selecionada

---

## 📞 Suporte e Contato

Para dúvidas sobre o build ou publicação:

1. **Documentação Capacitor:** https://capacitorjs.com/docs
2. **Google Play Console Help:** https://support.google.com/googleplay/android-developer
3. **Android Studio Documentation:** https://developer.android.com/studio/intro

---

## 📝 Histórico de Versões

| Versão | Data | Alterações |
|--------|------|-----------|
| 1.0 | 26/04/2026 | Lançamento inicial - Container WebView para YMS Axioma |

---

**Documento preparado por:** Manus AI  
**Última atualização:** 26 de abril de 2026  
**Compatibilidade:** Android 8.0 (API 26) e superior

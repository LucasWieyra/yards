#!/bin/bash

# Script de Início Rápido - YMS Axioma Android

echo "🚀 YMS Axioma - Início Rápido"
echo "=============================="
echo ""

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não está instalado"
    exit 1
fi

echo "✅ Node.js: $(node --version)"

# Verificar Java
if ! command -v java &> /dev/null; then
    echo "❌ Java não está instalado"
    exit 1
fi

echo "✅ Java: $(java -version 2>&1 | head -1)"

# Instalar dependências
echo ""
echo "📦 Instalando dependências..."
npm install --legacy-peer-deps

# Compilar projeto
echo ""
echo "🔨 Compilando projeto web..."
npm run build

# Sincronizar Capacitor
echo ""
echo "🔄 Sincronizando com Android..."
npx cap sync android

echo ""
echo "✅ Pronto!"
echo ""
echo "Próximos passos:"
echo "1. Abra Android Studio: open android/"
echo "2. Conecte um dispositivo ou inicie um emulador"
echo "3. Clique em Run (▶️) para compilar e instalar"
echo ""
echo "Para mais informações, consulte:"
echo "- README_ANDROID.md"
echo "- CAPACITOR_SETUP.md"
echo "- ANDROID_BUILD_GUIDE.md"

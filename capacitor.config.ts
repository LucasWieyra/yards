import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.axioma.yms',
  appName: 'YMS Axioma',
  webDir: 'dist',
  server: {
    url: 'https://yms.axioma-dados.com.br',
    cleartext: false,
    allowNavigation: ['yms.axioma-dados.com.br', '*.axioma-dados.com.br', 'localhost', '127.0.0.1']
  },
  android: {
    allowMixedContent: false,
    webViewDebuggingEnabled: false,
    captureInput: true,
    handleVolumeButton: true
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 3000,
      launchAutoHide: true,
      backgroundColor: '#1a1a1a',
      androidSpin: true,
      androidSpinColor: '#ffffff'
    },
    App: {
      // Permite que o app feche ao pressionar voltar
    }
  }
};

export default config;

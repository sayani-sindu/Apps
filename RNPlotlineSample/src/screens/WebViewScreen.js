import React, { useRef } from 'react';
import { SafeAreaView, StyleSheet, Alert } from 'react-native';
import { WebView } from 'react-native-webview';
import { HTML } from './web/shopHtml';

export default function WebViewScreen() {
  const webRef = useRef(null);

  const onMessage = (e) => {
    console.log('From web:', e.nativeEvent.data);   // shows in Metro terminal
    Alert.alert('WebView tap', e.nativeEvent.data);
  };

  return (
    <SafeAreaView style={styles.container}>
      <WebView
        ref={webRef}
        originWhitelist={['*']}
        source={{ html: HTML, baseUrl: 'https://app.plotline.so/' }}
        onMessage={onMessage}
        javaScriptEnabled
        domStorageEnabled
        onConsoleMessage={(e) => console.log('[WebView console]', e.nativeEvent.data)}
        onError={(e) => console.log('[WebView error]', e.nativeEvent)}
        onHttpError={(e) => console.log('[WebView HTTP error]', e.nativeEvent.statusCode, e.nativeEvent.description)}
        onLoadEnd={() => console.log('[WebView] load finished')}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({ container: { flex: 1 } });
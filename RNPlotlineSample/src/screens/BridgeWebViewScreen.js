import React, { useRef } from 'react';
import { SafeAreaView, View, Button, StyleSheet, Alert } from 'react-native';
import { WebView } from 'react-native-webview';
import { HTML } from './web/bridgeHTML';

export default function BridgeWebViewScreen() {
  const webRef = useRef(null);

  // RN -> Web: push a message into the page
  const sendToWeb = () => {
    const payload = JSON.stringify({ type: 'FROM_RN', user: 'sindu_test', ts: Date.now() });
    webRef.current?.injectJavaScript(`window.onNativeMessage(${payload}); true;`);
  };

  // Web -> RN: receive messages from the page
  const onMessage = (event) => {
    const data = event.nativeEvent.data;
    console.log('Message from web:', data);
    try {
      const parsed = JSON.parse(data);
      // e.g. route a Plotline-style action, track an event, navigate, etc.
      Alert.alert('From WebView', JSON.stringify(parsed));
    } catch {
      Alert.alert('From WebView', data);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <WebView
        ref={webRef}
        originWhitelist={['*']}
        source={{ html: HTML }}
        onMessage={onMessage}
        javaScriptEnabled
        domStorageEnabled
      />
      <View style={styles.bar}>
        <Button title="Send data to web →" onPress={sendToWeb} />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  bar: { padding: 12, borderTopWidth: 1, borderTopColor: '#eee' },
});
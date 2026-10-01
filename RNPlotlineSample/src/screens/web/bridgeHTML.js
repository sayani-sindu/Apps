export const HTML = `
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body { font-family: -apple-system, Roboto, sans-serif; padding: 20px; background: #4C1D95; color: #fff; }
    h2 { margin-top: 0; }
    button { background:#fff; color:#4C1D95; border:0; padding:12px 16px; border-radius:10px; font-size:16px; font-weight:700; }
    #log { margin-top:16px; background:rgba(255,255,255,0.12); padding:12px; border-radius:10px; min-height:60px; white-space:pre-wrap; }
  </style>
</head>
<body>
  <h2>Plotline WebView Bridge</h2>
  <p>Tap to send a message to the React Native app.</p>
  <button onclick="sendToRN()">Send to RN →</button>
  <div id="log">Waiting…</div>

  <script>
    // Web -> RN
    function sendToRN() {
      const msg = { type: 'FROM_WEB', action: 'checkout', amount: 499 };
      window.ReactNativeWebView.postMessage(JSON.stringify(msg));
      log('Sent to RN: ' + JSON.stringify(msg));
    }

    // RN -> Web (called via injectJavaScript)
    window.onNativeMessage = function (data) {
      log('Received from RN: ' + JSON.stringify(data));
    };

    function log(t) { document.getElementById('log').textContent = t; }
  </script>
</body>
</html>
`;
package com.example.demoapplication;

import android.os.Bundle;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONObject;
import so.plotline.insights.Plotline;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;


public class WebActivity extends AppCompatActivity {

    private WebView webView;

    public static final String EXTRA_PAGE = "page"; // "students.html" or "course.html"

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_web);

        webView = findViewById(R.id.webView);
        WebView.setWebContentsDebuggingEnabled(true);


        // 1. Enable JavaScript + local storage (Plotline needs both)
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setDomStorageEnabled(true);

        // Keep navigation inside the WebView
        webView.setWebViewClient(new WebViewClient());

        // 2. Expose the JS bridge BEFORE loadUrl
        webView.addJavascriptInterface(new PlotlineNativeBridge(), "PlotlineNative");

        // 3. Decide which page to load (defaults to students.html)
        String page = getIntent().getStringExtra(EXTRA_PAGE);
        if (page == null) {
            page = "students.html";
        }

        loadAssetPage(page);
        //webView.loadUrl("http://10.0.2.2:5173");
        // 4. Hand the WebView over to Plotline for nudge/widget targeting
        Plotline.setWebView(webView);
    }

    private void loadAssetPage(String page) {
        try {
            InputStream is = getAssets().open(page);
            byte[] buffer = new byte[is.available()];
            is.read(buffer);
            is.close();
            String html = new String(buffer, StandardCharsets.UTF_8);
            html = html.replace("__PLOTLINE_API_KEY__", BuildConfig.PLOTLINE_API_KEY);
            webView.loadDataWithBaseURL("file:///android_asset/", html, "text/html", "UTF-8", null);
        } catch (Exception e) {
            e.printStackTrace();
            webView.loadUrl("file:///android_asset/" + page);
        }
    }

    @Override
    protected void onDestroy() {
        Plotline.setWebView(null);
        super.onDestroy();
    }

    /**
     * JS -> Native bridge
     */
    public class PlotlineNativeBridge {

        @JavascriptInterface
        public void track(String eventName, String propertiesJson) {
            JSONObject props;

            try {
                props = new JSONObject(propertiesJson);
            } catch (Exception e) {
                props = new JSONObject();
            }

            Plotline.track(eventName, props);
        }

        @JavascriptInterface
        public void identify(String attributesJson) {
            JSONObject attrs;

            try {
                attrs = new JSONObject(attributesJson);
            } catch (Exception e) {
                attrs = new JSONObject();
            }


        }
    }
}

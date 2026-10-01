import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:plotline_engage/plotline.dart'; // optional, for trackPage

class WebViewScreen extends StatefulWidget {
  static const routeName = '/webview';

  final String title;
  const WebViewScreen({super.key, this.title = 'Local WebView'});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    Plotline.trackPage('WebView', context); // optional

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // needed for the button's JS
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p),
          onPageStarted: (_) => setState(() => _progress = 0),
          onPageFinished: (_) => setState(() => _progress = 100),
          onWebResourceError: (err) =>
              debugPrint('WebView error: ${err.description}'),
        ),
      );

    _loadPage();
  }

  Future<void> _loadPage() async {
    try {
      final html = await rootBundle.loadString('assets/sample.html');
      final key = dotenv.env['PLOTLINE_API_KEY'] ?? '';
      final processed = html.replaceAll('__PLOTLINE_API_KEY__', key);
      await _controller.loadHtmlString(processed);
    } catch (e) {
      debugPrint('WebView load error: $e');
      await _controller.loadFlutterAsset('assets/sample.html');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
        bottom: _progress < 100
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(value: _progress / 100),
              )
            : null,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
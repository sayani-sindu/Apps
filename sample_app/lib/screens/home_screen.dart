import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';
import 'package:plotline_engage/plotline_widget.dart';

import 'web_view_screen.dart';

/// Simple counter demo screen using setState.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    Plotline.trackPage('Home', context); // PLOTLINE
    Plotline.track('home_view');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(                     // <-- allows content to scroll
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlotlineWidget(valueKey: "native1"),
            PlotlineWidget(valueKey: "native2"),
            PView(child: const Text('Welcome to the sample app'), valueKey: "welcome"),
            const SizedBox(height: 8),
            PView(child: Text('You tapped $_count times', style: Theme.of(context).textTheme.titleMedium), valueKey: "num_times"),
            const SizedBox(height: 16),
            PView(child: FilledButton.icon(
              onPressed: () {
                Plotline.track("button_tapped", properties: {'tap_count': _count});
                setState(() => _count++);
              },
              icon: const Icon(Icons.add),
              label: const Text('Tap me'),
            ), valueKey: "tap_me"),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(title: 'Local Page'),
                  ),
                );
              },
              icon: const Icon(Icons.public),
              label: const Text('Open WebView'),
            ),
          ],
        ),
      ),
    );
  }
}
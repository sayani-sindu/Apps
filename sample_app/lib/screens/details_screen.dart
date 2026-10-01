import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';
import 'package:plotline_engage/plotline_widget.dart';

/// Plain data model passed as a route argument.
class FeedItem {
  final int id;
  final String title;
  final String subtitle;

  const FeedItem({required this.id, required this.title, required this.subtitle});
}

/// Details screen shown when a feed item is tapped.
class DetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  final FeedItem item;

  const DetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Plotline.trackPage('Details', context);
    Plotline.track('details_viewed');
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlotlineWidget(valueKey: "native4"),
            Text('ID: ${item.id}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(item.subtitle),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to feed'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';
import 'package:plotline_engage/plotline_widget.dart';


import 'details_screen.dart';

/// A list feed. Tapping an item navigates to Details via a named route.
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  List<FeedItem> get _items => List.generate(
        20,
        (i) => FeedItem(id: i, title: 'Item #$i', subtitle: 'Tap to see details for item $i'),
      );

  @override
Widget build(BuildContext context) {
  Plotline.trackPage('Feed', context);
  final items = _items;
  return Column(
    children: [
      const PlotlineWidget(valueKey: "native3"), 
      Expanded(
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${item.id}')),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Plotline.track('feed_item_clicked', properties: {
                  "item_id": item.id,
                  "title": item.title,
                });
                Navigator.pushNamed(context, DetailsScreen.routeName, arguments: item);
              },
            );
          },
        ),
      ),
    ],
  );
}
}
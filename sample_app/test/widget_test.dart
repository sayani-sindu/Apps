import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample_app/main.dart';

void main() {
  testWidgets('Home counter increments', (WidgetTester tester) async {
    await tester.pumpWidget(const SampleApp());

    expect(find.text('You tapped 0 times'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('You tapped 1 times'), findsOneWidget);
  });
}

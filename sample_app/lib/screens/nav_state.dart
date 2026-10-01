import 'package:flutter/material.dart';

// Holds which tab RootNav should show. The listener writes to it, RootNav listens.
final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

// Map dashboard 'screen' values -> tab index (order must match RootNav)
const Map<String, int> tabIndex = {
  'home': 0,
  'feed': 1,
  'profile': 2,
  'settings': 3,
};
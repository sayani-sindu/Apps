import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';

import 'home_screen.dart';
import 'feed_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'nav_state.dart';

/// Hosts the four bottom-navigation tabs and swaps the body via setState.
class RootNav extends StatefulWidget {
  static const routeName = '/';

  const RootNav({super.key});

  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _index = 0;

  static const _tabs = <Widget>[
    HomeScreen(),
    FeedScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  static const _titles = <String>['Home', 'Feed', 'Profile', 'Settings'];

  @override
  void initState() {
    super.initState();
    // PLOTLINE: when the redirect listener changes the tab, switch here
    selectedTab.addListener(_onSelectedTabChanged);

    // track the first tab shown when the app opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Plotline.trackPage(_titles[_index], context); // PLOTLINE
    });
  }

  @override
  void dispose() {
    selectedTab.removeListener(_onSelectedTabChanged); // PLOTLINE: clean up
    super.dispose();
  }

  // PLOTLINE: called when a redirect sets selectedTab.value
  void _onSelectedTabChanged() {
    setState(() => _index = selectedTab.value);
    Plotline.trackPage(_titles[_index], context);
  }

  void _onTap(int i) {
    selectedTab.value = i;          // PLOTLINE: keep notifier in sync with manual taps
    setState(() => _index = i);
    Plotline.trackPage(_titles[i], context); // PLOTLINE: re-track on tab switch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: _tabs[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.dynamic_feed_outlined), selectedIcon: Icon(Icons.dynamic_feed), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
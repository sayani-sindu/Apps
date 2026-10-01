import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';

/// Settings screen with a couple of toggles using setState.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    Plotline.trackPage('settings', context); // PLOTLINE
  }

void _onNotificationsToggled(bool enabled) {
  Plotline.track('notifications_toggled', properties: {"enabled": enabled}); // PLOTLINE event
  Plotline.identify({"notifications_enabled": enabled});                      // PLOTLINE attribute
}
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Notifications'),
          subtitle: const Text('Receive push notifications'),
          value: _notifications,
          onChanged: (v){
            _onNotificationsToggled(true);
            setState(() => _notifications = v);
          } 
        ),
        SwitchListTile(
          title: const Text('Dark mode'),
          subtitle: const Text('Use a dark theme'),
          value: _darkMode,
          onChanged: (v) => setState(() => _darkMode = v),
        ),
        const AboutListTile(
          icon: Icon(Icons.info_outline),
          applicationName: 'Sample App',
          applicationVersion: '1.0.0',
        ),
      ],
    );
  }
}

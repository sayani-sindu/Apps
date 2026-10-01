import 'dart:ui'; // for ImageFilter (blur)
import 'package:flutter/material.dart';
import 'package:plotline_engage/plotline.dart';
import 'package:plotline_engage/plotline_widget.dart';

/// Static profile screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _saveProfile() {
    Plotline.identify({
      "name": "Sindu",
      "plan": "premium",
      "email": "sindu@example.com",
    });
    Plotline.track('profile_updated');
  }

  void _showBlurredBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,          // allows a full-height child
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,  // we render our own blurred barrier
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6), // blurs the whole screen behind
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                // Transparent tap-to-dismiss area (keeps the top blurred)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox.expand(),
                  ),
                ),
                // Actual bottom sheet content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Text(
                        'This is a bottom sheet',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Plotline.trackPage('Profile', context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PlotlineWidget(valueKey: "native1"),
        const Center(
          child: CircleAvatar(
            radius: 44,
            child: Icon(Icons.person, size: 44),
          ),
        ),
        const SizedBox(height: 16),
        const Center(child: Text('Jane Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Center(child: Text('jane.doe@example.com')),
        const SizedBox(height: 24),
        const ListTile(leading: Icon(Icons.badge_outlined), title: Text('User ID'), subtitle: Text('user_123')),
        const ListTile(leading: Icon(Icons.phone_outlined), title: Text('Phone'), subtitle: Text('+1 555 0100')),
        const ListTile(leading: Icon(Icons.location_on_outlined), title: Text('Location'), subtitle: Text('San Francisco, CA')),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _saveProfile,
          icon: const Icon(Icons.save),
          label: const Text('Save profile'),
        ),
        const SizedBox(height: 8),
        // New button that opens the blurred bottom sheet
        OutlinedButton.icon(
          onPressed: () => _showBlurredBottomSheet(context),
          icon: const Icon(Icons.vertical_align_bottom),
          label: const Text('Open bottom sheet'),
        ),
      ],
    );
  }
}
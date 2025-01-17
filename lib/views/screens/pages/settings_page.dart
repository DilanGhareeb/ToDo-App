import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/controllers/notifiers/theme_notifier.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode ??
                  false, // Replace this with your theme toggle state
              onChanged: (bool value) {
                ref.read(themeNotifierProvider.notifier).toggleDarkMode(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

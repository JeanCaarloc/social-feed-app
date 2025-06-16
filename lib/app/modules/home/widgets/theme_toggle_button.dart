import 'package:flutter/material.dart';
import 'package:social_feed_app/main.dart';
import '../../../stores/theme_store.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeStore.themeMode,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () => themeStore.toggleTheme(),
        );
      },
    );
  }
}

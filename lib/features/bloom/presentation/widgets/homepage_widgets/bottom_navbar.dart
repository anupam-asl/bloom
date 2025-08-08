import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color!;
    return BottomNavigationBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: theme.colorScheme.secondary,
      unselectedItemColor: iconColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.directions_run_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
      ],
    );
  }
}

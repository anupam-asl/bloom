import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color!;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey, // thin gray line
            width: 0.5,         // thickness
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: theme.colorScheme.secondary,
        unselectedItemColor: iconColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icons/home.svg"),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icons/union.svg"),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icons/restaurant-line.svg"),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icons/walk-fill.svg"),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/icons/rest.svg"),
            label: '',
          ),
        ],
      ),
    );
  }

}

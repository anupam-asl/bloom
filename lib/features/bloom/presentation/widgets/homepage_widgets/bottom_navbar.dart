import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/glucose_screen.dart';
import 'package:bloom_health_app/features/bloom/presentation/pages/bloom_home_page.dart';

import '../../../../../core/theme/app_colors.dart';

class BottomNavbar extends StatefulWidget {

  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavbar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      debugPrint("icon index: $index");
      _selectedIndex = index; //  highlight the tapped icon immediately
    });

    // Navigate depending on icon index
    switch (index) {
      case 0:
        debugPrint("home tapped → navigating to BloomHomePage()");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BloomHomePage()),
        );
        break;
      case 1:
        debugPrint("Union tapped → navigating to GlucoseApp()");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GlucoseApp()),
        );
        break;
      case 2:
        debugPrint("Restaurant tapped");
        break;
      case 3:
        debugPrint("Walk tapped");
        break;
      case 4:
        debugPrint("Rest tapped");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color!;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey, // thin gray line
            width: 0.5, // thickness
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: theme.colorScheme.secondary,
        unselectedItemColor: iconColor,
        currentIndex: _selectedIndex,        // controls highlight
        onTap: _onItemTapped,                //  updates selected index
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/images/icons/home.svg"
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/images/icons/union.svg"),

            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/images/icons/restaurant-line.svg"),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/images/icons/walk-fill.svg"
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "assets/images/icons/rest.svg"),
            label: '',
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:uniapp/uitls/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      indicatorColor: primaryColor,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_sharp),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Icon(Icons.messenger_sharp),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: Icon(Icons.perm_device_information_outlined),
          label: 'Profile',
        ),
      ],
    );
    ;
  }
}

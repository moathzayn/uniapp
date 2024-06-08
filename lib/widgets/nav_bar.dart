import 'package:flutter/material.dart';
import 'package:uniapp/uitls/colors.dart';
import 'package:uniapp/widgets/post.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return const NavigationMainBar();
  }
}

class NavigationMainBar extends StatefulWidget {
  const NavigationMainBar({super.key});

  @override
  State<NavigationMainBar> createState() => _NavigationMainBarState();
}

class _NavigationMainBarState extends State<NavigationMainBar> {
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
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.perm_device_information_outlined),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

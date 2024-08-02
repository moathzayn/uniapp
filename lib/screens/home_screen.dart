import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/Providers/user_provider.dart';
import 'package:uniapp/screens/add_post_screen.dart';
import 'package:uniapp/screens/chat_screen.dart';
import 'package:uniapp/screens/explore_screen.dart';
import 'package:uniapp/screens/profile_screen.dart';
import 'package:uniapp/uitls/colors.dart';
import 'package:uniapp/screens/feed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String username = "";
  @override
  void initState() {
    super.initState();
    getUsername();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['uid'];
    });
    print('uid for user' + username);
  }

  int currentPageIndex = 0;
  final _pages = [
    FeedScreen(uid: username),
    const AddPostScreen(),
    const ExploreScreen(),
    ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
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
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

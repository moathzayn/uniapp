import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //User user = Provider.of<UserProvider>(context).getUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.person))],
      ),
    );
  }
}

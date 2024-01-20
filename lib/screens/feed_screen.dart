import 'package:flutter/material.dart';

class feedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Icon(Icons.send)]),
      body: Center(
        child: Text(
          'feed Page',
          style: TextStyle(fontSize: 50.0),
        ),
      ),
    );
  }
}

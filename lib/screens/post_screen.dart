import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/uitls/utils.dart';

class PostScreen extends StatefulWidget {
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var PostSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('s'),
    );
  }
}

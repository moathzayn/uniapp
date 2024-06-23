import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/Providers/user_provider.dart';
import 'package:uniapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/resources/firestore_methods.dart';
import 'package:uniapp/widgets/feed/comment_card.dart';

class Comments extends StatefulWidget {
  final snap;
  const Comments({Key? key, required this.snap}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return IconButton(
      icon: Icon(Icons.comment),
      onPressed: () {
        showModalBottomSheet<void>(
          shape: Border(top: BorderSide.none),
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Comments',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.snap['postId'])
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) => CommentCard(
                            snap:
                                (snapshot.data! as dynamic).docs[index].data()),
                      );
                    },
                  )),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 5, 5, 5),
                        child: Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            user.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Comment as ${user.username}',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FirestoreMethods().postComment(
                            widget.snap['postId'],
                            _commentController.text,
                            user.uid,
                            user.username,
                            user.photoUrl,
                          );
                          setState(() {
                            _commentController.text = "";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: const Text('Post'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

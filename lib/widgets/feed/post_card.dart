import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/Providers/user_provider.dart';
import 'package:uniapp/models/user.dart' as model;
import 'package:uniapp/resources/firestore_methods.dart';
import 'package:uniapp/uitls/colors.dart';
import 'package:uniapp/uitls/utils.dart';
import 'package:uniapp/widgets/feed/comments.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});
  @override
  Widget build(BuildContext context) {
    deletePost(String postId) async {
      try {
        await FirestoreMethods().deletePost(postId);
      } catch (err) {
        showSnackBar(
          context,
          err.toString(),
        );
      }
    }

    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                        child: Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            snap['profileImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Text(snap['username'],
                            style: const TextStyle(
                                fontSize: 18, letterSpacing: 0)),
                      ),
                    ],
                  ),
                ],
              ),
              snap['uid'].toString() == user.uid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                            onTap: () {
                                              deletePost(
                                                snap['postId'].toString(),
                                              );
                                              // remove the dialog box
                                              Navigator.of(context).pop();
                                            }),
                                      )
                                      .toList()),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    )
                  : Container(),
            ],
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onDoubleTap: () async {},
          child: ClipRRect(
            child: Image.network(
              snap['postUrl'],
              width: double.infinity,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    snap['description'],
                    style: const TextStyle(fontSize: 18, letterSpacing: 0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 5, 0),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
                Comments(snap: snap),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.share_outlined,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

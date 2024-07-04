import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/Providers/user_provider.dart';
import 'package:uniapp/models/user.dart' as model;
import 'package:uniapp/resources/firestore_methods.dart';
import 'package:uniapp/screens/profile_screen.dart';
import 'package:uniapp/uitls/colors.dart';
import 'package:uniapp/uitls/utils.dart';
import 'package:uniapp/widgets/feed/comments.dart';
import 'package:uniapp/widgets/feed/like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
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
    final String uid = widget.snap['uid'];
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
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          uid: (widget.snap! as dynamic)['uid'],
                        ),
                      ),
                    ),
                    child: Row(
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
                              widget.snap['profileImage'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Text(widget.snap['username'],
                              style: const TextStyle(
                                  fontSize: 18, letterSpacing: 0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              widget.snap['uid'].toString() == user.uid
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
                                                widget.snap['postId']
                                                    .toString(),
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
        GestureDetector(
          onDoubleTap: () async {
            FirestoreMethods().likePost(
              widget.snap['postId'].toString(),
              user.uid,
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(alignment: Alignment.center, children: [
            ClipRRect(
              child: Image.network(
                widget.snap['postUrl'],
                width: double.infinity,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isLikeAnimating ? 1 : 0,
              child: LikeAnimation(
                isAnimating: isLikeAnimating,
                duration: const Duration(
                  milliseconds: 400,
                ),
                onEnd: () {
                  setState(() {
                    isLikeAnimating = false;
                  });
                },
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
          ]),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.snap['description'],
                    style: const TextStyle(fontSize: 18, letterSpacing: 0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                          ),
                    onPressed: () => FirestoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user.uid,
                      widget.snap['likes'],
                    ),
                  ),
                ),
                Comments(snap: widget.snap),
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

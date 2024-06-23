import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final snap;
  CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
          child: Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                snap['profilePic'],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: snap['name'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              RichText(
                softWrap: false,
                text: TextSpan(
                  text: snap['text'],
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uniapp/uitls/colors.dart';
import 'package:uniapp/widgets/comments.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
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
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Text(snap['username'],
                    style: const TextStyle(fontSize: 18, letterSpacing: 0)),
              ),
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
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: Text(
                      snap['description'],
                      style: const TextStyle(fontSize: 18, letterSpacing: 0),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 5, 0),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Comments(),
                ),
                Padding(
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

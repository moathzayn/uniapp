import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: SearchAnchor.bar(
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<Widget>.generate(
            5,
            (int index) {
              return ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Initial list item $index'),
              );
            },
          );
        },
      ),
    ));
  }
}

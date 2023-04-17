import 'package:flutter/material.dart';
import 'creator_drawer.dart';

class CreatorView extends StatelessWidget {
  static const routeName = '/creatorView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Info'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}

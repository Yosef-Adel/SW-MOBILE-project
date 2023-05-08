import 'package:flutter/material.dart';
import 'creator_drawer.dart';

class CreatorPublish extends StatelessWidget {
  static const routeName = '/creatorPublish';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish'),
      ),
      drawer: CreatorDrawer(),
      body: Container(),
    );
  }
}

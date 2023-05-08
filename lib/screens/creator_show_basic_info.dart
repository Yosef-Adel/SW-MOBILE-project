import 'package:envie_cross_platform/screens/creator_drawer.dart';
import 'package:flutter/material.dart';

class CreatorShowBasicInfo extends StatelessWidget {
  static const routeName = '/creator-show-basic-info';

  const CreatorShowBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("CreatorShowBasicInfo"),
      drawer: CreatorDrawer(),
    );
  }
}

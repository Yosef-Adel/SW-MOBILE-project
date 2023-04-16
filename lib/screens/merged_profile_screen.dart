import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/user_provider.dart';
import 'pre_login_screen.dart';
import 'user_profile_screen.dart';

class MergedProfileScreen extends StatelessWidget {
  const MergedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    return userProv.isAuth? UserProfileScreen() : PreLoginScreen();
  }
}

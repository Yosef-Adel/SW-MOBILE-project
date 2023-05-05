import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'shared_preferences.dart';

//Logout function
void logout(BuildContext context) async {
  Provider.of<UserProvider>(context, listen: false).isAuth = false;
  Provider.of<UserProvider>(context, listen: false).token = null;

  //Editted by Hla
  clearUserData();
}

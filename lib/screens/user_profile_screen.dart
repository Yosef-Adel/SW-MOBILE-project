import 'package:envie_cross_platform/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../requests/logout_api.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  int _likesCount = 50;
  int _ticketsCount = 10;
  int _followingCount = 20;

  void _editUserName() {
    // Code to handle editing the user name goes here
  }

  Widget _buildCountColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    bool? isCreator = userProv.user.isCreator;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        //_userName,
                        '${userProv.user.firstName} ${userProv.user.lastName}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 46, 112),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Color.fromARGB(255, 2, 46, 112),
                        onPressed: _editUserName,
                      ),
                    ],
                  ),
                  Text(
                    //_email,
                    '${userProv.user.emailAddress}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 46, 112),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildCountColumn('Likes', _likesCount)),
                      const VerticalDivider(),
                      Expanded(child: _buildCountColumn('Tickets', _ticketsCount)),
                      const VerticalDivider(),
                      Expanded(child: _buildCountColumn('Following', _followingCount)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 2, 46, 112),
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 46, 112),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 0.9),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    if (isCreator != null)
                      (isCreator == true)
                          ? () {
                              // Navigator.of(context).pushReplacementNamed(
                              //     CreatorDrawer.routeName);
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'You are not registered as a creator'),
                                ),
                              );
                            };
                  },
                  child: Text('Manage Events'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 0.9),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    //does nothing
                  },
                  child: Text('Account Settings'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 0.9),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    logout(context);
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

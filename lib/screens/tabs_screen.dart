///This screen is the main screen of the app. It contains the bottom navigation bar and the pages that are displayed when the user clicks on the bottom navigation bar.
///The pages are stored in a list of maps. The map contains the page and the title of the page.
///The build method returns a Scaffold widget. The Scaffold widget takes a body widget as an argument. In this case, the body widget is the page that is currently selected.
///The page that is currently selected is determined by the _selectedPageIndex variable.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:envie_cross_platform/providers/user_provider.dart';
import 'landing_screen.dart';
import 'profile_screen.dart';
import 'create_password_screen.dart';
import 'user_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _buildPages(bool isAuth) {
    if (isAuth) {
      _pages = [
        {
          'page': LandingScreen(),
          'title': 'Landing Page',
        },
        {
          'page': CreatePasswordScreen(),
          'title': 'Create Password Page',
        },
        {
          'page': "",
          'title': 'Creators Events Page',
        },
        {
          'page': UserProfileScreen(),
          'title': 'User Profile Page',
        },
      ];
    } else {
      _pages = [
        {
          'page': LandingScreen(),
          'title': 'Landing Page',
        },
        {
          'page': CreatePasswordScreen(),
          'title': 'Create Password Page',
        },
        {
          'page': "",
          'title': 'Creators Events Page',
        },
        {
          'page': ProfileScreen(),
          'title': 'Profile Page',
        },
      ];
    }
  }

  @override
  void didChangeDependencies() {
    final userProvider = Provider.of<UserProvider>(context);
    _buildPages(userProvider.isAuth);
    super.didChangeDependencies();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: _selectedPageIndex,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,
                    color: Color.fromARGB(136, 27, 27, 27)),
                label: '',
                activeIcon: Icon(Icons.home_outlined, color: Color(0xFFD1410C)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_num_outlined,
                    color: Color.fromARGB(136, 27, 27, 27)),
                label: '',
                activeIcon: Icon(Icons.confirmation_num_outlined,
                    color: Color(0xFFD1410C)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event_outlined,
                      color: Color.fromARGB(136, 27, 27, 27)),
                  label: '',
                  activeIcon:
                      Icon(Icons.event_outlined, color: Color(0xFFD1410C))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined,
                      color: Color.fromARGB(136, 27, 27, 27)),
                  label: '',
                  activeIcon:
                      Icon(Icons.person_2_outlined, color: Color(0xFFD1410C))),
            ],
          ),
        ),
      );
    });
  }
}

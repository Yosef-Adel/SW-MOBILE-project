import 'login_screen.dart';
import 'landing_screen.dart';
import 'create_password_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
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
        'page': LoginScreen(),
        'title': 'Profile Page',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}

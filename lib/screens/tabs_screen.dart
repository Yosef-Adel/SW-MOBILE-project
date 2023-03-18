import './landing_screen.dart';
import './signup_screen.dart';
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
      // {
      //   'page': UserTicketsScreen(),
      //   'title': 'Tickets Page',
      // },
      // {
      //   'page': CreatorEventsScreen(),
      //   'title': 'Events Page',
      // },
      {
        'page': SignupScreen(),
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
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color.fromARGB(255, 230, 229, 229),
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

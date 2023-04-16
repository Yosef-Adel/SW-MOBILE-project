import 'tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeFilterEventsScreen extends StatefulWidget {
  const TimeFilterEventsScreen({super.key});
  static const routeName = '/time-filter-events';

  @override
  State<TimeFilterEventsScreen> createState() => _TimeFilterEventsScreenState();
}

class _TimeFilterEventsScreenState extends State<TimeFilterEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('When do you want to go out?'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(children: [
              OutlinedButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(TabsScreen.routeName),
                  child: Text('Today')),
            ]),
          ),
        ],
      ),
    );
  }
}

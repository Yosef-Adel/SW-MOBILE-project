import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tabs_screen.dart';
//import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventbrite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: Color(0xFFD1410C)),
        accentColor: Color.fromRGBO(214, 135, 106, 1),
      ),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
      },
    );
  }
}

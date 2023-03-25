import 'package:envie_cross_platform/screens/filter_events_screen.dart';

import 'providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/event_screen.dart';
import 'screens/create_password_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => EventsProvider(),
      child: MaterialApp(
        title: 'Eventbrite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFD1410C),
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch:
                      generateMaterialColor(color: Color(0xFFD1410C)))
              .copyWith(secondary: Color.fromRGBO(214, 135, 106, 1)),
        ),
        initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => TabsScreen(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          CreatePasswordScreen.routeName: (ctx) => CreatePasswordScreen(),
          EventScreen.routeName: (ctx) => EventScreen(),
          FilterEventsScreen.routeName: (ctx) => FilterEventsScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => TabsScreen(),
          );
        },
      ),
    );
  }
}

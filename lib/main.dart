///This is the main function of the app.
///The main function calls the runApp function and passes the MyApp widget as an argument.
///The MyApp widget is the root of the app. It is a StatelessWidget.
///The build method returns a MaterialApp widget. The MaterialApp widget takes a title, a theme, a home, and a routes argument.
///The title argument is the title of the app. The title is displayed in the app bar of the app.
///The theme argument is the theme of the app. The theme is used to style the app.
///The home argument is the home page of the app. The home page is the first page that is displayed when the app is opened.
///The routes argument is a map of routes. The map contains the route name and the widget that is displayed when the route is called.
///The onUnknownRoute argument is a function that is called when the route that is called is not in the routes map.

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
import 'screens/filter_events_screen.dart';

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

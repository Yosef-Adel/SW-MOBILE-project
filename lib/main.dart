///This is the main function of the app.
///The main function calls the runApp function and passes the MyApp widget as an argument.
///The MyApp widget is the root of the app. It is a StatelessWidget.
///The build method returns a MaterialApp widget. The MaterialApp widget takes a title, a theme, a home, and a routes argument.
///The title argument is the title of the app. The title is displayed in the app bar of the app.
///The theme argument is the theme of the app. The theme is used to style the app.
///The home argument is the home page of the app. The home page is the first page that is displayed when the app is opened.
///The routes argument is a map of routes. The map contains the route name and the widget that is displayed when the route is called.
///The onUnknownRoute argument is a function that is called when the route that is called is not in the routes map.

import 'dart:io';

import 'package:envie_cross_platform/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

import 'providers/categories_provider.dart';
import 'providers/events_provider.dart';
import 'providers/ticket_provider.dart';
import 'requests/my_http_overrides.dart';
import 'screens/check_out_screen.dart';
import 'screens/create_password_screen.dart';
import 'screens/creator_dashboard.dart';
import 'screens/creator_events_screen.dart';
import 'screens/creator_manage_attendees.dart';
import 'screens/creator_publish.dart';
import 'screens/creator_tickets.dart';
import 'screens/event_screen.dart';
import 'screens/filter_events_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/tickets_screen.dart';
import 'screens/time_filter_events_screen.dart';
import 'screens/event_creation_basic_info_screen.dart';
import 'screens/create_event_promocodes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EventsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(value: TicketsProvider()),
        ChangeNotifierProvider.value(
          value: CategoriesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Envie',
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
          '/': (ctx) => LoginScreen(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          CreatePasswordScreen.routeName: (ctx) => CreatePasswordScreen(),
          EventScreen.routeName: (ctx) => EventScreen(),
          FilterEventsScreen.routeName: (ctx) => FilterEventsScreen(),
          TicketsScreen.routeName: (ctx) => TicketsScreen(),
          TimeFilterEventsScreen.routeName: (ctx) => TimeFilterEventsScreen(),
          CreatorEvents.routeName: (ctx) => CreatorEvents(),
          CreatorTickets.routeName: (ctx) => CreatorTickets(),
          CreatorDashboard.routeName: (ctx) => CreatorDashboard(),
          CreatorManageAttendees.routeName: (ctx) => CreatorManageAttendees(),
          CreatorPublish.routeName: (ctx) => CreatorPublish(),
          CheckOutScreen.routeName: (ctx) => CheckOutScreen(),
          EventBasicInfo.routeName: (ctx) => EventBasicInfo(),
          CreateEventPromocodes.routeName: (ctx) => CreateEventPromocodes(),
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

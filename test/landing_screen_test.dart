import 'package:envie_cross_platform/main.dart';
//import 'package:envie_cross_platform/screens/landing_screen.dart';
//import 'package:envie_cross_platform/screens/tabs_screen.dart';
import 'package:envie_cross_platform/screens/filter_events_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Navigate to Filter Events page', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    //   MaterialApp(
    //     home: Scaffold(
    //       body: LandingScreen(),
    //     ),
    //   ),
    // );
    await tester.tap(find.byKey(Key('filtersButton')));
    await tester.pump();
    expect(find.text('I\'m interested in...'), findsOneWidget);
  });
}

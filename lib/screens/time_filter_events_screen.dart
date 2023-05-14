/// This screen is used to filter events by time. It contains a list of time filters that the user can select from.
/// The user can select multiple time filters that are: Anytime, Today, Tomorrow, This Week and This Month.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import '../widgets/time_filter_chip.dart';

class TimeFilterEventsScreen extends StatelessWidget {
  static const routeName = '/time-filter-events';
  final List<String> timeFilter = [
    'Anytime',
    'Today',
    'Tomorrow',
    'This Week',
    'This Month'
  ];
  List<bool> selectedTimeCategories = [false, false, false, false, false];

  void setTimeFilters(BuildContext context) {
    for (int i = 0; i < selectedTimeCategories.length; i++) {
      if (selectedTimeCategories[i] == true) {
        Provider.of<CategoriesProvider>(context, listen: false)
            .selectedTimeCategory = timeFilter[i];
      }
    }
  }

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
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.vertical,
            children: List.generate(
              timeFilter.length,
              (index) {
                return TimeFilterChip(
                    chipName: '${timeFilter[index]}',
                    index: index,
                    selectedTimeCategories: selectedTimeCategories,
                    funcSetTimeFilter: setTimeFilters);
              },
            ),
          ),
        ),
      ),
    );
  }
}

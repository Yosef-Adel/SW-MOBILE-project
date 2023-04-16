///This screen is used to filter the events by category. It is a stateless widget because it does not need to change.
///It uses the Provider package to get the filters from the EventsProvider class.
///It uses the CheckboxListTile widget to display the filters as a list of checkboxes.
///It uses the setAllFilter, setMusicFilter, setFoodAndDrinkFilter, setCharityAndCausesFilter methods from the EventsProvider class to set the filters.
///It uses the clearFilters method from the EventsProvider class to clear the filters.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/categories_provider.dart';
import 'tabs_screen.dart';
import '../providers/events_provider.dart';
import '../widgets/category_filter_chip_widget.dart';

class FilterEventsScreen extends StatelessWidget {
  static const routeName = '/filter-events';

  @override
  Widget build(BuildContext context) {
    final CategoriesProvider data = Provider.of<CategoriesProvider>(context);
    final List<Category> categories = data.allCategories;
    List<bool> selectedCategories = [];
    for (var _ in categories) {
      selectedCategories.add(false);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                data.clearFilters();
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
              icon: Icon(Icons.clear_outlined))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'I\'m interested in...',
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      direction: Axis.horizontal,
                      spacing: 7.0,
                      //runSpacing: 5.0,
                      children: List.generate(
                        categories.length,
                        (index) {
                          return CategoryFilterChip(
                              chipName: '${categories[index].name}',
                              index: index,
                              selectedCategories: selectedCategories);
                        },
                      ),
                    ),
                  ),
           
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CategoriesProvider>(context, listen: false)
                            .setAllFilters(selectedCategories);
                        Navigator.of(context)
                            .pushReplacementNamed(TabsScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.9),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        alignment: Alignment.center,
                      ),
                      child: Text('Apply Filters'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

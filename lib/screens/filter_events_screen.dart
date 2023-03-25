import 'tabs_screen.dart';
import 'package:flutter/material.dart';
import '../providers/events_provider.dart';
import 'package:provider/provider.dart';

class FilterEventsScreen extends StatelessWidget {
  static const routeName = '/filter-events';

  @override
  Widget build(BuildContext context) {
    final filtersData = Provider.of<EventsProvider>(context);
    final filters = filtersData.filters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () => filtersData.clearFilters(),
              icon: Icon(Icons.clear_outlined))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'I\'m interested in...',
                      style: TextStyle(fontSize: 12),
                    )),
                Material(
                  child: CheckboxListTile(
                    title: const Text('All'),
                    value: filtersData.filters['All'],
                    onChanged: (bool? value) =>
                        filtersData.setAllFilter(value!),
                  ),
                ),
                Material(
                  child: CheckboxListTile(
                    title: const Text('Music'),
                    value: filtersData.filters['Music'],
                    onChanged: (bool? value) =>
                        filtersData.setMusicFilter(value!),
                  ),
                ),
                Material(
                  child: CheckboxListTile(
                    title: const Text('Food & Drink'),
                    value: filtersData.filters['FoodAndDrink'],
                    onChanged: (bool? value) =>
                        filtersData.setFoodAndDrinkFilter(value!),
                  ),
                ),
                Material(
                  child: CheckboxListTile(
                    title: const Text('Charity & Causes'),
                    value: filtersData.filters['CharityAndCauses'],
                    onChanged: (bool? value) =>
                        filtersData.setCharityAndCausesFilter(value!),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TabsScreen.routeName);
                    },
                    child: Text('Apply Filters'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      alignment: Alignment.center,
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

import 'package:envie_cross_platform/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class FilterEventsScreen extends StatefulWidget {
  static const routeName = '/filter-events';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterEventsScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterEventsScreenState createState() => _FilterEventsScreenState();
}

class _FilterEventsScreenState extends State<FilterEventsScreen> {
  bool _Music = false;
  bool _FoodAndDrink = false;
  bool _CharityAndCauses = false;

  @override
  initState() {
    _Music = widget.currentFilters['Music']!;
    _FoodAndDrink = widget.currentFilters['FoodAndDrink']!;
    _CharityAndCauses = widget.currentFilters['CharityAndCauses']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  _Music = false;
                  _FoodAndDrink = false;
                  _CharityAndCauses = false;
                });
              },
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
                    title: const Text('Music'),
                    value: _Music,
                    onChanged: (bool? value) {
                      setState(() {
                        _Music = value!;
                      });
                    },
                  ),
                ),
                Material(
                  child: CheckboxListTile(
                    title: const Text('Food & Drink'),
                    value: _FoodAndDrink,
                    onChanged: (bool? value) {
                      setState(() {
                        _FoodAndDrink = value!;
                      });
                    },
                  ),
                ),
                Material(
                  child: CheckboxListTile(
                    title: const Text('Charity & Causes'),
                    value: _CharityAndCauses,
                    onChanged: (bool? value) {
                      setState(() {
                        _CharityAndCauses = value!;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedFilters = {
                        'Music': _Music,
                        'FoodAndDrink': _FoodAndDrink,
                        'CharityAndCauses': _CharityAndCauses,
                      };
                      widget.saveFilters(selectedFilters);
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

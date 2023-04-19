import '../screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class TimeFilterChip extends StatefulWidget {
  final String chipName;
  final int index;
  List<bool> selectedTimeCategories;
  void Function(BuildContext) funcSetTimeFilter;

  TimeFilterChip(
      {required this.chipName,
      required this.index,
      required this.selectedTimeCategories,
      required this.funcSetTimeFilter});

  @override
  _TimeFilterChipState createState() => _TimeFilterChipState();
}

class _TimeFilterChipState extends State<TimeFilterChip> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: true,
      elevation: 0,
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: _isSelected ? Theme.of(context).primaryColor : Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w800,
      ),
      selected: _isSelected,
      backgroundColor: Colors.white,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          widget.selectedTimeCategories[widget.index] = isSelected;
          widget.funcSetTimeFilter(context);
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        });
      },
    );
  }
}

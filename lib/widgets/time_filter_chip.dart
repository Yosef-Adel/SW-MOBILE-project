import 'package:envie_cross_platform/screens/tabs_screen.dart';
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
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.black,
        fontSize: 12.0,
      ),
      selected: _isSelected,
      backgroundColor: Color.fromARGB(255, 192, 200, 231),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          widget.selectedTimeCategories[widget.index] = isSelected;
          widget.funcSetTimeFilter(context);
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          // Provider.of<CategoriesProvider>(context, listen: false)
          //     .updateCategorySelection(widget.index, isSelected);
        });
      },
      selectedColor: Color.fromARGB(255, 64, 94, 211),
    );
  }
}

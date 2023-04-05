/// This is the filter chip widget that is used to display the category filter chips on the event screen.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/events_provider.dart';

class CategoryFilterChip extends StatefulWidget {
  final String chipName;

  CategoryFilterChip({required this.chipName});

  @override
  _CategoryFilterChipState createState() => _CategoryFilterChipState();
}

class _CategoryFilterChipState extends State<CategoryFilterChip> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final filtersData = Provider.of<EventsProvider>(context);
    final filters = filtersData.filters;
    return FilterChip(
      showCheckmark: false,
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: _isSelected ? Colors.white : Colors.black,
        fontSize: 12.0,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color.fromARGB(255, 192, 200, 231),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color.fromARGB(255, 64, 94, 211),
    );
  }
}

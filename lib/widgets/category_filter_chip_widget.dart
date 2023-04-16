/// This is the filter chip widget that is used to display the category filter chips on the event screen.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';
import '../providers/events_provider.dart';

class CategoryFilterChip extends StatefulWidget {
  final String chipName;
  final int index;
  List<bool> selectedCategories;

  CategoryFilterChip(
      {required this.chipName,
      required this.index,
      required this.selectedCategories});

  @override
  _CategoryFilterChipState createState() => _CategoryFilterChipState();
}

class _CategoryFilterChipState extends State<CategoryFilterChip> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
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
          widget.selectedCategories[widget.index] = isSelected;
          // Provider.of<CategoriesProvider>(context, listen: false)
          //     .updateCategorySelection(widget.index, isSelected);
        });
      },
      selectedColor: Color.fromARGB(255, 64, 94, 211),
    );
  }
}

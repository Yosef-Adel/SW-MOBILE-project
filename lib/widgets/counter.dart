import 'package:flutter/material.dart';

class HorizontalCounter extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;

  const HorizontalCounter({
    Key? key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 10,
  }) : super(key: key);

  @override
  _HorizontalCounterState createState() => _HorizontalCounterState();
}

class _HorizontalCounterState extends State<HorizontalCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  void _incrementCount() {
    setState(() {
      if (_count < widget.maxValue) {
        _count++;
      }
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > widget.minValue) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrementCount,
        ),
        Text(
          '$_count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _incrementCount,
        ),
      ],
    );
  }
}
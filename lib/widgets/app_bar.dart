import 'package:flutter/material.dart';
import 'dart:async';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({Key? key, this.initialTime = 20})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + 30), // Set the height of the AppBar
        super(key: key);

  final int initialTime; // The initial time in minutes
  @override
  final Size preferredSize;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  Timer? _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.initialTime * 60;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  String get timerDisplayString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 196, 192, 192))),
      child: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("Checkout"),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Center(
            child: Text(timerDisplayString,
                style: TextStyle(color: Color.fromARGB(255, 126, 124, 124))),
          ),
        ),
      ),
    );
  }
}

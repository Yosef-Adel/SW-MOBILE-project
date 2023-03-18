import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class EventsList extends StatelessWidget {
  final List<Event> _selectedEvents;

  EventsList(this._selectedEvents);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          height: 100,
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: Container(
                width: 70,
                height: 70,
                child: Stack(children: [
                  _selectedEvents[index].isOnline ? Text('Online') : Text(''),
                  Image.asset(_selectedEvents[index].imageUrl,
                      fit: BoxFit.fill),
                ]),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat("d MMM yyyy")
                        .add_jm()
                        .format(_selectedEvents[index].date),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(_selectedEvents[index].title,
                      style: TextStyle(
                        color: Color.fromARGB(255, 72, 72, 72),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(_selectedEvents[index].location,
                      style: TextStyle(
                        color: Color.fromRGBO(72, 72, 72, 0.5),
                        fontSize: 10,
                      )),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _selectedEvents.length,
    );
  }
}

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
                width: 80,
                height: 110,
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: Image.asset(
                    _selectedEvents[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      DateFormat("d MMM yyyy")
                          .add_jm()
                          .format(_selectedEvents[index].date),
                      style: TextStyle(
                          color: Color(0xFFD1410C),
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(_selectedEvents[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bebas',
                      )),
                  Container(
                    child: Text(_selectedEvents[index].location,
                        style: TextStyle(
                          color: Color.fromRGBO(72, 72, 72, 0.5),
                          fontSize: 10,
                        )),
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined, size: 15),
                      Text('3100 creator followers',
                          style: TextStyle(fontSize: 10)),
                      SizedBox(width: 75),
                      Row(
                        children: [
                          Icon(Icons.upload_outlined, size: 15),
                          Icon(Icons.favorite_outlined, size: 15),
                        ],
                      ),
                    ],
                  )
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

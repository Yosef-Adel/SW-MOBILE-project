/// Screen to show basic information of a selected event by the creator

import 'package:envie_cross_platform/models/event.dart';
import 'package:envie_cross_platform/screens/creator_drawer.dart';
import 'package:envie_cross_platform/widgets/events_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/creator_event_provider.dart';

class CreatorShowBasicInfo extends StatelessWidget {
  static const routeName = '/creator-show-basic-info';

  //const CreatorShowBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<CreatorEventProvider>(context, listen: false)
        .selectedEvent!;

    final TextEditingController _eventNameController =
        TextEditingController(text: event.title);
    final TextEditingController _eventDerscriptionController =
        TextEditingController(text: event.summary);
    final TextEditingController _startDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd hh:mm a').format(event.startDate));
    final TextEditingController _endDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd hh:mm a').format(event.endDate));
    final TextEditingController _venueNameController =
        TextEditingController(text: event.venueName);
    final TextEditingController _countryController =
        TextEditingController(text: event.country);
    final TextEditingController _cityController =
        TextEditingController(text: event.city);
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _categoryController =
        TextEditingController(text: event.category);

    //print(event.imageUrl);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            "Basic Info",
            style: TextStyle(
              fontFamily: 'Nexa',
              fontSize: 30,
            ),
          )),
      body: ListView(
        children: [
          Container(
            width: 200,
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  event.imageUrl!,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _eventNameController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Event Title',
                hintText: 'Enter a title',
              ),
            ),
          ),
          SizedBox(height: 30),

          /* event description */
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _eventDerscriptionController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Event summary',
                hintText: 'Enter a description',
              ),
            ),
          ),
          SizedBox(height: 30),

          /* event start date and end date */
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _startDateController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Starts at',
                      hintText: "Tap to select a Date",
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: TextFormField(
                    controller: _endDateController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Ends at',
                      hintText: "Tap to select a Date",
                    ),
                  ),
                ),
              ],
            ),
          ),

          /* event venue name */
          if (!(event.isOnline!)) Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _venueNameController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Venue name',
                hintText: 'Enter a venue',
              ),
            ),
          ),
          if (!(event.isOnline!)) SizedBox(height: 30),

          /*country/city*/
          if (!(event.isOnline!)) Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _countryController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      hintText: "Enter a country",
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: "Enter a city",
                    ),
                  ),
                ),
              ],
            ),
          ),

          // event capacity
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _categoryController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
      drawer: CreatorDrawer(),
    );
  }
}

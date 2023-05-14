///This screen contains a form to allow the creator to enter the basic information needed to create an event.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../requests/creator_create_event.dart';
import '../models/event.dart';
import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'creator_events_screen.dart';

class EventBasicInfo extends StatefulWidget {
  static const routeName = '/event-basic-info';
  @override
  State<EventBasicInfo> createState() => EventBasicInfoState();
}

class EventBasicInfoState extends State<EventBasicInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventSummaryController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _venueNameController =
      TextEditingController(text: "");
  final TextEditingController _countryController =
      TextEditingController(text: "");
  final TextEditingController _cityController = TextEditingController(text: "");
  final TextEditingController _categoryController = TextEditingController();
  File? _image;
  final List<String> dropdownItems = [
    'Music',
    'Food&Drink',
    'Charity&Causes',
    'Art'
  ];
  String selectedDropdownItem = 'Music';
  bool _isOnline = false;

  // void goEventTicketsScreen(BuildContext ctx, String eventId, String promoCode) {
  //   Navigator.of(ctx).pushNamed(//event tickets screen,
  //       arguments: {'eventId': eventId, 'promoCodeId': promoCode});
  // }

  Future<void> _selectDate(
      BuildContext context, TextEditingController input) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );
    if (picked != null) {
      setState(() {
        input.text =
            picked.toString(); // Update the text field with the selected date
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? dateRangeValidator() {
    if (_startDateController.text.isNotEmpty &&
        _endDateController.text.isNotEmpty) {
      DateTime startDate = DateTime.parse(_startDateController.text);
      DateTime endDate = DateTime.parse(_endDateController.text);
      if (startDate.isAfter(endDate)) {
        return 'Start date must be before end date';
      }
    }
    return null;
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter this field';
    }
    return null;
  }

  String? countryValidator(String? value) {
    var numRegex = RegExp(r'^[a-zA-Z]*$');
    if (value == null || value.isEmpty) {
      return 'please enter this field';
    } else if (!numRegex.hasMatch(value)) {
      return "please enter a letter";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String? usrtoken = Provider.of<UserProvider>(context, listen: false).token;
    String? eventId = Provider.of<CreatorEventProvider>(context, listen: false)
        .selectedEventId;
    String? usrId = Provider.of<UserProvider>(context, listen: false).user.id;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            "Create your event",
            style: TextStyle(
              fontFamily: 'Nexa',
              fontSize: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                /* image input widget */
                ListTile(
                  leading: _image != null
                      ? Container(
                          width: 80,
                          height: 110,
                          child: AspectRatio(
                            aspectRatio: 0.5,
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 110,
                          child: AspectRatio(
                            aspectRatio: 0.5,
                            child: Image.network(
                              'https://www.adwanigh.com/media/doctor/2022/3/unnamed8-200x200.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  title: Text('Event Image',
                      style:
                          TextStyle(color: Color.fromARGB(255, 112, 109, 109))),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _pickImage();
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),

                /* event title(name) */
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      hintText: 'Enter a title',
                    ),
                    validator: emptyValidator,
                  ),
                ),
                SizedBox(height: 10),

                /* event description */
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _eventSummaryController,
                      decoration: InputDecoration(
                        labelText: 'Event summary',
                        hintText: 'Enter a summary',
                      ),
                      validator: emptyValidator),
                ),
                SizedBox(height: 10),

                /* event start date and end date */
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: _startDateController,
                            decoration: InputDecoration(
                              labelText: 'Starts at',
                              hintText: "Tap to select a Date",
                            ),
                            validator: (value) {
                              String? dateRangeError = dateRangeValidator();
                              if (dateRangeError != null) {
                                return dateRangeError;
                              }
                              return null;
                            },
                            onTap: () =>
                                _selectDate(context, _startDateController)),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            controller: _endDateController,
                            decoration: InputDecoration(
                              labelText: 'Ends at',
                              hintText: "Tap to select a Date",
                            ),
                            validator: (value) {
                              String? dateRangeError = dateRangeValidator();
                              if (dateRangeError != null) {
                                return dateRangeError;
                              }
                              return null;
                            },
                            onTap: () =>
                                _selectDate(context, _endDateController)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                /*country/city*/
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            labelText: 'Country',
                            hintText: "Enter a country",
                          ),
                          validator: countryValidator,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            labelText: 'City',
                            hintText: "Enter a city",
                          ),
                          validator: countryValidator,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedDropdownItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownItem = newValue!;
                    });
                  },
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: true,
                      groupValue: _isOnline,
                      onChanged: (value) {
                        setState(() {
                          _isOnline = value!;
                        });
                      },
                    ),
                    Text('Online'),
                    SizedBox(width: 4),
                    Radio(
                      value: false,
                      groupValue: _isOnline,
                      onChanged: (value) {
                        setState(() {
                          _isOnline = value!;
                        });
                      },
                    ),
                    Text('Live'),
                  ],
                ),
                SizedBox(height: 10),
                if (!_isOnline)
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _venueNameController,
                      decoration: InputDecoration(
                        labelText: 'Venue name',
                        hintText: 'Enter a venue',
                      ),
                      validator: emptyValidator,
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 221, 200, 200))),
          child: Padding(
            padding: EdgeInsets.only(left: 150.0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.white),
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Event e = new Event(
                            id: "",
                            title: _eventNameController.text,
                            summary: _eventSummaryController.text,
                            isOnline: _isOnline,
                            startDate:
                                DateTime.parse(_startDateController.text),
                            endDate: DateTime.parse(_endDateController.text),
                            category: selectedDropdownItem,
                            price: 0,
                            isPrivate: false,
                            venueName: _venueNameController.text,
                            city: _cityController.text,
                            country: _countryController.text,
                            capacity: 1000,
                          );
                          var values = await createEvent(
                              context, _image, e, usrtoken!, usrId!);
                          eventId = values[0].toString();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(values[1].toString())));
                          String message = values[1].toString();
                          if (message == "Event created successfully") {
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.of(context).pushReplacementNamed(
                                  CreatorEvents.routeName);
                            });
                          }
                        }
                      },
                      child: const Center(
                        child: Text('Create Event'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

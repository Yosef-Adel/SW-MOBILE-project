import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../providers/user_provider.dart';
import '../requests/create_event.dart';

class EventBasicInfo extends StatefulWidget {
  static const routeName = '/event-basic-info';
  @override
  State<EventBasicInfo> createState() => _EventBasicInfoState();
}

class _EventBasicInfoState extends State<EventBasicInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDerscriptionController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  File? _image;
  String _textInput = '';

  // void goEventTicketsScreen(BuildContext ctx, String eventId, String promoCode) {
  //   Navigator.of(ctx).pushNamed(//event tickets screen,
  //       arguments: {'eventId': eventId, 'promoCodeId': promoCode});
  // }

  Future<void> _selectDate(
      BuildContext context, TextEditingController input) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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

  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter this field';
    }
    return null;
  }

  String? _capacityValidator(String? value) {
    var numRegex = RegExp(r'^[1-9][0-9]*$');
    if (value == null || value.isEmpty) {
      return 'please enter this field';
    } else if (!numRegex.hasMatch(value)) {
      return "please enter a number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var usrtoken = Provider.of<UserProvider>(context, listen: false).token;
    String usrId = "123445";
    String? eventId = "";
    usrId = Provider.of<UserProvider>(context, listen: false).user.id!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            "Let's create your event",
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 112, 109, 109))),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _pickImage();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30),

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
                      SizedBox(height: 30),

                      /* event description */
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _eventDerscriptionController,
                            decoration: InputDecoration(
                              labelText: 'Event description',
                              hintText: 'Enter a description',
                            ),
                            validator: emptyValidator),
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
                                  decoration: InputDecoration(
                                    labelText: 'Starts at',
                                    hintText: "Tap to select a Date",
                                  ),
                                  validator: emptyValidator,
                                  onTap: () => _selectDate(
                                      context, _startDateController)),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: TextFormField(
                                  controller: _endDateController,
                                  decoration: InputDecoration(
                                    labelText: 'Ends at',
                                    hintText: "Tap to select a Date",
                                  ),
                                  validator: emptyValidator,
                                  onTap: () =>
                                      _selectDate(context, _endDateController)),
                            ),
                          ],
                        ),
                      ),

                      /* event venue name */
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
                      SizedBox(height: 30),

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
                                validator: emptyValidator,
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: TextFormField(
                                controller: _cityController,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  hintText: "Enter a city",
                                ),
                                validator: emptyValidator,
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
                          decoration: InputDecoration(
                            labelText: 'Category',
                          ),
                          validator: emptyValidator,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                    ]))),
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
                              description: _eventDerscriptionController.text,
                              summary: "summary",
                              imageUrl: _textInput,
                              isOnline: false,
                              startDate:
                                  DateTime.parse(_startDateController.text),
                              endDate: DateTime.parse(_endDateController.text),
                              categoryId: _categoryController.text,
                              price: 0,
                              hostedBy: "hostedBy",
                              isPrivate: false,
                              venueName: _venueNameController.text,
                              city: _cityController.text,
                              country: _countryController.text);
                          print(e.endDate);
                          print(e.title);
                          var values = await createEvent(
                              context, _image, e, usrtoken!, usrId);
                          eventId = values[0].toString();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(values[1].toString())));
                        }
                      },
                      child: const Center(
                        child: Text('Create Event'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 227, 89, 4),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 30.0,
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

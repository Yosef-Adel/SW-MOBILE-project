import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'creator_drawer.dart';

class CreatorPublish extends StatefulWidget {
  static const routeName = '/creatorPublish';

  @override
  State<CreatorPublish> createState() => _CreatorPublishState();
}

class _CreatorPublishState extends State<CreatorPublish> {
  bool _isPrivate = true;
  String _selectedOption = 'Anyone with the link';
  DateTime? _selectedDate;
  final TextEditingController _selectedDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish'),
      ),
      drawer: CreatorDrawer(),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who can see your event?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: _isPrivate,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        _isPrivate = value!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Public'),
                      SizedBox(height: 4.0),
                      Text(
                        'Shared on Eventbrite and search engines',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _isPrivate,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        _isPrivate = value!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Private'),
                      SizedBox(height: 4.0),
                      Text(
                        'Only available to a selected audience',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              if (_isPrivate)
                Text(
                  'Choose your audience:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              if (_isPrivate) SizedBox(height: 10.0),
              if (_isPrivate)
                DropdownButton<String>(
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                  items: <String>[
                    'Anyone with the link',
                    'Only people with the password'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              if (!_isPrivate)
                Text(
                  'When should we publish your event?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              if (!_isPrivate)
                TextFormField(
                  controller: _selectedDateController,
                  decoration: InputDecoration(
                    labelText: 'Publish Date',
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2100, 12, 31),
                      onChanged: (date) {
                        _selectedDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                      theme: DatePickerTheme(
                        doneStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        cancelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid date.';
                    }
                    return null;
                  },
                ),
              if (_isPrivate &&
                  _selectedOption == "Only people with the password")
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        }),
                  ),
                  obscureText:
                      _isPasswordHidden, // added option to hide/show password

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid password.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Publish btn",
        onPressed: () {
          //API call to save the event
          //Navigator.of(context).pop();
        },
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

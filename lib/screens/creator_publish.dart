///This screen is used by the creator to publish an event. It contains the form to fill in the event publishing details.
///The creator can choose to publish the event immediately or schedule it for a later date.
///The creator can also choose to make the event public or private.
///If the creator chooses to make the event private, they can choose to share the event with anyone with the link or only with people who have the password.

import 'package:envie_cross_platform/screens/creator_show_basic_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../requests/creator_publish_event.dart';
import 'creator_drawer.dart';

class CreatorPublish extends StatefulWidget {
  static const routeName = '/creatorPublish';

  @override
  State<CreatorPublish> createState() => CreatorPublishState();
}

class CreatorPublishState extends State<CreatorPublish> {
  bool _isPrivate = false;
  String _selectedOption = 'Anyone with the link';
  DateTime? _selectedDate;
  final TextEditingController _selectedDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isScheduled = false;
  final _formKey = GlobalKey<FormState>();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish'),
      ),
      drawer: CreatorDrawer(),
      body: Form(
        key: _formKey,
        child: Padding(
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
                          'Shared on Envie and search engines',
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
                if (!_isPrivate) SizedBox(height: 10.0),
                if (!_isPrivate)
                  Text(
                    'When should we publish your event?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                if (!_isPrivate)
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: _isScheduled,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _isScheduled = value!;
                          });
                        },
                      ),
                      Text('Publish now'),
                    ],
                  ),
                if (!_isPrivate)
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: _isScheduled,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _isScheduled = value!;
                          });
                        },
                      ),
                      Text('Schedule for later'),
                    ],
                  ),
                if (!_isPrivate && _isScheduled)
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
                        maxTime: DateTime(2030, 12, 31),
                        onConfirm: (date) {
                          _selectedDateController.text =
                              DateFormat('yyyy-MM-dd hh:mm a')
                                  .format(date)
                                  .toString();
                          setState(() {
                            _selectedDate = date;
                          });
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
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Publish btn",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Process data.
            int res = await creatorPublishEvent(
                context,
                _isPrivate,
                _isScheduled,
                !_isScheduled,
                _passwordController.text,
                _selectedDate);

            if (res == 0) {
              bool ret = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Saved Successfully'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
              if (ret)
                Navigator.of(context)
                    .pushReplacementNamed(CreatorShowBasicInfo.routeName);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please fill in all the required fields'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

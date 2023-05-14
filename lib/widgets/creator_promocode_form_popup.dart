/// This file contains the popup form for adding promocodes. It contains the form fields and the methods to save the promocodes.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/promocodes_provider.dart';
import '../requests/creator_create_promocode.dart';
import '../requests/creator_upload_promocodes.dart';
import '../screens/creator_promocodes.dart';
import 'creator_promocode_dropdown.dart';

class PromocodeFormPopup extends StatefulWidget {
  const PromocodeFormPopup({super.key});

  @override
  PromocodeFormPopupState createState() => PromocodeFormPopupState();
}

class PromocodeFormPopupState extends State<PromocodeFormPopup> {
  final _formKey = GlobalKey<FormState>();

  String _selectedOption = 'amount';
  final _nameController = TextEditingController();
  final _amountOffController = TextEditingController();
  final _percentOffController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final _limitController = TextEditingController();
  File? csv;
  final sellingStartDateController = TextEditingController();
  final sellingEndDateController = TextEditingController();

  void _savePromocode(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.isNotEmpty ? _nameController.text : "";
      final limit = int.parse(_limitController.text);
      final amountOff = _amountOffController.text.isNotEmpty
          ? int.parse(_amountOffController.text)
          : -1;
      final percentOff = _percentOffController.text.isNotEmpty
          ? int.parse(_percentOffController.text)
          : -1;
      final startDate = DateTime.parse(sellingStartDateController.text);
      final endDate = DateTime.parse(sellingEndDateController.text);
      final String tickets =
          Provider.of<PromocodesProvider>(context, listen: false)
              .selectedTicket!;
      //print("csv path is: $csv");
      int result;
      (csv == null)
          ? result = await creatorAddPromocode(context, name, tickets,
              percentOff, amountOff, limit, startDate, endDate)
          : result = await creatorUploadPromocodes(context, csv, percentOff,
              amountOff, limit, tickets, startDate, endDate);
      if (result == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Promocode added successfully')));
        Navigator.of(context).pushReplacementNamed(CreatorPromocodes.routeName);
      } else
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error while adding promocode')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the required fields'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _saveCSV() async {
    File? temp = await pickCsvFile();
    if (temp != null)
      setState(() {
        _nameController.text = "";
        csv = temp;
      });
  }

  String? dateRangeValidator() {
    if (startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      DateTime startDate = DateTime.parse(sellingStartDateController.text);
      DateTime endDate = DateTime.parse(sellingEndDateController.text);
      if (startDate.isAfter(endDate)) {
        return 'Start date must be before end date';
      }
    }
    return null;
  }

  String? nameValidator(String? value) {
    if ((value == null || value.isEmpty) && csv == null) {
      return 'Please enter a promocode';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add Promocode'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  enabled: (csv == null) ? true : false,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Promocode Name',
                  ),
                  validator: (value) {
                    if ((value == null || value.isEmpty) && csv == null) {
                      return 'Please enter a promocode';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _limitController,
                  decoration: InputDecoration(
                    labelText: 'Limit',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a limit for the promocode';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid integer value';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a value greater than zero';
                    }
                    return null;
                  },
                ),
                Column(
                  children: [
                    DropdownButtonFormField(
                      value: _selectedOption,
                      items: [
                        DropdownMenuItem(
                          child: Text('Amount'),
                          value: 'amount',
                        ),
                        DropdownMenuItem(
                          child: Text('Percent'),
                          value: 'percent',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _selectedOption == 'amount'
                          ? (_amountOffController)
                          : (_percentOffController),
                      decoration: InputDecoration(
                        labelText: _selectedOption == 'amount'
                            ? 'Amount off (\$)'
                            : 'Percent off (%)',
                        suffixIcon: _selectedOption == 'amount'
                            ? Icon(Icons.attach_money)
                            : Icon(Icons.percent),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid integer value';
                        }
                        if (int.parse(value) <= 0) {
                          return 'Please enter a value greater than zero';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                TextFormField(
                  controller: startDateController,
                  decoration: InputDecoration(
                    labelText: 'Selling Start Date',
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2030, 12, 31),
                      onChanged: (date) {
                        startDateController.text =
                            DateFormat('yyyy-MM-dd hh:mm a')
                                .format(date)
                                .toString();
                        sellingStartDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a selling start date.';
                    }

                    String? dateRangeError = dateRangeValidator();
                    if (dateRangeError != null) {
                      return dateRangeError;
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: endDateController,
                  decoration: InputDecoration(
                    labelText: 'Selling End Date',
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2030, 12, 31),
                      onChanged: (date) {
                        endDateController.text =
                            DateFormat('yyyy-MM-dd hh:mm a')
                                .format(date)
                                .toString();
                        sellingEndDateController.text = date.toString();
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an ending start date.';
                    }
                    String? dateRangeError = dateRangeValidator();
                    if (dateRangeError != null) {
                      return dateRangeError;
                    }
                    return null;
                  },
                ),
                PromoCodeDropDown(),
                ElevatedButton.icon(
                  onPressed: () => _saveCSV(),
                  icon: Icon(Icons.upload_file_outlined),
                  label: Text('Upload CSV'),
                ),
                Visibility(
                    visible: csv != null,
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text('CSV is uploaded'),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => setState(() {
                            csv = null;
                          }),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _savePromocode(context),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

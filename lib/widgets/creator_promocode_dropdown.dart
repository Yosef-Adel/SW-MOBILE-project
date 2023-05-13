///This dropdown is used to display the list of tickets in the promocodes popup screen.

import 'package:envie_cross_platform/providers/promocodes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeDropDown extends StatefulWidget {
  @override
  State<PromoCodeDropDown> createState() => _PromoCodeDropDownState();
}

class _PromoCodeDropDownState extends State<PromoCodeDropDown> {
  @override
  Widget build(BuildContext context) {
    final promoProv = Provider.of<PromocodesProvider>(context, listen: false);
    return DropdownButton<String>(
      value: promoProv.selectedTicket,
      onChanged: (newValue) {
        setState(() {
          promoProv.selectedTicket = newValue!;
        });
      },
      items: (promoProv.ticketsRetrieved).map((item) {
        return DropdownMenuItem<String>(
          value: item.id,
          child: Text(item.name),
        );
      }).toList(),
    );
  }
}

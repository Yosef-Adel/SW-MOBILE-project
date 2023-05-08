import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../requests/routes_api.dart';
import '../providers/user_provider.dart';
import '../widgets/creator_ticket_form_popup.dart';
import 'creator_drawer.dart';

class CreatorTickets extends StatefulWidget {
  static const routeName = '/creatorTickets';

  @override
  CreatorTicketsState createState() => CreatorTicketsState();
}

//tickets class
class TicketClass {
  String name;
  String type;
  double price;
  int capacity;
  int minQuantityPerOrder;
  int maxQuantityPerOrder;
  DateTime sellingStartDate;
  DateTime sellingEndDate;

  TicketClass({
    required this.name,
    required this.type,
    required this.capacity,
    required this.price,
    required this.minQuantityPerOrder,
    required this.maxQuantityPerOrder,
    required this.sellingStartDate,
    required this.sellingEndDate,
  });
}

class CreatorTicketsState extends State<CreatorTickets> {
  late String token;
  late final String eventID = "645415818d0b47c6a89b390e";

  @override
  void initState() {
    super.initState();

    token = Provider.of<UserProvider>(context, listen: false)
        .token!; // initialize token in initState
    print(token);
  }

  // list of classes that is shown
  final List<TicketClass> _ticketClasses = [];

  void _addTicketClass() async {
    final result = await showDialog<TicketClass>(
      context: context,
      builder: (context) => ticketFormPopup(),
    );
    if (result != null) {
      setState(() {
        _ticketClasses.add(result);
      });
    }
  }

  Future<void> sendRequest() async {
    for (var i = 0; i < _ticketClasses.length; i++) {
      final ticketClass = _ticketClasses[i];
      //print(
      //'${ticketClass.name}, ${ticketClass.type}, ${ticketClass.capacity}, ${ticketClass.price}, ${ticketClass.minQuantityPerOrder}, ${ticketClass.maxQuantityPerOrder}, ${ticketClass.sellingStartDate}, ${ticketClass.sellingEndDate}');
      final url =
          Uri.parse('${RoutesAPI.getAllTickets}ticket/${eventID}/createTicket');
      print(url);
      final body = <String, dynamic>{
        'name': ticketClass.name.toString(),
        'type': ticketClass.type.toString(),
        'price': ticketClass.price,
        'capacity': ticketClass.capacity,
        'minQuantityPerOrder': ticketClass.minQuantityPerOrder,
        'maxQuantityPerOrder': ticketClass.maxQuantityPerOrder,
        'salesStart': ticketClass.sellingStartDate.toString(),
        'salesEnd': ticketClass.sellingEndDate.toString(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode != 201) {
        print('Failed');
        final jsonResponse = json.decode(response.body);
        print('${jsonResponse['message']}');
      } else {
        print('successed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Event Tickets'),
      ),
      drawer: CreatorDrawer(),
      body: ListView.builder(
        itemCount: _ticketClasses.length,
        itemBuilder: (context, index) {
          final ticket = _ticketClasses[index];
          return Card(
            child: ListTile(
              title: Text(ticket.name),
              subtitle: Text(
                  '${ticket.type} tickets, Price: \$${ticket.price}, Capacity: ${ticket.capacity}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _ticketClasses.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add Ticket Button",
        onPressed: _addTicketClass,
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 227, 89, 4),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/tickets_list_widget.dart';

class TicketsScreen extends StatelessWidget {
  static const routeName = '/ticket-details';
  final TextEditingController _promoCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final eventTicketDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 1),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Ticket Details',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.white),
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () => {},
          child: const Center(
            child: Text('Register'),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 194, 192, 192),
              width: 1.0,
            ),
          )),
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  eventTicketDetails['eventTitle']!,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(eventTicketDetails['eventDate']!)
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(17),
          child: Card(
            child: Stack(
              children: [
                TextField(
                  controller: _promoCodeController,
                  decoration: InputDecoration(
                    labelText: 'Promo Code',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    hintText: 'Enter code here',
                  ),
                ),
                Positioned(
                  right: 5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 92, 90, 90))),
                    onPressed: () {
                      // Add your apply button logic here
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.7,
          child: TicketInfo(),
        )
      ])),
    );
  }
}
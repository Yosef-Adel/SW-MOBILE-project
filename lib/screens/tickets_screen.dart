import 'package:flutter/material.dart';
import '../widgets/tickets_list_widget.dart';
import 'package:envie_cross_platform/models/ticket.dart';
import 'package:envie_cross_platform/providers/ticket_provider.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import '../requests/check_valid_promo.dart';

class TicketsScreen extends StatefulWidget {
  static const routeName = '/ticket-details';

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _promoCodeController = TextEditingController();
  String _promoCodeId = "";

  void goToCheckOutScreen(BuildContext ctx, String eventId, String promoCode) {
    Navigator.of(ctx).pushNamed(CheckOutScreen.routeName,
        arguments: {'eventId': eventId, 'promoCodeId': promoCode});
  }

  Future<List<Object>> checkPromoCode(
      BuildContext ctx, String promoCode, String eventId) async {
    //print(eventId);
    //print(promoCode);
    List<Object> isPromoCodeValid = await checkPromo(ctx, promoCode, eventId);
    //print(isPromoCodeValid[0]);
    return isPromoCodeValid;
  }


  @override
  Widget build(BuildContext context) {
    final eventTicketDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final countTickets = Provider.of<TicketsProvider>(context).count;
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
          onPressed: () {
            //print(countTickets);
            if (countTickets > 0) {
              goToCheckOutScreen(
                  context, eventTicketDetails['eventId']!, _promoCodeId);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('There are no tickets selected')));
            }
          },
          child: const Center(
            child: Text('Checkout'),
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
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _promoCodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a promocode";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Promo Code',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      hintText: 'Enter code here',
                    ),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final List<Object> isPromoCode = await checkPromo(
                            context,
                            _promoCodeController.text,
                            eventTicketDetails['eventId']);

                        _promoCodeId = isPromoCode[1].toString();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: (isPromoCode[0] == true)
                                ? Text('Promo Code will be applied')
                                : Text('Invalid Promocode')));
                      }
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TicketInfo(eventTicketDetails['eventId']!),
        )
      ])),
    );
  }
}

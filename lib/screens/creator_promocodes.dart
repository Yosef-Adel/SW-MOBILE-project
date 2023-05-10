import 'package:flutter/material.dart';

import '../models/ticket.dart';
import '../requests/creator_delete_promocode.dart';
import '../requests/creator_get_all_promocodes.dart';
import '../widgets/creator_promocode_form_popup.dart';
import '../widgets/loading_indicator.dart';
import 'creator_drawer.dart';

class CreatorPromocodes extends StatelessWidget {
  static const routeName = '/creator-promocodes';

  void _addCreatorPromocode(BuildContext context) async {
    await showDialog<Ticket>(
      context: context,
      builder: (_) => PromocodeFormPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promocodes'),
      ),
      drawer: CreatorDrawer(),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add Promocode Button",
        onPressed: () => _addCreatorPromocode(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: creatorGetAllPromocodes(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final promocode = snapshot.data[index];
                return Card(
                  child: ListTile(
                    title: Text(promocode.name),
                    subtitle: promocode.amountOff == -1
                        ? Text('Gives ${promocode.percentOff}% off')
                        : Text('Gives \$${promocode.amountOff} off'),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          int result = await creatorDeletePromocode(
                              context, promocode.id);
                          if (result == 0)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Success'),
                                content: Text('Promocode deleted successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushReplacementNamed(
                                            CreatorPromocodes.routeName),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                        }),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child:
                  Text('No Promocodes found!', style: TextStyle(fontSize: 20)),
            );
          }
        },
      ),
    );
  }
}

///This file contains the creator attendee report screen. It contains the list of attendees that have bought tickets.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/report.dart';
import '../providers/dashboard_provider.dart';
import '../requests/creator_export_attendee_report.dart';
import '../requests/creator_get_dashboard.dart';

class CreatorAttendeeReport extends StatefulWidget {
  static const routeName = '/creator-attendee-report';

  @override
  State<CreatorAttendeeReport> createState() => _CreatorAttendeeReportState();
}

class _CreatorAttendeeReportState extends State<CreatorAttendeeReport> {
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  List<AttendeeReport> itemList = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage <
            Provider.of<DashboardProvider>(context, listen: false).maxPages) {
          currentPage++;
          setState(() {
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendee Summary'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'report') {
                await creatorExportAttendeeReport(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.download_outlined),
                      Text('Download Attendee Report',
                          style: TextStyle(fontSize: 16)),
                    ],
                  )),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAttendeeReport(context, currentPage),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.data != null &&
                snapshot.connectionState == ConnectionState.done) {
              itemList.addAll(snapshot.data);
              return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(8),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemList[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Order Number: ${itemList[index].orderNumber}'),
                            SizedBox(height: 8),
                            Text(
                                'Order Date: ${DateFormat.yMd().add_jm().format(itemList[index].orderDate)}'),
                            SizedBox(height: 8),
                            Text('Ticket Type: ${itemList[index].ticketType}'),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('No data found!'),
              );
            }
          }),
    );
  }
}

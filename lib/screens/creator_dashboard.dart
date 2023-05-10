import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'creator_attendee_report.dart';
import 'creator_drawer.dart';
import '../requests/creator_get_dashboard.dart';
import 'creator_sales_report.dart';

class CreatorDashboard extends StatefulWidget {
  static const routeName = '/creatorDashboard';

  @override
  _CreatorDashboardState createState() => _CreatorDashboardState();
}

class _CreatorDashboardState extends State<CreatorDashboard> {
  int? soldTickets;
  int? totalCapacity;
  int? freeTicketsSold;
  int? paidTicketsSold;
  String? eventUrl;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchUrl();
  }

  Future<void> _fetchData() async {
    final response = await fetchData(context);
    setState(() {
      soldTickets = response['soldTickets'];
      totalCapacity = response['totalCapacity'];
      freeTicketsSold = response['freeTicketsSold'];
      paidTicketsSold = response['paidTicketsSold'];
    });
  }

  Future<void> _fetchUrl() async {
    final response = await fetchUrl(context);
    setState(() {
      eventUrl = response['url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (soldTickets == null || eventUrl == null) {
      // While waiting for the response, show a CircularProgressIndicator.
      return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: CreatorDrawer(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final progress = soldTickets! / totalCapacity!;
      return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
          ),
          drawer: CreatorDrawer(),
          body: Column(children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Tickets Sold',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${soldTickets!.toStringAsFixed(0)}/${totalCapacity!.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CustomPaint(
                                  painter: _CapacityIndicatorPainter(progress),
                                  child: Center(
                                    child: Text(
                                      '${(progress * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 14, 27, 49),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_seat,
                                    color: Color.fromARGB(255, 14, 27, 49),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Free: ${freeTicketsSold!.toString()}',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 14, 27, 49),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Color.fromARGB(255, 14, 27, 49),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Paid: ${paidTicketsSold!.toString()}',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 14, 27, 49),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Expanded(
                      flex: 2,
                      child: TextFormField(
                        readOnly: true,
                        initialValue: eventUrl,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: eventUrl));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ));
                            },
                          ),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  CreatorAttendeeReport.routeName);
                            },
                            child: Text('Attendee summary'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  CreatorSalesReport.routeName);
                            },
                            child: Text('Sales summary'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]));
    }
  }
}

class _CapacityIndicatorPainter extends CustomPainter {
  final double progress;

  _CapacityIndicatorPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Color.fromARGB(255, 222, 218, 218)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    final sweepAngle = 2 * pi * progress;
    final progressPaint = Paint()
      ..color = Color.fromARGB(255, 14, 27, 49)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CapacityIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

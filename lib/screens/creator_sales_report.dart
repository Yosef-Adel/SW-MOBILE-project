import 'package:flutter/material.dart';

import '../requests/creator_get_dashboard.dart';

class CreatorSalesReport extends StatefulWidget {
  static const routeName = '/creatorSalesReport';
  @override
  _CreatorSalesReportState createState() => _CreatorSalesReportState();
}

class _CreatorSalesReportState extends State<CreatorSalesReport> {
  int? totalOrders;
  int? totalSoldTickets;
  double? grossSales;
  double? netSales;
  List<dynamic>? reportData;

  @override
  void initState() {
    super.initState();
    _fetchSalesReport();
    // _fetchTicketsSales();
  }

  Future<void> _fetchSalesReport() async {
    final response = await fetchSalesReport(context);
    setState(() {
      totalOrders = response['totalOrders'];
      totalSoldTickets = response['totalSoldTickets'];
      grossSales = response['grossSales'];
      netSales = response['netSales'];
    });
  }

  // Future<void> _fetchTicketsSales() async {
  //   final response = await fetchTicketsSales(context);
  //   setState(() {
  //     reportData = response['Report'] as List<dynamic>;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (totalOrders == null || reportData == null) {
      // While waiting for the response, show a CircularProgressIndicator.
      return Scaffold(
        appBar: AppBar(
          title: Text('Sales Report'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sales Report'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    // Add your export action here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.download,
                          color: Color.fromARGB(255, 14, 27, 49), size: 17),
                      Text(
                        'Export',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 14, 27, 49),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Gross Sales',
                      value: grossSales!.toInt(),
                    ),
                  ),
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Net Sales',
                      value: netSales!.toInt(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Tickets + Add-Ons Sold',
                      value: totalSoldTickets!,
                    ),
                  ),
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Orders',
                      value: totalOrders!,
                    ),
                  ),
                ],
              ),
              // ListView.builder(
              //   itemCount: reportData!.length,
              //   itemBuilder: (context, index) {
              //     final item = reportData![index];

              //     return Card(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             item['ticketType'],
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18,
              //             ),
              //           ),
              //           SizedBox(height: 8),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text('Price: ${item['Price']}'),
              //               Text('Sold: ${item['sold']}'),
              //             ],
              //           ),
              //           SizedBox(height: 8),
              //           Text('Total: ${item['total']}'),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      );
    }
  }
}

Widget _buildSalesCard({required String name, required int value}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 107, 118, 137),
            ),
          ),
          SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 27, 49),
            ),
          ),
        ],
      ),
    ),
  );
}
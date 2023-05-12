import 'package:flutter/material.dart';

import '../requests/creator_get_dashboard.dart';
import '../widgets/creator_sales_tickets_list.dart';

class CreatorSalesReport extends StatefulWidget {
  static const routeName = '/creatorSalesReport';
  @override
  _CreatorSalesReportState createState() => _CreatorSalesReportState();
}

class _CreatorSalesReportState extends State<CreatorSalesReport> {
  bool isDataReady = false;
  int totalOrders = 0;
  int totalSoldTickets = 0;
  double grossSales = 0;
  double netSales = 0;
  List<dynamic>? reportData;

  @override
  void initState() {
    super.initState();
    _fetchSalesReport();
  }

  Future<void> _fetchSalesReport() async {
    final response = await fetchSalesReport(context);
    setState(() {
      totalOrders = response['totalOrders'];
      totalSoldTickets = response['totalSoldTickets'];
      grossSales = response['grossSales'];
      netSales = response['netSales'];
      isDataReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDataReady == false) {
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
              Row(
                children: [
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Gross Sales',
                      value: grossSales.toInt(),
                    ),
                  ),
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Net Sales',
                      value: netSales.toInt(),
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
                      value: totalSoldTickets,
                    ),
                  ),
                  Expanded(
                    child: _buildSalesCard(
                      name: 'Orders',
                      value: totalOrders,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                child: CreatorSalesTicketsList(),
                width: MediaQuery.of(context).size.width,
              ))
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

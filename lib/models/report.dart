class SalesReport {
  final String ticketType;
  final int price;
  final int sold;
  final int total;

  SalesReport(
      {required this.ticketType,
      required this.price,
      required this.sold,
      required this.total});

  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
      ticketType: json['ticketType'],
      price: 0,
      sold: 0,
      total: 0,
    );
  }
}

class AttendeeReport {
  String orderNumber;
  DateTime orderDate;

  String name;
  String ticketType;

  AttendeeReport(
      {required this.orderNumber,
      required this.orderDate,
      required this.name,
      required this.ticketType});

  factory AttendeeReport.fromJson(Map<String, dynamic> json) {
    return AttendeeReport(
      orderNumber: json['orderNumber'],
      orderDate: DateTime.parse(json['orderDate']),
      name: json['name'],
      ticketType: json['ticketType'],
    );
  }
}

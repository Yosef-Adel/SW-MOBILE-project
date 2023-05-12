class SalesReport {
  final String ticketType;
  var price;
  var sold;
  var total;

  SalesReport(
      {required this.ticketType,
      required this.price,
      required this.sold,
      required this.total});

  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
      ticketType: json['ticketType'],
      price: json['Price'],
      sold: json['sold'],
      total: json['total'],
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

///This is the model class for the Ticket.

class Ticket {
  final String id;
  final String eventId;
  final String name;
  final String decription;
  double price;
  int count;

  String? type;
  int? capacity;
  int? minQuantityPerOrder;
  int? maxQuantityPerOrder;
  DateTime? sellingStartDate;
  DateTime? sellingEndDate;

  Ticket(
      {required this.id,
      required this.name,
      required this.eventId,
      this.decription = "",
      required this.price,
      this.count = 0,
      this.type,
      this.capacity,
      this.minQuantityPerOrder,
      this.maxQuantityPerOrder,
      this.sellingStartDate,
      this.sellingEndDate});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['_id'],
        name: json['name'],
        price: json['price'].toDouble(),
        eventId: json['event']);
  }

  factory Ticket.fromJsonCreator(Map<String, dynamic> json) {
    return Ticket(
        id: json['_id'],
        name: json['name'],
        price: json['price'].toDouble(),
        eventId: json['event'],
        type: json['type'],
        capacity: json['capacity'],
        minQuantityPerOrder: json['minQuantityPerOrder'],
        maxQuantityPerOrder: json['maxQuantityPerOrder'],
        sellingStartDate: DateTime.parse(json['salesStart']),
        sellingEndDate: DateTime.parse(json['salesEnd']));
  }
}

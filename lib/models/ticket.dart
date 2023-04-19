///This is the model class for the Ticket.

class Ticket {
  final String id;
  final String eventId;
  final String name;
  final String decription;
  int price;
  int count;

  Ticket(
      {required this.id,
      required this.name,
      required this.eventId,
      this.decription = "",
      required this.price,
      this.count = 0});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        eventId: json['event']);
  }
  void upgradeCount(int counter) {
    count = counter;
  }
}

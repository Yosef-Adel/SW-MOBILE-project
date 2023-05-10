/// This class is used to create a promocode object.
class Promocode {
  String id;
  String name;
  String event;
  List<String> tickets;
  int percentOff;
  int amountOff;
  int limit;
  DateTime startDate;
  DateTime endDate;

  Promocode({
    required this.id,
    required this.name,
    required this.event,
    required this.tickets,
    this.percentOff = -1,
    this.amountOff = -1,
    required this.limit,
    required this.startDate,
    required this.endDate,
  });
  //This version of the factory constructor is used when the promocode is displayed to the creator.
  factory Promocode.fromJson(Map<String, dynamic> json) {
    return Promocode(
      id: json['_id'],
      name: json['name'],
      event: json['event'],
      tickets: json['tickets'].cast<String>(),
      percentOff: json.containsKey('percentOff') ? json['percentOff'] : -1,
      amountOff: json.containsKey('amountOff') ? json['amountOff'] : -1,
      limit: json['limit'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

///This is the model class for the Event object.

class Event {
  final String id;
  final String title;
  final String? description;
  final String? summary;
  final String? imageUrl;
  final bool? isOnline;
  final List<dynamic>? tickets;
  final DateTime startDate;
  final DateTime endDate;
  final String category;
  final double? price;
  final int? capacity;
  final bool? isPrivate;
  final String? venueName;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? address1;
  final int? totalTickets;
  final int? soldTickets;

  Event({
    required this.id,
    required this.title,
    this.description,
    this.summary,
    this.imageUrl,
    this.isOnline,
    this.tickets,
    required this.startDate,
    required this.endDate,
    required this.category,
    this.price,
    this.capacity,
    this.isPrivate,
    this.venueName,
    this.city,
    this.country,
    this.postalCode,
    this.address1,
    this.totalTickets,
    this.soldTickets,
  });

  //This version of the factory constructor is used when the event is displayed to the user.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['name'],
      description: json.containsKey('description') ? json['description'] : "",
      summary: json.containsKey('summary') ? json['summary'] : "",
      imageUrl: json.containsKey('image')
          ? json['image']
          : 'https://res.cloudinary.com/dv2ei7dxk/image/upload/v1681899611/DEV/zlpblybrvv4psyovd7f9.png',
      isOnline: json.containsKey('isOnline') ? json['isOnline'] : true,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      category: json['category'],
      price: json.containsKey('price') ? json['price'].toDouble() : 0,
      capacity: json.containsKey('capacity') ? json['capacity'] : 100,
      isPrivate: json.containsKey('isPrivate') ? json['isPrivate'] : true,
      venueName: json.containsKey('venueName') ? json['venueName'] : "",
      city: json.containsKey('city') ? json['city'] : "",
      country: json.containsKey('country') ? json['country'] : "",
      postalCode: json.containsKey('postalCode') ? json['postalCode'] : "",
      address1: json.containsKey('address1') ? json['address1'] : "",
    );
  }

  //This version of the factory constructor is used when the event is created by the user.
  factory Event.fromJsonCreator(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['name'],
      description: json.containsKey('description') ? json['description'] : "",
      summary: json['summary'],
      imageUrl: json.containsKey('image')
          ? json['image']
          : 'https://res.cloudinary.com/dv2ei7dxk/image/upload/v1681899611/DEV/zlpblybrvv4psyovd7f9.png',
      isOnline: json.containsKey('isOnline') ? json['isOnline'] : true,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      category: json['category'],
      price: json.containsKey('price') ? json['price'].toDouble() : 0,
      capacity: json.containsKey('capacity') ? json['capacity'] : 100,
      isPrivate: json.containsKey('isPrivate') ? json['isPrivate'] : true,
      venueName: json.containsKey('venueName') ? json['venueName'] : "",
      city: json.containsKey('city') ? json['city'] : null,
      country: json.containsKey('country') ? json['country'] : "",
      postalCode: json.containsKey('postalCode') ? json['postalCode'] : "",
      address1: json.containsKey('address1') ? json['address1'] : "",
      totalTickets: json.containsKey('numberOfTicketsCapacity') ? json['numberOfTicketsCapacity'] : 0,
      soldTickets: json.containsKey('numberOfTicketsSold') ? json['numberOfTicketsSold'] : 0,
      tickets: json.containsKey('tickets') ? json['tickets'] : [],
    );
  }
}

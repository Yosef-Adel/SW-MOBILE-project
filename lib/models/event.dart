///This is the model class for the Event object.

class Event {
  final String id;
  final String title;
  final String description;
  final String summary;
  final String? imageUrl;
  final bool isOnline;
  final DateTime startDate;
  final DateTime endDate;
  final String categoryId;
  final double price;
  final String? hostedBy;
  final bool isPrivate;
  final String venueName;
  final String city;
  final String country;
  final int? totalTickets;
  final int? soldTickets;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.summary,
    this.imageUrl,
    required this.isOnline,
    required this.startDate,
    required this.endDate,
    required this.categoryId,
    required this.price,
    this.hostedBy,
    required this.isPrivate,
    required this.venueName,
    required this.city,
    required this.country,
    this.totalTickets,
    this.soldTickets,
  });

  //This version of the factory constructor is used when the event is displayed to the user.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['name'],
      description: json['description'],
      summary: json['summary'],
      imageUrl: json.containsKey('image')
          ? json['image']
          : 'https://res.cloudinary.com/dv2ei7dxk/image/upload/v1681899611/DEV/zlpblybrvv4psyovd7f9.png',
      isOnline: json['isOnline'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      categoryId: json['category'],
      price: json['price'].toDouble(),
      hostedBy: json['hostedBy'],
      isPrivate: json['isPrivate'],
      venueName: json['venueName'],
      city: json['city'],
      country: json['country'],
    );
  }

  //This version of the factory constructor is used when the event is created by the user.
  factory Event.fromJsonCreator(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['name'],
      description: json['description'],
      summary: json['summary'],
      imageUrl: json.containsKey('image')
          ? json['image']
          : 'https://res.cloudinary.com/dv2ei7dxk/image/upload/v1681899611/DEV/zlpblybrvv4psyovd7f9.png',
      isOnline: json['isOnline'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      categoryId: json['category'],
      price: json['price'].toDouble(),
      hostedBy: json['hostedBy'],
      isPrivate: json['isPrivate'],
      venueName: json['venueName'],
      city: json['city'],
      country: json['country'],
      totalTickets: json['numberOfTicketsCapacity'],
      soldTickets: json['numberOfTicketsSold'],
    );
  }
}

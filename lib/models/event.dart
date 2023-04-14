///This is the model class for the Event object.

class Event {
  final String id;
  final String title;
  final String description;
  final String summary;
  final String imageUrl;
  final bool isOnline;
  final DateTime startDate;
  final DateTime endDate;
  final String categoryId;
  final double price;
  final hostedBy;
  //final bool isPrivate;
  final venueName;
  final city;
  //final String address;
  final String country;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.summary,
    required this.imageUrl,
    required this.isOnline,
    required this.startDate,
    required this.endDate,
    required this.categoryId,
    required this.price,
    required this.hostedBy,
    //this.isPrivate,
    required this.venueName,
    required this.city,
    //required this.address,
    required this.country,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['name'],
      description: json['description'],
      summary: json['summary'],
      imageUrl: json['image'],
      isOnline: json['isOnline'] ?? false,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      categoryId: json['category'],
      price: json['price'].toDouble(),
      hostedBy: json['hostedBy'],
      //isPrivate: json['isPrivate'],
      venueName: json['venueName'],
      city: json['city'],
      //address: json['address'],
      country: json['country'],
    );
  }
}

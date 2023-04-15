class Ticket {
  final String id;
  final String title;
  final String decription;
  final double price;
  final int count;

  const Ticket(
      {required this.id,
      required this.title,
      this.decription = "",
      required this.price,
      this.count = 0});
}

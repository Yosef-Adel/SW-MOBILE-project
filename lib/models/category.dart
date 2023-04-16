///This is the model class for the Category object.
///Categories are Music - Food & Drink - Charity & Causes

class Category {
  final String id;
  final String name;
  bool isSelected;

  Category({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }
}

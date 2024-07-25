class Product {
  final String id;
  final String title;
  final num price;
  final String description;
  final Map<String, dynamic> category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: map['category'],
    );
  }
}

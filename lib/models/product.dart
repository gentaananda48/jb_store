//Memanage dan menampilkan informasi dari product yang ada di Fake Store API

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final double? originalPrice;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.originalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      image: json['image'],
      originalPrice: json['original_price']
          ?.toDouble(), // Assume 'original_price' is the key from API
    );
  }
}

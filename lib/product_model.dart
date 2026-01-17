class Product {
  final String id ;
  final String name ;
  final String photo ;
  final String price ;
  final String description ;


  Product({
    required this.id,
    required this.name,
    required this.photo,
    required this.price,
    required this.description,
});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      price: json['price'],
      description: json['description'],
    );

  }

}
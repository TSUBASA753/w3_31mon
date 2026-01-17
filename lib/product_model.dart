class Product {
  final String id ;
  final String name ;
  final String photo ;
  final String price ;
  final String description ;
  final int weight ;


  Product({
    required this.id,
    required this.name,
    required this.photo,
    required this.price,
    required this.description,
    required this.weight,
});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      price: json['price'],
      description: json['description'],
      weight: json['weight'],
    );

  }

}
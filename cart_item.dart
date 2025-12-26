class CartItem {
  final String productId;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  double get totalPrice => price * quantity;
}
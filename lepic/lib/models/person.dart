class Person {
  final String productId;
  final String name;
  final double price;

  Person({this.productId, this.price, this.name});

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'name': name, 'price': price};
  }

  Person.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'];
}

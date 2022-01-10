import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lepic/models/product.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .where('name', isEqualTo: 'ahmethoca')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Product.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}

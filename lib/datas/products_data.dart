import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {
  String? category;
  String? id;
  String? title;
  double price = 0.00;
  List<String>? image;
  List<String>? sizes;

  ProductsData.firebaseFirestore(DocumentSnapshot? snapshot) {
    try {
      id = snapshot?.id;
      title = snapshot?.get('title');
      price = snapshot?.get('price') + 0.0;
      image = (snapshot?.get('image') as List).map((e) => e as String).toList();
      sizes = (snapshot?.get('sizes') as List).map((e) => e as String).toList();
    } catch (e) {
      log('erro  ProductsData');
    }
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'title': title,
      'price': price,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_thiago/datas/products_data.dart';

class CartProduct {
  String? cid;
  String? category;
  String? pid;
  int quantity = 0;
  String? size;
  ProductsData? productData;
  CartProduct();

  CartProduct.firebaseFirestore(DocumentSnapshot document) {
    cid = document.id;
    category = document.get(['category']);
    pid = document.get(['pid']);
    quantity = document.get(['quantity']);
    size = document.get(['size']);
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'pid': pid,
      'quantity': quantity,
      'size': size,
      'product': productData?.toResumedMap()
    };
  }
}

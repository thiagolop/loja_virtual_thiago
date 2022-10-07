import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_thiago/datas/cart_product.dart';
import 'package:loja_virtual_thiago/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> product = [];

  bool isLoading = false;

  String? couponcode;

  int discountPercentage = 0;

  void updadePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (product.isEmpty) {
      return '';
    }
    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection('orders').add(
      {
        'clientId': user.firebaseUser?.uid,
        'products': product.map((cartProduct) => cartProduct.toMap()).toList(),
        'shipPrice': shipPrice,
        'productsPrice': productsPrice,
        'discount': discount,
        'totalPrice': productsPrice - discount + shipPrice,
        'status': 1,
      },
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('orders')
        .doc(refOrder.id)
        .set(
      {'orderId': refOrder.id},
    );

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .get();

    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }
    product.clear();
    couponcode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();
    return refOrder.id;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in product) {
      if (c.productData != null) {
        price += c.quantity * c.productData!.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    product.add(cartProduct);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
      notifyListeners();
    });
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();

    product.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void _loadCartItens() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .get();
    product = query.docs.map((d) => CartProduct.firebaseFirestore(d)).toList();
    notifyListeners();
  }
}

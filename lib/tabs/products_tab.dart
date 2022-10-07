import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/titles/category_title.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var dividedTites = ListTile.divideTiles(
                  tiles: snapshot.data!.docs.map(
                    (e) {
                      return Categorytitle(snapshot: e);
                    },
                  ).toList(),
                  color: const Color.fromARGB(255, 30, 30, 30))
              .toList();

          return ListView(children: dividedTites);
        }
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/datas/products_data.dart';
import '../titles/product_title.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.snapshot}) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            snapshot.get(
              'title',
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.grid_on,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                'products',
              )
              .doc(snapshot.id)
              .collection(
                'itens',
              )
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.70,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      ProductsData data = ProductsData.firebaseFirestore(
                          snapshot.data?.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTitle(
                        type: 'grid',
                        data: data,
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      ProductsData data = ProductsData.firebaseFirestore(
                          snapshot.data?.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTitle(
                        type: 'list',
                        data: data,
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

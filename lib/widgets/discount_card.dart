import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DiscountCart extends StatelessWidget {
  const DiscountCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cumpon de Desconto',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu Cupom',
              ),
              onSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  // ignore: unnecessary_null_comparison
                  if (docSnap.data != null) {
                    const snackbar = SnackBar(
                      content: Text(''),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else{
                    const snackbar = SnackBar(
                      content: Text('Cumpon não existente !'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } 
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/screens/category_screen.dart';

class Categorytitle extends StatelessWidget {
  const Categorytitle({Key? key, required this.snapshot}) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        snapshot.get('title'),
        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryScreen(snapshot: snapshot),
          ),
        );
      },
    );
  }
}

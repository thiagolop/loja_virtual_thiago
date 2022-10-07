import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/models/cart_model.dart';
import 'package:loja_virtual_thiago/models/user_model.dart';
import 'package:loja_virtual_thiago/screens/home_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Thiago\'s Store Flutter',
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  primaryColor: const Color.fromARGB(255, 4, 125, 141)),
              debugShowCheckedModeBanner: false,
              home: HomeScreens(),
            ),
          );
        },
      ),
    );
  }
}

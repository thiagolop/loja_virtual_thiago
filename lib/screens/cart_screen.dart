// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/models/cart_model.dart';
import 'package:loja_virtual_thiago/models/user_model.dart';
import 'package:loja_virtual_thiago/screens/login_screen.dart';
import 'package:loja_virtual_thiago/widgets/cart_price.dart';
import 'package:loja_virtual_thiago/widgets/discount_card.dart';
import 'package:loja_virtual_thiago/widgets/ship_cart.dart';
import 'package:scoped_model/scoped_model.dart';
import '../titles/cart_title.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Carrinho',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int qnt = model.product.length;
                return Text(
                  '$qnt ${qnt == 1 ? "Iten" : "Itens"}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoadingIn()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoadingIn()) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Faça o login para adicionar Produtos',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 125, 141)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 4, 125, 141),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      style: const ButtonStyle(
                        shadowColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 4, 125, 141),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (model.product.isEmpty) {
            return const Center(
              child: (Text(
                'Nenhum Produto no Carrinho',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.product.map((product) {
                    return CartTitle(product);
                  }).toList(),
                ),
                const DiscountCart(),
                const ShipCart(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  print(orderId);
                }),
              ],
            );
          }
        },
      ),
    );
  }
}

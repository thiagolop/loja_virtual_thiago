import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  const CartPrice(this.buy, {super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Resumo do Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text('Subtotal '),
                    Text('R\$ ${price.toStringAsFixed(2)}')
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Row(
                  children: [
                    const Text('Desconto '),
                    Text('R\$ ${discount.toStringAsFixed(2)}')
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Row(
                  children: [
                    const Text('Entrega '),
                    Text('R\$ ${ship.toStringAsFixed(2)}')
                  ],
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const Text('Total '),
                    Text(
                      'R\$ ${(price + ship -discount).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Finalizar Pedido',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

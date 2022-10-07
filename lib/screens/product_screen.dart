import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loja_virtual_thiago/datas/cart_product.dart';
import 'package:loja_virtual_thiago/datas/products_data.dart';
import 'package:loja_virtual_thiago/models/cart_model.dart';
import 'package:loja_virtual_thiago/models/user_model.dart';
import 'package:loja_virtual_thiago/screens/cart_screen.dart';
import 'package:loja_virtual_thiago/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final ProductsData product;
  @override
  // ignore: no_logic_in_create_state
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final CarouselController _carouselController = CarouselController();
  final ProductsData product;
  String? size;
  _ProductScreenState(this.product);
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.easeInOutExpo,
                  aspectRatio: 1.0,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                ),
                items: product.image?.map((e) {
                  return Image.network(e, fit: BoxFit.cover);
                }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes!.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            border: Border.all(
                              color: e == size ? primaryColor : Colors.grey,
                              width: 3,
                            ),
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: TextButton(
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoadingIn()) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = product.category;
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            }
                          }
                        : null,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(primaryColor),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[400]),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return primaryColor;
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.red.withOpacity(0.12);
                          }
                          return null;
                        },
                      ),
                    ),
                    child: Text(
                      UserModel.of(context).isLoadingIn()
                          ? 'Adicionar ao Carrinho'
                          : 'Entre para Comprar',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

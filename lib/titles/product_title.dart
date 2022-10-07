import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:loja_virtual_thiago/datas/products_data.dart';
import '../screens/product_screen.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);
  final String type;
  final ProductsData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: data),
          ),
        );
      },
      child: Container(
        child: type == 'grid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.zero,
                      child: GifView.network(
                        data.image?[0] ??
                            'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
                        progress: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        data.title ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        'R\$${data.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 230,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            data.image?[0] ??
                                'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'R\$${data.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/details_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final void Function() onChange;
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsScreen(product: product, onChange: onChange),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Image.network(product.thumbnail, width: 130),
              Text(product.title, overflow: TextOverflow.ellipsis),
              Text(
                product.price.toString(),
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

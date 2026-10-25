import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  final Product product;
  final void Function() onDelete;
  const new({super.key, required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.thumbnail),
        title: Text(product.title, style: TextStyle(fontSize: 18)),
        subtitle: Text(
          product.price.toString(),
          style: TextStyle(fontSize: 16),
        ),
        trailing: Row(
          spacing: 40,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(product.quantity.toString(), style: TextStyle(fontSize: 16)),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

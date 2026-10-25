import 'package:ecommerce_app/consts.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HiveHelper {
  static final _box = Hive.box<Product>(productBoxName);

  static List<Product> getCartProducts() => _box.values.toList();

  static Future<void> addToCart(
    BuildContext context,
    Product product,
    int quantity,
  ) async {
    try {
      final existingProducts = getCartProducts().where(
        (item) => item.id == product.id,
      );
      if (existingProducts.isNotEmpty) {
        final existingProduct = existingProducts.first;
        existingProduct.quantity = existingProduct.quantity + quantity;
        await existingProduct.save();
      } else {
        product.quantity = quantity;
        await _box.add(product);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Added Succesffuly')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error adding to cart $e')));
    }
  }

  static Future<void> deleteProduct(Product product) async =>
      await product.delete();
}

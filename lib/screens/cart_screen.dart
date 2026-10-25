import 'package:ecommerce_app/hive_helper.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/cart_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onChange;
  const new({super.key, required this.onChange});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> _products = [];
  @override
  void initState() {
    super.initState();
    _products = HiveHelper.getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) => CartWidget(
                  product: _products[index],
                  onDelete: () {
                    HiveHelper.deleteProduct(_products[index]);
                    setState(() => _products = HiveHelper.getCartProducts());
                    widget.onChange();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

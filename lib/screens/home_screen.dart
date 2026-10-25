import 'package:ecommerce_app/dio_helper.dart';
import 'package:ecommerce_app/hive_helper.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nmOfItems = 0;
  @override
  void initState() {
    super.initState();
    nmOfItems = HiveHelper.getCartProducts().length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    onChange: () {
                      setState(
                        () => nmOfItems = HiveHelper.getCartProducts().length,
                      );
                    },
                  ),
                ),
              );
            },
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, size: 50),
                nmOfItems == 0
                    ? SizedBox()
                    : Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                          child: Text(
                            nmOfItems.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DioHelper.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 200),
                  Text('Data error', style: TextStyle(fontSize: 50)),
                ],
              ),
            );
          }
          final products = snapshot.data;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: products!.length,
            itemBuilder: (context, index) => ProductItemWidget(
              product: products[index],
              onChange: () {
                setState(() => nmOfItems = HiveHelper.getCartProducts().length);
              },
            ),
          );
        },
      ),
    );
  }
}

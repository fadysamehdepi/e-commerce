import 'package:ecommerce_app/hive_helper.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/image_slider_widget.dart';
import 'package:ecommerce_app/widgets/stars_rating_widget.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  final void Function() onChange;
  const DetailsScreen({
    super.key,
    required this.product,
    required this.onChange,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  ImageSliderWidget(images: widget.product.images),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$ ${widget.product.price}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rating',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StarsRatingWidget(rating: widget.product.rating),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 5,
                      ),
                      child: Row(
                        spacing: 20,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() => quantity--);
                              }
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0xfffae6cb),
                              foregroundColor: Color(0xfffc9103),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            icon: Icon(Icons.remove, size: 20),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => quantity++),
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0xfffae6cb),
                              foregroundColor: Color(0xfffc9103),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            icon: Icon(Icons.add, size: 25),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              HiveHelper.addToCart(
                                context,
                                widget.product,
                                quantity,
                              );
                              widget.onChange();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xfffc9103),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                            ),
                            child: Text('Add', style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

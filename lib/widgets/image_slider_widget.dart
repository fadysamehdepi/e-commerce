import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  final List images;
  const new({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((e) {
        return Image.network(e);
      }).toList(),
      options: CarouselOptions(
        height: 400,
        initialPage: 0,
        reverse: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

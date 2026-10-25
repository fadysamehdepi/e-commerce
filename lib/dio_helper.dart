import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/product.dart';

class DioHelper {
  static final _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'));

  static Future<List<Product>> getData() async {
    final response = await _dio.get('products');
    // debugPrint(response.data.toString());
    final productsJson = response.data['products'] as List;
    final products = productsJson.map((e) => Product.fromJson(e)).toList();
    return products;
  }
}

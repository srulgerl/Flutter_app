import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/services/httpService.dart';

class ProductRepositroy {
  final HttpService http = HttpService();

  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return http.getAllProducts('products', null);
  }

  Future<void> addProduct(String product) async {
    await Future.delayed(Duration(seconds: 1));
    print('$product added successfully');
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    await Future.delayed(Duration(seconds: 2));
    return http.getAllProducts('products/category/$category', null);
  }
}

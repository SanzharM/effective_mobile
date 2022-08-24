import 'package:effective_mobile/domain/models/best_seller.dart';
import 'package:effective_mobile/domain/models/cart.dart';
import 'package:effective_mobile/domain/models/hot_sale.dart';
import 'package:effective_mobile/domain/models/product_detail.dart';
import 'package:http/http.dart';

class ApiResponse {
  final bool isSuccess;
  final int? statusCode;
  final Response? response;
  final String? error;

  const ApiResponse({
    this.isSuccess = false,
    required this.statusCode,
    this.response,
    this.error,
  });
}

class MainScreenResponse {
  final List<HotSale>? hotSales;
  final List<BestSeller>? bestSellers;
  final String? error;

  // const MainScreenResponse({this.hotSales, this.bestSellers, String? error, bool isSuccess = false, int? statusCode})
  //     : super(statusCode: statusCode, isSuccess: isSuccess, error: error);
  const MainScreenResponse({this.hotSales, this.bestSellers, this.error});
}

class ProductDetailsResponse {
  final ProductDetail? product;
  final String? error;

  const ProductDetailsResponse({this.product, this.error});
}

class CartResponse {
  final Cart? cart;
  final String? error;

  const CartResponse({this.cart, this.error});
}

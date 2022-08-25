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

class MainScreenResponse extends ApiResponse {
  final List<HotSale>? hotSales;
  final List<BestSeller>? bestSellers;

  const MainScreenResponse({this.hotSales, this.bestSellers, String? error, bool isSuccess = false, int? statusCode})
      : super(statusCode: statusCode, isSuccess: isSuccess, error: error);
}

class ProductDetailsResponse extends ApiResponse {
  final ProductDetail? product;

  const ProductDetailsResponse({this.product, String? error, bool isSuccess = false, int? statusCode})
      : super(statusCode: statusCode, isSuccess: isSuccess, error: error);
}

class CartResponse extends ApiResponse {
  final Cart? cart;

  const CartResponse({this.cart, String? error, bool isSuccess = false, int? statusCode})
      : super(statusCode: statusCode, isSuccess: isSuccess, error: error);
}

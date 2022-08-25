import 'package:effective_mobile/core/api/api.dart';
import 'package:effective_mobile/core/api/api_response.dart';
import 'package:effective_mobile/core/api/endpoints.dart';
import 'package:effective_mobile/data/app_provider.dart';
import 'package:effective_mobile/domain/models/cart.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends AppProvider {
  Future<CartResponse> getCart() async {
    final response = await api.request(
      route: Uri.parse(AppEndpoints.host + AppEndpoints.cart),
      method: Method.get,
    );

    if (response.isSuccess) {
      try {
        final cart = await compute(_parseCart, response.response?.body);
        return CartResponse(cart: cart);
      } catch (e) {
        debugPrint('Error parsing cart: $e');
      }
      return CartResponse(error: 'Something went wrong', isSuccess: response.isSuccess, statusCode: response.statusCode);
    }
    return CartResponse(error: response.error, isSuccess: response.isSuccess, statusCode: response.statusCode);
  }

  static Cart _parseCart(String? body) {
    if (body?.isEmpty ?? true) {
      throw Exception('Response body is invalid (Body: $body)');
    }
    return Cart.fromJson(body!);
  }
}

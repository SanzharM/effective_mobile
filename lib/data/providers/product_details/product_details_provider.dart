import 'package:effective_mobile/core/api/api.dart';
import 'package:effective_mobile/core/api/api_response.dart';
import 'package:effective_mobile/core/api/endpoints.dart';
import 'package:effective_mobile/data/app_provider.dart';
import 'package:effective_mobile/domain/models/product_detail.dart';
import 'package:flutter/foundation.dart';

class ProductDetailsProvider extends AppProvider {
  Future<ProductDetailsResponse> getProductDetails() async {
    final response = await api.request(
      route: Uri.parse(AppEndpoints.host + AppEndpoints.productDetails),
      method: Method.get,
    );

    if (response.isSuccess) {
      try {
        final product = await compute(_parseProductDetails, response.response?.body);
        return ProductDetailsResponse(product: product);
      } catch (e) {
        debugPrint('Product detail parsing error: $e');
        return const ProductDetailsResponse(error: 'Something went wrong');
      }
    }
    return ProductDetailsResponse(error: response.error);
  }

  static ProductDetail _parseProductDetails(String? body) {
    if (body?.isEmpty ?? true) throw Exception('Something went wrong. Received empty response');
    return ProductDetail.fromJson(body!);
  }
}

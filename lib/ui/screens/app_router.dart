import 'package:effective_mobile/ui/screens/checkout/checkout_screen.dart';
import 'package:effective_mobile/ui/screens/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static void toProductDetails(BuildContext context, int id) {
    final route = MaterialPageRoute(builder: (_) => ProductDetailsScreen(id: id));
    Navigator.of(context).push(route);
  }

  static void toCheckout(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const CheckoutScreen());
    Navigator.of(context).push(route);
  }
}

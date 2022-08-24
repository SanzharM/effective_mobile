import 'package:bloc/bloc.dart';
import 'package:effective_mobile/data/providers/cart/cart_provider.dart';
import 'package:effective_mobile/domain/models/cart.dart';
import 'package:flutter/cupertino.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final _provider = CartProvider();

  void getCart() => add(GetCartEvent());
  void purchase() => debugPrint('Purchase for my cart');

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCartEvent) {
        final response = await _provider.getCart();

        if (response.cart != null) {
          emit(CartLoaded(response.cart!));
        } else {
          emit(CartErrorState(response.error ?? 'Something went wrong'));
        }
      }
    });
  }
}

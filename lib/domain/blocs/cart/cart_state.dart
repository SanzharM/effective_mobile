part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);
}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded(this.cart);
}

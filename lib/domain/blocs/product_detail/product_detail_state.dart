part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductLoadingState extends ProductDetailState {}

class ProductErrorState extends ProductDetailState {
  final String error;
  ProductErrorState(this.error);
}

class ProductLoaded extends ProductDetailState {
  final ProductDetail product;
  ProductLoaded(this.product);
}

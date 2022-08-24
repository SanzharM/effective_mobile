import 'package:bloc/bloc.dart';
import 'package:effective_mobile/data/providers/product_details/product_details_provider.dart';
import 'package:effective_mobile/domain/models/product_detail.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final _provider = ProductDetailsProvider();

  void getProduct() => add(GetProductEvent());

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) async {
      if (event is GetProductEvent) {
        emit(ProductLoadingState());

        final response = await _provider.getProductDetails();
        if (response.product != null) {
          emit(ProductLoaded(response.product!));
        } else {
          emit(ProductErrorState(response.error ?? 'Something went wrong'));
        }
      }
    });
  }
}

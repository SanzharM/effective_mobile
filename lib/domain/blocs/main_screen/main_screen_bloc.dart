import 'package:bloc/bloc.dart';
import 'package:effective_mobile/data/providers/main_screen/main_screen_provider.dart';
import 'package:effective_mobile/domain/models/best_seller.dart';
import 'package:effective_mobile/domain/models/hot_sale.dart';
import 'package:effective_mobile/domain/models/item_category.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final _provider = MainScreenProvider();

  void getCategroies() => add(GetCategories());
  void getData() => add(GetMainScreenData());
  void getLocation() => add(GetCurrentLocation());

  MainScreenBloc() : super(MainScreenInitial()) {
    on<MainScreenEvent>((event, emit) async {
      if (event is GetCategories) {
        emit(MainScreenLoading());
        final categories = await _provider.getCategories();

        emit(CategoriesLoaded(categories));
      } else if (event is GetMainScreenData) {
        emit(MainScreenLoading());
        final response = await _provider.getData();

        if (response.error?.isEmpty ?? true) {
          emit(MainScreenDataLoaded(
            bestSellers: response.bestSellers ?? [],
            hotSales: response.hotSales ?? [],
          ));
        } else {
          emit(ErrorState(response.error!));
        }
      } else if (event is GetCurrentLocation) {
        emit(CurrentLocationLoading());

        try {
          final placemark = await _provider.tryGetLocation();
          if (placemark != null) {
            emit(CurrentLocationLoaded(placemark));
          }
        } catch (e) {
          emit(CurrentLocationError(e.toString()));
        }
      }
    });
  }
}

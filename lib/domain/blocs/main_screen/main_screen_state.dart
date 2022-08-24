part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class ErrorState extends MainScreenState {
  final String? error;
  ErrorState(this.error);
}

class CategoriesLoading extends MainScreenState {}

class MainScreenLoading extends MainScreenState {}

class MainScreenDataLoaded extends MainScreenState {
  final List<HotSale> hotSales;
  final List<BestSeller> bestSellers;

  MainScreenDataLoaded({this.bestSellers = const [], this.hotSales = const []});
}

class CategoriesLoaded extends MainScreenState {
  final List<ItemCategory> categories;
  CategoriesLoaded(this.categories);
}

class CurrentLocationLoading extends MainScreenState {}

class CurrentLocationError extends MainScreenState {
  final String error;
  CurrentLocationError(this.error);
}

class CurrentLocationLoaded extends MainScreenState {
  final Placemark placemark;
  CurrentLocationLoaded(this.placemark);
}

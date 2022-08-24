part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent {}

class GetCategories extends MainScreenEvent {}

class GetMainScreenData extends MainScreenEvent {}

class GetCurrentLocation extends MainScreenEvent {}

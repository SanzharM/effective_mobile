import 'dart:convert';

import 'package:effective_mobile/core/api/api.dart';
import 'package:effective_mobile/core/api/api_response.dart';
import 'package:effective_mobile/core/api/endpoints.dart';
import 'package:effective_mobile/core/constants/app_icons.dart';
import 'package:effective_mobile/data/app_provider.dart';
import 'package:effective_mobile/domain/models/best_seller.dart';
import 'package:effective_mobile/domain/models/item_category.dart';
import 'package:effective_mobile/domain/models/hot_sale.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MainScreenProvider extends AppProvider {
  final _geolocator = GeolocatorPlatform.instance;
  final _geocoding = GeocodingPlatform.instance;
  Future<List<ItemCategory>> getCategories() async {
    await Future.delayed(const Duration(seconds: 3));
    return const [
      ItemCategory(icon: AppIcons.iphone, title: 'Phones'),
      ItemCategory(icon: AppIcons.computer, title: 'Computer'),
      ItemCategory(icon: AppIcons.health, title: 'Health'),
      ItemCategory(icon: AppIcons.books, title: 'Books'),
      ItemCategory(icon: AppIcons.tools, title: 'Tools'),
      ItemCategory(icon: AppIcons.tools, title: 'Tools'),
      ItemCategory(icon: AppIcons.tools, title: 'Tools'),
    ];
  }

  Future<MainScreenResponse> getData() async {
    final route = Uri.parse(AppEndpoints.host + AppEndpoints.mainPage);
    final response = await api.request(route: route, method: Method.get);

    if (response.isSuccess) {
      try {
        return await compute(_parseMainScreen, response.response?.body);
      } catch (e) {
        return MainScreenResponse(error: e.toString());
      }
    }
    return MainScreenResponse(error: response.error ?? 'Something went wrong');
  }

  static MainScreenResponse _parseMainScreen(String? body) {
    if (body?.isEmpty ?? true) return const MainScreenResponse(error: 'Something went wrong');

    final parsedBody = json.decode(body!);
    if (parsedBody is! Map) return const MainScreenResponse(error: 'Something went wrong');

    final hotSales = (parsedBody['home_store'] as List).map((e) => HotSale.fromMap(e)).toList();
    final bestSellers = (parsedBody['best_seller'] as List).map((e) => BestSeller.fromMap(e)).toList();

    return MainScreenResponse(hotSales: hotSales, bestSellers: bestSellers);
  }

  Future<Placemark?> tryGetLocation() async {
    final result = await _geolocator.checkPermission();
    if (result != LocationPermission.whileInUse && result != LocationPermission.always) {
      await _geolocator.openAppSettings();
      return Future.error('Permission denied');
    }

    final locationData = await _geolocator.getCurrentPosition();
    final placemarks = await _geocoding.placemarkFromCoordinates(locationData.latitude, locationData.longitude);
    return placemarks.first;
  }
}

import 'package:effective_mobile/core/api/api.dart';

abstract class AppProvider {
  final _api = Api();

  Api get api => _api;
}

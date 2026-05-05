import 'package:marco/core/services/mock_api_service.dart';

class RouteRepository {
  final MockApiService _api;

  RouteRepository(this._api);

  Future<void> createRoute({
    required String name,
    required List<String> waypoints,
  }) async {
    await _api.post('/routes', body: {'name': name, 'waypoints': waypoints});
  }
}

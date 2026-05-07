import 'package:marco/core/services/mock_api_service.dart';

class TripLogRepository {
  final MockApiService _api;

  TripLogRepository(this._api);

  Future<void> saveTrip({
    required String routeName,
    required String commuteMode,
    required int routeFeel,
  }) async {
    await _api.post(
      '/trip-logs',
      body: {
        'routeName': routeName,
        'commute_mode': commuteMode,
        'route_feel': routeFeel,
      },
    );
  }
}

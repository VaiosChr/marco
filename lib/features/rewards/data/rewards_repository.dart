import 'package:marco/core/services/mock_api_service.dart';

class RewardsRepository {
  final MockApiService _api;

  RewardsRepository(this._api);

  Future<dynamic> getRewards() async {
    return await _api.get('/rewards');
  }
}

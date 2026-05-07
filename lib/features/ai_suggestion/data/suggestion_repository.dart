import 'package:marco/core/services/mock_api_service.dart';

class FeedbackRepository {
  final MockApiService _api;

  FeedbackRepository(this._api);

  Future<void> submitFeedback({
    required int rating,
    required bool isUseful,
  }) async {
    await _api.post(
      '/suggestion-feedback',
      body: {'rating': rating, 'isUseful': isUseful},
    );
  }
}

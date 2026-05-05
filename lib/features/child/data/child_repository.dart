import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/services/storage_service.dart';
import 'package:marco/features/child/domain/models/child_model.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';

class ChildRepository {
  final MockApiService _api;
  final StorageService _storage;

  ChildRepository(this._api, this._storage);

  Future<ChildModel> createChild({
    required String parentId,
    required String name,
    required int age,
    required String school,
    required String phone,
    String? coParentPhone,
    String? coParentEmail,
    required ConsentModel consents,
  }) async {
    final json = await _api.post(
      '/children',
      body: {
        'parentId': parentId,
        'name': name,
        'age': age,
        'school': school,
        'phone': phone,
        'coParentPhone': coParentPhone,
        'coParentEmail': coParentEmail,
        'consents': consents.toJson(),
        'createdAt': DateTime.now().toIso8601String(),
      },
    );

    ChildModel child = ChildModel.fromJson(json);

    await _storage.saveChild(child);
    return child;
  }

  Future<ChildModel?> getStoredChild() async {
    return await _storage.getChildSession();
  }
}

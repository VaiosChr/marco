import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/services/storage_service.dart';
import 'package:marco/features/auth/domain/models/parent_model.dart';

class AuthRepository {
  final MockApiService _api;
  final StorageService _storage;

  AuthRepository(this._api, this._storage);

  Future<ParentModel> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String neighborhood,
  }) async {
    final json = await _api.post(
      '/parents',
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phone,
        'neighborhood': neighborhood,
      },
    );
    final parent = ParentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      neighborhood: json['neighborhood'],
      isGuardianConfirmed: json['isGuardianConfirmed'],
    );

    await _storage.saveSession(parent);
    return parent;
  }

  Future<bool> verifyOtp(String phone, String code) async {
    if (code.length == 6) return true;
    return false;
  }

  Future<ParentModel?> getStoredSession() async {
    return await _storage.getSession();
  }

  Future<void> signOut() async {
    await _storage.clearSession();
  }
}

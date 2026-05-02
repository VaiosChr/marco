import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/features/auth/domain/models/parent_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _idKey = 'auth.session.id';
  static const String _nameKey = 'auth.session.name';
  static const String _emailKey = 'auth.session.email';
  static const String _phoneKey = 'auth.session.phoneNumber';
  static const String _neighborhoodKey = 'auth.session.neighborhood';
  static const String _guardianConfirmedKey =
      'auth.session.isGuardianConfirmed';

  Future<void> saveSession(ParentModel parent) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_idKey, parent.id);
    await preferences.setString(_nameKey, parent.name);
    await preferences.setString(_emailKey, parent.email);
    await preferences.setString(_phoneKey, parent.phoneNumber);
    await preferences.setString(_neighborhoodKey, parent.neighborhood);
    await preferences.setBool(
      _guardianConfirmedKey,
      parent.isGuardianConfirmed,
    );
  }

  Future<ParentModel?> getSession() async {
    final preferences = await SharedPreferences.getInstance();
    final id = preferences.getString(_idKey);
    if (id == null || id.isEmpty) {
      return null;
    }

    return ParentModel(
      id: id,
      name: preferences.getString(_nameKey) ?? '',
      email: preferences.getString(_emailKey) ?? '',
      phoneNumber: preferences.getString(_phoneKey) ?? '',
      neighborhood: preferences.getString(_neighborhoodKey) ?? '',
      isGuardianConfirmed: preferences.getBool(_guardianConfirmedKey) ?? false,
    );
  }

  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_idKey);
    await preferences.remove(_nameKey);
    await preferences.remove(_emailKey);
    await preferences.remove(_phoneKey);
    await preferences.remove(_neighborhoodKey);
    await preferences.remove(_guardianConfirmedKey);
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/features/auth/domain/models/parent_model.dart';
import 'package:marco/features/child/domain/models/child_model.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_idKey, parent.id);
    await prefs.setString(_nameKey, parent.name);
    await prefs.setString(_emailKey, parent.email);
    await prefs.setString(_phoneKey, parent.phoneNumber);
    await prefs.setString(_neighborhoodKey, parent.neighborhood);
    await prefs.setBool(_guardianConfirmedKey, parent.isGuardianConfirmed);
  }

  Future<ParentModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_idKey);
    if (id == null || id.isEmpty) {
      return null;
    }

    return ParentModel(
      id: id,
      name: prefs.getString(_nameKey) ?? '',
      email: prefs.getString(_emailKey) ?? '',
      phoneNumber: prefs.getString(_phoneKey) ?? '',
      neighborhood: prefs.getString(_neighborhoodKey) ?? '',
      isGuardianConfirmed: prefs.getBool(_guardianConfirmedKey) ?? false,
    );
  }

  Future<void> saveChild(ChildModel child) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('child.session.id', child.id);
    await prefs.setString('child.session.name', child.name);
    await prefs.setInt('child.session.age', child.age);
    await prefs.setString('child.session.school', child.school);
    await prefs.setString('child.session.phone', child.phone);
    if (child.coParentPhone != null) {
      await prefs.setString(
        'child.session.coParentPhone',
        child.coParentPhone!,
      );
    }
    if (child.coParentEmail != null) {
      await prefs.setString(
        'child.session.coParentEmail',
        child.coParentEmail!,
      );
    }
    await prefs.setBool(
      'child.session.processingRoutes',
      child.consents.processingRoutes,
    );
    await prefs.setBool(
      'child.session.aiSuggestions',
      child.consents.aiSuggestions,
    );
    await prefs.setBool('child.session.shareData', child.consents.shareData);
    await prefs.setString(
      'child.session.createdAt',
      child.createdAt.toIso8601String(),
    );
  }

  Future<ChildModel> getChildSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('child.session.id');
    if (id == null || id.isEmpty) {
      throw Exception('No child session found');
    }

    return ChildModel(
      id: id,
      parentId: prefs.getString(_idKey) ?? '',
      name: prefs.getString('child.session.name') ?? '',
      age: prefs.getInt('child.session.age') ?? 0,
      school: prefs.getString('child.session.school') ?? '',
      phone: prefs.getString('child.session.phone') ?? '',
      coParentPhone: prefs.getString('child.session.coParentPhone'),
      coParentEmail: prefs.getString('child.session.coParentEmail'),
      consents: ConsentModel(
        processingRoutes:
            prefs.getBool('child.session.processingRoutes') ?? false,
        aiSuggestions: prefs.getBool('child.session.aiSuggestions') ?? false,
        shareData: prefs.getBool('child.session.shareData') ?? false,
      ),
      createdAt: DateTime.parse(
        prefs.getString('child.session.createdAt') ??
            DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_idKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_neighborhoodKey);
    await prefs.remove(_guardianConfirmedKey);
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

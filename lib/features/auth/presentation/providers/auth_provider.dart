import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/services/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:marco/features/auth/data/auth_repository.dart';
import 'package:marco/features/auth/domain/models/parent_model.dart';

part 'auth_provider.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(mockApiServiceProvider),
    ref.read(storageServiceProvider),
  );
});

class AuthState {
  final ParentModel? parent;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.parent,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    ParentModel? parent,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      parent: parent ?? this.parent,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    _loadSession();
    return const AuthState();
  }

  Future<void> _loadSession() async {
    final repo = ref.read(authRepositoryProvider);
    final parent = await repo.getStoredSession();
    if (parent != null) {
      state = state.copyWith(parent: parent, isAuthenticated: true);
    }
  }
}

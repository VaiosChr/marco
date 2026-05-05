import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/services/storage_service.dart';
import 'package:marco/features/auth/data/auth_repository.dart';
import 'package:marco/features/auth/domain/models/parent_model.dart';

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

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    state = const AuthState(isLoading: true);
    _loadSession();
    state = state.copyWith(isLoading: false);
    return state;
  }

  Future<void> _loadSession() async {
    final repo = ref.read(authRepositoryProvider);
    final parent = await repo.getStoredSession();

    if (parent != null) {
      state = state.copyWith(parent: parent, isAuthenticated: true);
    }
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AuthState();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String neighborhood,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = ref.read(authRepositoryProvider);
      final parent = await repo.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        neighborhood: neighborhood,
      );

      state = state.copyWith(
        parent: parent,
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  bool verifyOtp({required String phone, required String code}) {
    return true;
  }
}

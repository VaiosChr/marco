import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/services/storage_service.dart';
import 'package:marco/features/child/data/child_repository.dart';
import 'package:marco/features/child/domain/models/child_model.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';

final childRepositoryProvider = Provider<ChildRepository>((ref) {
  return ChildRepository(
    ref.read(mockApiServiceProvider),
    ref.read(storageServiceProvider),
  );
});

class ChildState {
  final ChildModel? child;
  final bool isLoading;
  final String? error;

  const ChildState({this.child, this.isLoading = false, this.error});

  ChildState copyWith({ChildModel? child, bool? isLoading, String? error}) {
    return ChildState(
      child: child ?? this.child,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final childProvider = NotifierProvider<ChildNotifier, ChildState>(
  ChildNotifier.new,
);

class ChildNotifier extends Notifier<ChildState> {
  @override
  ChildState build() {
    state = const ChildState(isLoading: true);
    _loadStoredChild();
    state = state.copyWith(isLoading: false);
    return state;
  }

  Future<ChildModel?> createChild({
    required String parentId,
    required String name,
    required int age,
    required String school,
    required String phone,
    String? coParentPhone,
    String? coParentEmail,
    required ConsentModel consents,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = ref.read(childRepositoryProvider);
      final child = await repo.createChild(
        parentId: parentId,
        name: name,
        age: age,
        school: school,
        phone: phone,
        coParentPhone: coParentPhone,
        coParentEmail: coParentEmail,
        consents: consents,
      );

      state = state.copyWith(child: child, isLoading: false);
      return child;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return null;
    }
  }

  Future<void> _loadStoredChild() async {
    final repo = ref.read(childRepositoryProvider);
    final child = await repo.getStoredChild();

    if (child != null) {
      state = state.copyWith(child: child);
    }
  }
}

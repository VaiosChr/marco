import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  Future<void> _handleLogout(WidgetRef ref) async {
    await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(onPressed: () => _handleLogout(ref), text: 'Logout');
  }
}

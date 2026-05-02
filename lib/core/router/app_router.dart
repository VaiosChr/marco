import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';

import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/child/presentation/screens/add_child_screen.dart';
import '../../features/route/presentation/screens/route_entry_screen.dart';
import '../../features/route/presentation/screens/live_status_screen.dart';
import '../../features/ai_suggestion/presentation/screens/ai_suggestion_screen.dart';
import '../../features/trip_log/presentation/screens/trip_log_screen.dart';
import '../../features/rewards/presentation/screens/rewards_screen.dart';
import '../../features/kid_view/presentation/screens/kid_home_screen.dart';

// ---------------------------------------------------------------------------
// Route name constants
// ---------------------------------------------------------------------------
abstract class AppRoutes {
  static const splash = '/';
  static const signup = '/signup';
  static const otp = '/otp';
  static const addChild = '/add-child';
  static const routeEntry = '/route-entry';
  static const liveStatus = '/live-status';
  static const aiSuggestion = '/ai-suggestion';
  static const tripLog = '/trip-log';
  static const rewards = '/rewards';
  static const kidView = '/kid';
}

// ---------------------------------------------------------------------------
// Router provider — depends on auth state so redirects are reactive
// ---------------------------------------------------------------------------
final appRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    // ----- Auth guard -----
    redirect: (context, state) {
      final isAuthenticated = ref.watch(authProvider).isAuthenticated;
      final isOnAuthFlow =
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.otp;

      // Not logged in and trying to reach a protected screen → signup
      if (!isAuthenticated && !isOnAuthFlow) {
        return AppRoutes.signup;
      }

      // Already logged in and landing on auth screens → go home
      if (isAuthenticated && isOnAuthFlow) {
        return AppRoutes.rewards;
      }

      return null; // no redirect needed
    },

    routes: [
      // ── Screen 1: Parent sign-up ──────────────────────────────────────
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (context, state) => SignupScreen(),
      ),

      // ── Screen 2: OTP verification ────────────────────────────────────
      // phoneNumber is passed as a query param so the screen knows what to display
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          return OtpScreen(phoneNumber: phone);
        },
      ),

      // ── Screen 3: Add child & invite co-parent ────────────────────────
      // childId is optional — null means "new child", non-null means "edit"
      GoRoute(
        path: AppRoutes.addChild,
        name: 'addChild',
        builder: (context, state) {
          final childId = state.uri.queryParameters['childId'];
          return AddChildScreen(childId: childId);
        },
      ),

      // ── Screen 4: Route entry (map) ───────────────────────────────────
      GoRoute(
        path: AppRoutes.routeEntry,
        name: 'routeEntry',
        builder: (context, state) {
          final childId = state.uri.queryParameters['childId'] ?? '';
          return RouteEntryScreen(childId: childId);
        },
      ),

      // ── Screen 5: Live route status ───────────────────────────────────
      GoRoute(
        path: AppRoutes.liveStatus,
        name: 'liveStatus',
        builder: (context, state) {
          final routeId = state.uri.queryParameters['routeId'] ?? '';
          return LiveStatusScreen(routeId: routeId);
        },
      ),

      // ── Screen 6: AI suggestion ───────────────────────────────────────
      GoRoute(
        path: AppRoutes.aiSuggestion,
        name: 'aiSuggestion',
        builder: (context, state) {
          final routeId = state.uri.queryParameters['routeId'] ?? '';
          return AiSuggestionScreen(routeId: routeId);
        },
      ),

      // ── Screen 7: Manual trip log ─────────────────────────────────────
      GoRoute(
        path: AppRoutes.tripLog,
        name: 'tripLog',
        builder: (context, state) => const TripLogScreen(),
      ),

      // ── Screen 8: Rewards ─────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.rewards,
        name: 'rewards',
        builder: (context, state) => const RewardsScreen(),
      ),

      // ── Screen 9 (bonus): Kid view ────────────────────────────────────
      // Accessed via deep link: marco://kid?childId=abc123
      GoRoute(
        path: AppRoutes.kidView,
        name: 'kidView',
        builder: (context, state) {
          final childId = state.uri.queryParameters['childId'] ?? '';
          return KidHomeScreen(childId: childId);
        },
      ),
    ],

    // ----- Error fallback -----
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
});

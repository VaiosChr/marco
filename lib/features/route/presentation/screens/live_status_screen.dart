import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/features/route/data/route_repository.dart';
import 'package:marco/features/route/domain/models/route_status_model.dart';
import 'package:marco/features/route/presentation/widgets/indicator_card.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class LiveStatusScreen extends ConsumerWidget {
  const LiveStatusScreen({super.key});

  Future<RouteStatusModel> _fetchRouteStatus(WidgetRef ref) async {
    final repo = RouteRepository(ref.read(mockApiServiceProvider));
    final data = await repo.getRouteStatus();
    return RouteStatusModel.fromJson(data);
  }

  Widget _buildStatusContainer(RouteStatusModel routeStatus) {
    Color color = AppColorsLight.primary;

    switch (routeStatus.overallStatus) {
      case 'CAUTION':
        color = Colors.orange;
        break;
      case 'ALERT':
        color = Colors.red;
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(color: color, width: 2),
      ),
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(routeStatus.overallStatus, style: AppTextStyles.headline2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Status', style: AppTextStyles.title)),
      body: FutureBuilder<RouteStatusModel>(
        future: _fetchRouteStatus(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Failed to load status'));
          }

          final routeStatus = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusContainer(routeStatus),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                SafetyCard(value: routeStatus.safety),
                const SizedBox(height: 12),
                AirQualityCard(value: routeStatus.airQuality),
                const SizedBox(height: 12),
                NoiseCard(value: routeStatus.noise),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {
                      context.pushReplacementNamed(
                        'aiSuggestion',
                        queryParameters: {'routeId': 'r1'},
                      );
                    },
                    text: 'See MARCO Suggestion',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

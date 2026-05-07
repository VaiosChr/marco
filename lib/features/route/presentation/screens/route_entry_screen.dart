import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/services/mock_api_service.dart';
import 'package:marco/core/utils/scaffold_message.dart';
import 'package:marco/features/child/presentation/providers/child_provider.dart';
import 'package:marco/features/route/data/route_repository.dart';
import 'package:marco/features/route/presentation/widgets/map_pin.dart';
import 'package:marco/features/route/presentation/widgets/waypoint_pin.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';
import 'package:marco/shared/widgets/custom_container.dart';
import 'package:marco/shared/widgets/custom_form_field.dart';

class RouteEntryScreen extends ConsumerStatefulWidget {
  const RouteEntryScreen({super.key});

  @override
  ConsumerState<RouteEntryScreen> createState() => _RouteEntryScreenState();
}

class _RouteEntryScreenState extends ConsumerState<RouteEntryScreen> {
  static const LatLng _startPoint = LatLng(40.6115, 22.9738);
  static const LatLng _endPoint = LatLng(40.6076, 22.9784);

  final List<LatLng> _waypoints = <LatLng>[];
  final _routeNameController = TextEditingController();

  void _addWaypoint(LatLng point) {
    setState(() {
      _waypoints.add(point);
    });
  }

  void _undoWaypoint() {
    if (_waypoints.isEmpty) {
      return;
    }

    setState(() {
      _waypoints.removeLast();
    });
  }

  void _clearWaypoints() {
    if (_waypoints.isEmpty) {
      return;
    }

    setState(() {
      _waypoints.clear();
    });
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[
      Marker(
        point: _startPoint,
        width: 44,
        height: 44,
        child: const MapPin(label: 'S', color: AppColorsLight.primary),
      ),
      Marker(
        point: _endPoint,
        width: 44,
        height: 44,
        child: const MapPin(label: 'E', color: Colors.red),
      ),
    ];

    for (final waypoint in _waypoints) {
      markers.add(
        Marker(
          point: waypoint,
          width: 30,
          height: 30,
          child: const WaypointPin(),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childProvider);
    final routeLine = <LatLng>[_startPoint, ..._waypoints, _endPoint];

    return Scaffold(
      appBar: childState.isLoading
          ? null
          : AppBar(
              titleSpacing: 0,
              leading: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${childState.child?.name}, age ${childState.child?.age}',
                    style: AppTextStyles.title,
                  ),
                  Text(
                    childState.child?.school ?? 'No school info',
                    style: AppTextStyles.headline1,
                  ),
                ],
              ),
            ),
      body: childState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name your route', style: AppTextStyles.headline2),
                      const SizedBox(height: 8),
                      CustomFormField(
                        controller: _routeNameController,
                        label: 'Route Name',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap on the map to add waypoints',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      CustomContainer(
                        color: AppColorsLight.primary,
                        child: Row(
                          children: [
                            Icon(Icons.info, color: AppColorsLight.primary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Start 150m from your home for privacy.',
                                style: AppTextStyles.body,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),

                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: _startPoint,
                              initialZoom: 14,
                              onTap: (_, point) => _addWaypoint(point),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.marco',
                              ),
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: routeLine,
                                    strokeWidth: 5,
                                    color: Colors.indigo,
                                  ),
                                ],
                              ),
                              MarkerLayer(markers: _buildMarkers()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'WAYPOINTS (${_waypoints.length})',
                        style: AppTextStyles.headline1,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _waypoints.isEmpty
                                  ? null
                                  : _undoWaypoint,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColorsLight.primary,
                                side: BorderSide(color: AppColorsLight.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.undo),
                                  const SizedBox(width: 8),
                                  const Text('Undo'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _clearWaypoints,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColorsLight.primary,
                                side: BorderSide(color: AppColorsLight.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Clear all'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () => _saveRoute(ref),
                          text: 'Save Route',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _saveRoute(WidgetRef ref) {
    if (_waypoints.isEmpty) {
      showScaffoldMessage(context, 'Please add at least one waypoint.');
      return;
    }
    if (_routeNameController.text.isEmpty) {
      showScaffoldMessage(context, 'Please enter a name for the route.');
      return;
    }

    final repo = RouteRepository(ref.read(mockApiServiceProvider));
    repo.createRoute(
      name: _routeNameController.text.trim(),
      waypoints: _waypoints
          .map((wp) => '${wp.latitude},${wp.longitude}')
          .toList(),
    );

    setState(() {
      _routeNameController.clear();
      _waypoints.clear();
    });

    showScaffoldMessage(context, 'Route saved successfully!');
  }
}

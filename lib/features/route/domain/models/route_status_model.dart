class RouteStatusModel {
  final double safety, airQuality, noise;
  final String name;
  final String overallStatus;

  RouteStatusModel({
    required this.name,
    required this.safety,
    required this.airQuality,
    required this.noise,
    this.overallStatus = 'Good',
  });

  factory RouteStatusModel.fromJson(Map<String, dynamic> json) {
    return RouteStatusModel(
      safety: json['safety']?.toDouble() ?? 0.0,
      airQuality: json['airQuality']?.toDouble() ?? 0.0,
      noise: json['noiseDb']?.toDouble() ?? 0.0,
      name: json['name'] ?? 'Unknown Route',
      overallStatus: json['overallStatus'] ?? 'Unknown',
    );
  }
}

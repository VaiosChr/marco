class BadgeModel {
  final String id;
  final String name;
  final String icon;
  final DateTime? achievedAt;
  final bool unlocked;

  BadgeModel({
    required this.id,
    required this.name,
    required this.icon,
    DateTime? achievedAt,
    required this.unlocked,
  }) : achievedAt = achievedAt ?? DateTime(1970, 1, 1);

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
        achievedAt: json['achievedAt'] != null
          ? DateTime.parse(json['achievedAt'])
          : null,
      unlocked: json['unlocked'] ?? true,
    );
  }
}

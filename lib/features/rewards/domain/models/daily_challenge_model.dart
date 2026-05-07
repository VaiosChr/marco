class DailyChallengeModel {
  final String id;
  final String description;
  final int rewardPoints;
  final int total;
  final bool completed;
  final DateTime? expiresAt;

  DailyChallengeModel({
    required this.id,
    required this.description,
    required this.rewardPoints,
    required this.total,
    required this.completed,
    DateTime? expiresAt,
  }) : expiresAt = expiresAt ?? DateTime(1970, 1, 1);

  factory DailyChallengeModel.fromJson(Map<String, dynamic> json) {
    return DailyChallengeModel(
      id: json['id'],
      description: json['description'],
      rewardPoints: json['rewardPoints'],
      total: json['total'],
      completed: json['completed'],
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
    );
  }
}

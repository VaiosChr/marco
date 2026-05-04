import 'package:marco/features/child/domain/models/consent_model.dart';

class ChildModel {
  final String id;
  final String parentId;
  final String name;
  final int age;
  final String school;
  final String phone;
  final String? coParentPhone;
  final String? coParentEmail;
  final ConsentModel consents;
  final DateTime createdAt;

  const ChildModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.age,
    required this.school,
    required this.phone,
    required this.consents,
    required this.createdAt,
    this.coParentPhone,
    this.coParentEmail,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    final consentsJson = json['consents'];
    return ChildModel(
      id: json['id']?.toString() ?? '',
      parentId: json['parentId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      school: json['school']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      coParentPhone: json['coParentPhone']?.toString(),
      coParentEmail: json['coParentEmail']?.toString(),
      consents: consentsJson is Map<String, dynamic>
          ? ConsentModel.fromJson(consentsJson)
          : ConsentModel(),
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'age': age,
      'school': school,
      'phone': phone,
      'coParentPhone': coParentPhone,
      'coParentEmail': coParentEmail,
      'consents': consents.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

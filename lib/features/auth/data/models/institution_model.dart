import '../../domain/entities/institution.dart';

/// Institution data model for JSON serialization
class InstitutionModel extends Institution {
  const InstitutionModel({
    required super.id,
    required super.name,
    super.description,
    super.address,
    super.phone,
    super.email,
    super.website,
    super.logoUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create InstitutionModel from JSON
  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Convert InstitutionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'logoUrl': logoUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert to domain entity
  Institution toDomain() {
    return Institution(
      id: id,
      name: name,
      description: description,
      address: address,
      phone: phone,
      email: email,
      website: website,
      logoUrl: logoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory InstitutionModel.fromDomain(Institution institution) {
    return InstitutionModel(
      id: institution.id,
      name: institution.name,
      description: institution.description,
      address: institution.address,
      phone: institution.phone,
      email: institution.email,
      website: institution.website,
      logoUrl: institution.logoUrl,
      createdAt: institution.createdAt,
      updatedAt: institution.updatedAt,
    );
  }
}

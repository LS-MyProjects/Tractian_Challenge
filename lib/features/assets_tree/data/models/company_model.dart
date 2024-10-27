import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({
    required String id,
    required String name,
  }) : super(
    id: id,
    name: name,
  );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
import '../../domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required String id,
    required String name,
    String? parentId,
  }) : super(
    id: id,
    name: name,
    parentId: parentId,
  );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }
}
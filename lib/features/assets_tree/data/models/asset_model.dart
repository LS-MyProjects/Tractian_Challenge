import '../../domain/entities/asset.dart';

class AssetModel extends Asset {
  AssetModel({
    required String id,
    required String name,
    String? locationId,
    String? parentId,
    String? sensorType,
    String? status,
  }) : super(
    id: id,
    name: name,
    locationId: locationId,
    parentId: parentId,
    sensorType: sensorType,
    status: status,
  );

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'locationId': locationId,
      'parentId': parentId,
      'sensorType': sensorType,
      'status': status,
    };
  }
}
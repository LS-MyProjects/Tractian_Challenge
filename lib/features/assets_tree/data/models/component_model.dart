import '../../domain/entities/component.dart';

class ComponentModel extends Component {
  ComponentModel({
    required String id,
    required String name,
    String? sensorType,
    String? status,
    String? parentId,
  }) : super(
    id: id,
    name: name,
    sensorType: sensorType,
    status: status,
    parentId: parentId,
  );

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      sensorType: json['sensorType'],
      status: json['status'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sensorType': sensorType,
      'status': status,
      'parentId': parentId,
    };
  }
}
class Component {
  final String id;
  final String name;
  final String? sensorType;
  final String? status;
  final String? parentId;

  Component({
    required this.id,
    required this.name,
    this.sensorType,
    this.status,
    this.parentId
  });
}
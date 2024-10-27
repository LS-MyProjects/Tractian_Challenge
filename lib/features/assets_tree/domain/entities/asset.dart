class Asset {
  final String id;
  final String name;
  final String? locationId;
  final String? sensorType;
  final String? status;
  final String? parentId;

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.sensorType,
    this.status,
    this.parentId,
});
}
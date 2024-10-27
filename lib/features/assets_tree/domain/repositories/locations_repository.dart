import '../entities/location.dart';

abstract class LocationsRepository {
  Future<List<Location>> getLocations(String companyId);
}
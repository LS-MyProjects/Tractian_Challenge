import '../entities/location.dart';
import '../repositories/locations_repository.dart';

class GetLocationsUseCase {
  final LocationsRepository repository;

  GetLocationsUseCase(this.repository);

  Future<List<Location>> call(String companyId) async {
    return await repository.getLocations(companyId);
  }
}
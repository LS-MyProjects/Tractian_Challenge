import '../../domain/entities/location.dart';
import '../../domain/repositories/locations_repository.dart';
import '../datasources/locations_remote_datasource.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsRemoteDataSource remoteDataSource;

  LocationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Location>> getLocations(String companyId) async {
    return await remoteDataSource.getLocations(companyId);
  }
}
import '../../domain/entities/company.dart';
import '../../domain/repositories/companies_repository.dart';
import '../datasources/companies_remote_datasource.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final CompaniesRemoteDataSource remoteDataSource;

  CompaniesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Company>> getCompanies() async {
    return await remoteDataSource.getCompanies();
  }
}
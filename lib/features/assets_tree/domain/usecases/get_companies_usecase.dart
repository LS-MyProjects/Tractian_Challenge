import '../entities/company.dart';
import '../repositories/companies_repository.dart';

class GetCompaniesUseCase {
  final CompaniesRepository repository;

  GetCompaniesUseCase(this.repository);

  Future<List<Company>> call() async {
    return await repository.getCompanies();
  }
}
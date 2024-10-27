import '../entities/company.dart';

abstract class CompaniesRepository {
  Future<List<Company>> getCompanies();
}
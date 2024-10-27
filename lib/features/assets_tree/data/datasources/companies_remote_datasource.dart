import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_constants.dart';
import '../models/company_model.dart';

abstract class CompaniesRemoteDataSource {
  Future<List<CompanyModel>> getCompanies();
}

class CompaniesRemoteDataSourceImpl implements CompaniesRemoteDataSource {
  final http.Client client;

  CompaniesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final response = await client.get(Uri.parse('${ApiConstants.baseUrl}/companies')).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => CompanyModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }
}

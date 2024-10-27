import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_constants.dart';
import '../models/location_model.dart';

abstract class LocationsRemoteDataSource {
  Future<List<LocationModel>> getLocations(String companyId);
}

class LocationsRemoteDataSourceImpl implements LocationsRemoteDataSource {
  final http.Client client;

  LocationsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LocationModel>> getLocations(String companyId) async {
    final response = await client.get(Uri.parse('${ApiConstants.baseUrl}/companies/$companyId/locations')).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => LocationModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}

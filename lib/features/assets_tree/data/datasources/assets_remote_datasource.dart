import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_constants.dart';
import '../models/asset_model.dart';
import '../models/component_model.dart';

abstract class AssetsRemoteDataSource {
  Future<List<AssetModel>> getAssets(String companyId);
  Future<List<ComponentModel>> getComponents(String assetId);
}

class AssetsRemoteDataSourceImpl implements AssetsRemoteDataSource {
  final http.Client client;

  AssetsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AssetModel>> getAssets(String companyId) async {
    try {
      final response = await client
          .get(Uri.parse('${ApiConstants.baseUrl}/companies/$companyId/assets'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => AssetModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load assets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Failed to load assets: $e");
    }
  }

  @override
  Future<List<ComponentModel>> getComponents(String assetId) async {
    try {
      final response = await client
          .get(Uri.parse('${ApiConstants.baseUrl}/assets/$assetId/components'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => ComponentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load components: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Failed to load components: $e");
    }
  }
}
import '../../domain/entities/asset.dart';
import '../../domain/entities/component.dart';
import '../../domain/repositories/assets_repository.dart';
import '../datasources/assets_remote_datasource.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  final AssetsRemoteDataSource remoteDataSource;

  AssetsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Asset>> getAssets(String companyId) async {
    try {
      final assets = await remoteDataSource.getAssets(companyId);
      return assets;
    } catch (e) {
      print("Erro no AssetsRepositoryImpl ao carregar assets: $e");
      throw Exception("Erro ao carregar ativos para a empresa $companyId: $e");
    }
  }

  @override
  Future<List<Component>> getComponents(String assetId) async {
    try {
      final components = await remoteDataSource.getComponents(assetId);
      return components;
    } catch (e) {
      throw Exception("Failed to load components from asset: $assetId: $e");
    }
  }
}
import '../entities/asset.dart';
import '../repositories/assets_repository.dart';

class GetAssetsUseCase {
  final AssetsRepository repository;

  GetAssetsUseCase(this.repository);

  Future<List<Asset>> call(String companyId) async {
    try {
      final assets = await repository.getAssets(companyId);
      return assets;
    } catch (e) {
      throw Exception("Failed to load company assets: $companyId: $e");
    }
  }
}
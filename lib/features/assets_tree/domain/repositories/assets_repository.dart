import '../entities/asset.dart';
import '../entities/component.dart';

abstract class AssetsRepository {
  Future<List<Asset>> getAssets(String companyId);
  Future<List<Component>> getComponents(String assetId);
}
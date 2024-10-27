import '../entities/asset.dart';
import '../repositories/assets_repository.dart';

class FilterAssetsUseCase {
  final AssetsRepository repository;

  FilterAssetsUseCase(this.repository);

  Future<List<Asset>> call(String companyId, {String? sensorType, String? status}) async {
    List<Asset> allAssets = await repository.getAssets(companyId);
    return allAssets.where((asset) {
      final matchesSensorType = sensorType == null || asset.sensorType == sensorType;
      final matchesStatus = status == null || asset.status == status;
      return matchesSensorType && matchesStatus;
    }).toList();
  }
}
import '../entities/component.dart';
import '../repositories/assets_repository.dart';

class GetComponentsUseCase {
  final AssetsRepository repository;

  GetComponentsUseCase(this.repository);

  Future<List<Component>> call(String assetId) async {
    return await repository.getComponents(assetId);
  }
}
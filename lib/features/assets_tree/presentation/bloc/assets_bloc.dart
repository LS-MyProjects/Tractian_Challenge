import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/asset.dart';
import '../../domain/usecases/get_assets_usecase.dart';

abstract class AssetsEvent {}

class LoadAssets extends AssetsEvent {
  final String companyId;

  LoadAssets(this.companyId);
}

class ApplyFilters extends AssetsEvent {
  final String searchQuery;
  final bool filterByEnergySensor;
  final bool filterByCriticalStatus;

  ApplyFilters({
    this.searchQuery = '',
    this.filterByEnergySensor = false,
    this.filterByCriticalStatus = false,
  });
}

abstract class AssetsState {}

class AssetsLoading extends AssetsState {}

class AssetsLoaded extends AssetsState {
  final List<Asset> assets;

  AssetsLoaded(this.assets);
}

class AssetsError extends AssetsState {
  final String message;

  AssetsError(this.message);
}

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final GetAssetsUseCase getAssetsUseCase;
  List<Asset> _allAssets = [];

  AssetsBloc(this.getAssetsUseCase) : super(AssetsLoading()) {
    on<LoadAssets>(_onLoadAssets);
    on<ApplyFilters>(_onApplyFilters);
  }

  Future<void> _onLoadAssets(LoadAssets event, Emitter<AssetsState> emit) async {
    emit(AssetsLoading());
    try {
      _allAssets = await getAssetsUseCase(event.companyId);
      emit(AssetsLoaded(_allAssets));
    } catch (e) {
      emit(AssetsError("Failed to load assets. Try again later."));
    }
  }

  void _onApplyFilters(ApplyFilters event, Emitter<AssetsState> emit) {
    final filteredAssets = _allAssets.where((asset) {
      final matchesQuery = event.searchQuery.isEmpty || asset.name.toLowerCase().contains(event.searchQuery.toLowerCase());

      final matchesSensor = !event.filterByEnergySensor || (asset.sensorType?.toLowerCase() == 'energy');
      final matchesStatus = !event.filterByCriticalStatus || (asset.status?.toLowerCase() == 'alert');

      return matchesQuery && matchesSensor && matchesStatus;
    }).toList();

    emit(AssetsLoaded(filteredAssets));
  }
}
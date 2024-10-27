import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FiltersEvent {}

class FilterBySensorType extends FiltersEvent {
  final String sensorType;

  FilterBySensorType(this.sensorType);
}

class FilterByStatus extends FiltersEvent {
  final String status;

  FilterByStatus(this.status);
}

class ClearFilters extends FiltersEvent {}

class FiltersState {
  final String? sensorType;
  final String? status;

  FiltersState({this.sensorType, this.status});
}

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersState());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is FilterBySensorType) {
      yield FiltersState(sensorType: event.sensorType, status: state.status);
    } else if (event is FilterByStatus) {
      yield FiltersState(sensorType: state.sensorType, status: event.status);
    } else if (event is ClearFilters) {
      yield FiltersState();
    }
  }
}

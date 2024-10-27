import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchEvent {}

class SearchByName extends SearchEvent {
  final String query;

  SearchByName(this.query);
}

class SearchState {
  final String query;

  SearchState(this.query);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(''));

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchByName) {
      yield SearchState(event.query);
    }
  }
}

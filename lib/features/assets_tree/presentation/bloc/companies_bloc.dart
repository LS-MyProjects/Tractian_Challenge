import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/company.dart';
import '../../domain/usecases/get_companies_usecase.dart';

abstract class CompaniesEvent {}

class LoadCompanies extends CompaniesEvent {}

abstract class CompaniesState {}

class CompaniesLoading extends CompaniesState {}

class CompaniesLoaded extends CompaniesState {
  final List<Company> companies;

  CompaniesLoaded(this.companies);
}

class CompaniesError extends CompaniesState {}

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final GetCompaniesUseCase getCompaniesUseCase;

  CompaniesBloc(this.getCompaniesUseCase) : super(CompaniesLoading()) {
    on<LoadCompanies>((event, emit) async {
      emit(CompaniesLoading());
      await Future.delayed(const Duration(seconds: 2));
      try {
        final companies = await getCompaniesUseCase();
        emit(CompaniesLoaded(companies));
      } catch (e) {
        emit(CompaniesError());
      }
    });
  }
}

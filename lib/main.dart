import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'core/ui/app_colors.dart';
import 'core/ui/app_text_styles.dart';
import 'features/assets_tree/presentation/bloc/companies_bloc.dart';
import 'features/assets_tree/presentation/bloc/assets_bloc.dart';
import 'features/assets_tree/presentation/bloc/filters_bloc.dart';
import 'features/assets_tree/presentation/bloc/search_bloc.dart';
import 'features/assets_tree/presentation/pages/home_page.dart';

import 'features/assets_tree/data/datasources/companies_remote_datasource.dart';
import 'features/assets_tree/data/datasources/assets_remote_datasource.dart';
import 'features/assets_tree/data/repositories/companies_repository_impl.dart';
import 'features/assets_tree/data/repositories/assets_repository_impl.dart';
import 'features/assets_tree/domain/usecases/get_companies_usecase.dart';
import 'features/assets_tree/domain/usecases/get_assets_usecase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final http.Client client = http.Client();

    final companiesDataSource = CompaniesRemoteDataSourceImpl(client: client);
    final assetsDataSource = AssetsRemoteDataSourceImpl(client: client);

    final companiesRepository = CompaniesRepositoryImpl(remoteDataSource: companiesDataSource);
    final assetsRepository = AssetsRepositoryImpl(remoteDataSource: assetsDataSource);

    final getCompaniesUseCase = GetCompaniesUseCase(companiesRepository);
    final getAssetsUseCase = GetAssetsUseCase(assetsRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CompaniesBloc(getCompaniesUseCase)..add(LoadCompanies()),
        ),
        BlocProvider(
          create: (_) => AssetsBloc(getAssetsUseCase),
        ),
        BlocProvider(
          create: (_) => FiltersBloc(),
        ),
        BlocProvider(
          create: (_) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Assets',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primaryColor,
            onPrimary: Colors.white,
            secondary: AppColors.secondaryColor,
            onSecondary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.textColor,
            error: AppColors.errorColor,
            onError: Colors.white,
          ),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(
            color: AppColors.secondaryColor,
            iconTheme: IconThemeData(color: Colors.red),
            titleTextStyle: AppTextStyles.appBarTitle,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyLarge: AppTextStyles.bodyText,
            bodyMedium: AppTextStyles.bodyText,
            labelLarge: AppTextStyles.buttonText,
            titleMedium: AppTextStyles.itemSubtitle,
            titleLarge: AppTextStyles.appBarTitle,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

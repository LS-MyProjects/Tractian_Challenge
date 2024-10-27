import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/companies_bloc.dart';
import '../widgets/company_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
      ),
      body: BlocBuilder<CompaniesBloc, CompaniesState>(
        builder: (context, state) {
          if (state is CompaniesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompaniesLoaded) {
            return ListView.builder(
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                return CompanyItemWidget(company: state.companies[index]);
              },
            );
          } else if (state is CompaniesError) {
            return const Center(child: Text('Failed to load companies'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

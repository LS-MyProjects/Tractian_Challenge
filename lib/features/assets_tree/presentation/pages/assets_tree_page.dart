import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/assets_bloc.dart';
import '../widgets/assets_tree_widget.dart';

class AssetsTreePage extends StatefulWidget {
  final String companyId;

  const AssetsTreePage({Key? key, required this.companyId}) : super(key: key);

  @override
  _AssetsTreePageState createState() => _AssetsTreePageState();
}

class _AssetsTreePageState extends State<AssetsTreePage> {
  String searchQuery = '';
  bool filterByEnergySensor = false;
  bool filterByCriticalStatus = false;

  @override
  void initState() {
    super.initState();
    context.read<AssetsBloc>().add(LoadAssets(widget.companyId));
  }

  void _applyFilters() {
    context.read<AssetsBloc>().add(ApplyFilters(
      searchQuery: searchQuery,
      filterByEnergySensor: filterByEnergySensor,
      filterByCriticalStatus: filterByCriticalStatus,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset tree'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Asset',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
                _applyFilters();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: filterByEnergySensor,
                  onChanged: (value) {
                    setState(() {
                      filterByEnergySensor = value ?? false;
                    });
                    _applyFilters();
                  },
                ),
                const Text('Energy sensor'),
                const SizedBox(width: 20),
                Checkbox(
                  value: filterByCriticalStatus,
                  onChanged: (value) {
                    setState(() {
                      filterByCriticalStatus = value ?? false;
                    });
                    _applyFilters();
                  },
                ),
                const Text('Critical'),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<AssetsBloc, AssetsState>(
              builder: (context, state) {
                if (state is AssetsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AssetsLoaded) {
                  return AssetsTreeWidget(assets: state.assets);
                } else if (state is AssetsError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

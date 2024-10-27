import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filters_bloc.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filter assets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButton<String>(
            hint: const Text('Sensor types'),
            items: ['Vibration', 'Energy']
                .map((sensorType) => DropdownMenuItem(
              value: sensorType,
              child: Text(sensorType),
            ))
                .toList(),
            onChanged: (value) {
              context.read<FiltersBloc>().add(FilterBySensorType(value!));
            },
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            hint: const Text('Status'),
            items: ['Operating', 'Alert']
                .map((status) => DropdownMenuItem(
              value: status,
              child: Text(status),
            ))
                .toList(),
            onChanged: (value) {
              context.read<FiltersBloc>().add(FilterByStatus(value!));
            },
          ),
        ],
      ),
    );
  }
}

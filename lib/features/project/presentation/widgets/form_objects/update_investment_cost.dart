import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/data/providers/options_provider.dart';
import 'package:pips/features/project/data/providers/project_provider.dart';
import 'package:pips/features/project/domain/models/full_project.dart';

import '../../../../../../common/resources/sizes_manager.dart';
import '../../../../../../common/resources/strings_manager.dart';
import '../cost_field.dart';

class UpdateInvestmentCost extends ConsumerStatefulWidget {
  const UpdateInvestmentCost({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateInvestmentCost();
}

class _UpdateInvestmentCost extends ConsumerState {
  // TODO: properly initialize FullProject
  _initializeFsInvestments() {
    final options = ref.watch(optionsState);
    final fundingSources = options.fundingSources ?? [];
    final fsInvestments =
        ref.watch(projectProvider.select((value) => value.fsInvestments));

    final updatedInvestments = [...fsInvestments];

    for (var fundingSource in fundingSources) {
      final fsInvestment = FsInvestment(
        fundingSourceId: fundingSource.value,
        fundingSource: fundingSource,
        y2022: 0,
        y2023: 0,
        y2024: 0,
        y2025: 0,
        y2026: 0,
        y2027: 0,
        y2028: 0,
        y2029: 0,
      );

      fsInvestments.add(fsInvestment);
    }

    ref.read(projectProvider.notifier).update(
          fsInvestments: updatedInvestments,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          dataRowHeight: AppSize.s40,
          columnSpacing: AppSize.s1,
          border: TableBorder.all(
            color: Colors.grey,
            width: AppSize.s0_5,
            borderRadius: BorderRadius.circular(AppSize.lg),
          ),
          columns: _buildColumns(context),
          rows: _buildRows(context, ref),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns(BuildContext context) {
    final windowWidth = Breakpoints().getScreenWidth(context) -
        AppSize.s128; // remove horizontal margins
    final columnWidth = windowWidth / 10;

    return <DataColumn>[
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: Text(
            AppStrings.fundingSource.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      ...List.generate(
        8,
        (index) => DataColumn(
          label: SizedBox(
            width: columnWidth,
            child: Center(
              child: Text(
                "${2022 + index}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(
              'TOTAL',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows(BuildContext context, WidgetRef ref) {
    final windowWidth = Breakpoints().getScreenWidth(context) -
        AppSize.s128; // remove horizontal margins
    final columnWidth = windowWidth / 10;

    final options = ref.watch(optionsState);

    final project = ref.watch(projectProvider);

    List<FsInvestment> fsInvestments = project.fsInvestments;

    // if (fsInvestments.isEmpty) {
    //   Future.delayed(Duration.zero, _initializeFsInvestments);
    // }

    return fsInvestments.map((fsInvestment) {
      return DataRow(
        cells: [
          DataCell(
            SizedBox(
              width: columnWidth,
              child: Text(fsInvestment.fundingSource.label),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2022.toString(),
                onChanged: (String value) {
                  //
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2022: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2023.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2023: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2024.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2024: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2025.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2025: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2026.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2026: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2027.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2027: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2028.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2028: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: fsInvestment.y2029.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.fsInvestments];
                  final index = updatedInvestments.indexOf(fsInvestment);
                  final updatedFsInvestment = fsInvestment.copyWith(
                    y2029: double.parse(value),
                  );
                  updatedInvestments[index] = updatedFsInvestment;

                  ref.read(projectProvider.notifier).update(
                        fsInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          // TODO: make static Text
          DataCell(
            SizedBox(
              width: columnWidth,
              child: Text('// TODO'),
            ),
          ),
        ],
      );
    }).toList();
  }
}

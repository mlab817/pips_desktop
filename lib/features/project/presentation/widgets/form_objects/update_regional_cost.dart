import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/data/providers/project_provider.dart';

import '../../../../../../common/resources/sizes_manager.dart';
import '../../../data/providers/options_provider.dart';
import '../cost_field.dart';

class UpdateRegionalCost extends ConsumerStatefulWidget {
  const UpdateRegionalCost({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdateRegionalCostState();
}

class _UpdateRegionalCostState extends ConsumerState<UpdateRegionalCost> {
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
          // total ROW
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
          width: windowWidth / 10,
          child: const Text(
            'REGION',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      ...List.generate(8, (index) {
        final year = 2022 + index;

        return DataColumn(
          label: SizedBox(
            width: columnWidth,
            child: Center(
              child: Text(
                "$year",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
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
    final project = ref.watch(projectProvider);
    final options = ref.watch(optionsState);
    final regions = options.regions ?? [];
    final columnWidth =
        (Breakpoints().getScreenWidth(context) - AppSize.s128) / 10;

    // check if there are already existing regionalInvestments
    final regionalInvestments = project.regionalInvestments;

    // inside the FullProject. if yes, iterate, else create new ones.
    // if (regionalInvestments.isEmpty) {
    //   for (var region in regions) {
    //     final RegionalInvestment regionalInvestment = RegionalInvestment(
    //       regionId: region.value,
    //       region: region,
    //       y2022: 0,
    //       y2023: 0,
    //       y2024: 0,
    //       y2025: 0,
    //       y2026: 0,
    //       y2027: 0,
    //       y2028: 0,
    //       y2029: 0,
    //     );
    //
    //     regionalInvestments.add(regionalInvestment);
    //   }
    //
    //   // update the state
    //   ref
    //       .read(projectProvider.notifier)
    //       .update(regionalInvestments: regionalInvestments);
    // }

    return regionalInvestments.map((regionalInvestment) {
      final label = regionalInvestment.region.label;

      return DataRow(
        cells: [
          DataCell(
            SizedBox(
              width: columnWidth,
              child: Text(label),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2022.toString(),
                onChanged: (String value) {
                  //
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2022: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2023.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2023: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2024.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2024: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2025.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2025: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2026.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2026: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2027.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2027: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2028.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2028: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: regionalInvestment.y2029.toString(),
                onChanged: (String value) {
                  final updatedInvestments = [...project.regionalInvestments];
                  final index = updatedInvestments.indexOf(regionalInvestment);
                  final updatedRegionalInvestment = regionalInvestment.copyWith(
                    y2029: num.parse(value),
                  );
                  updatedInvestments[index] = updatedRegionalInvestment;

                  ref.read(projectProvider.notifier).update(
                        regionalInvestments: updatedInvestments,
                      );
                },
              ),
            ),
          ),
          // TODO: make static Text
          DataCell(
            SizedBox(
              width: columnWidth,
              child: CostField(
                value: null,
                onChanged: (String value) {},
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}

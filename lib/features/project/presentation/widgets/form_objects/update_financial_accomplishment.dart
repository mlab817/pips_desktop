import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/data/providers/project_provider.dart';

import '../../../../../../common/resources/sizes_manager.dart';
import '../../../../../../common/resources/strings_manager.dart';
import '../cost_field.dart';

class UpdateFinancialAccomplishment extends ConsumerWidget {
  const UpdateFinancialAccomplishment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowWidth = Breakpoints().getScreenWidth(context) - AppSize.s128;
    final columnWidth = windowWidth / 4;
    final project = ref.watch(projectProvider);

    final columns = <DataColumn>[
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.year),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.nep),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.gaa),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.disbursement),
          ),
        ),
      ),
    ];

    final rows = [
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2023")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2023.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2023.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2023.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2024")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2024.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2024.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2024.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2025")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2025.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2025.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2025.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2026")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2026.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2026.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2026.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2027")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2027.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2027.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2027.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2028")),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.nep2028.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value: project.financialAccomplishment.gaa2028.toString(),
              onChanged: (String value) {},
            ),
          ),
          DataCell(
            CostField(
              value:
                  project.financialAccomplishment.disbursement2028.toString(),
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
    ];

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
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }
}

import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/data/providers/project_provider.dart';
import 'package:pips/features/project/presentation/widgets/cost_field.dart';

import '../../../../../../common/resources/sizes_manager.dart';

class UpdateFsCost extends ConsumerStatefulWidget {
  const UpdateFsCost({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdateFsCostState();
}

class _UpdateFsCostState extends ConsumerState<UpdateFsCost> {
  @override
  Widget build(BuildContext context) {
    final windowWidth = Breakpoints().getScreenWidth(context) - 128;
    final columnWidth = windowWidth / 6;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          dataRowHeight: AppSize.s60,
          columnSpacing: AppSize.s1,
          border: TableBorder.all(
            color: Colors.grey,
            width: AppSize.s0_5,
            borderRadius: BorderRadius.circular(AppSize.lg),
          ),
          columns: _buildColumns(columnWidth),
          rows: _buildRows(columnWidth),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns(double columnWidth) {
    return List.generate(6, (index) {
      return DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: Center(
            child: Text("FY ${2023 + index}"),
          ),
        ),
      );
    });
  }

  List<DataRow> _buildRows(double columnWidth) {
    final fsCost = ref.watch(projectProvider.select((value) => value.fsCost));

    return [
      DataRow(
        cells: [
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2023?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2023: num.tryParse(value)));
              },
            ),
          )),
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2024?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2024: num.tryParse(value)));
              },
            ),
          )),
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2025?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2025: num.tryParse(value)));
              },
            ),
          )),
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2026?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2026: num.tryParse(value)));
              },
            ),
          )),
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2027?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2027: num.tryParse(value)));
              },
            ),
          )),
          DataCell(SizedBox(
            width: columnWidth,
            child: CostField(
              value: fsCost.y2028?.toString(),
              onChanged: (String value) {
                ref.read(projectProvider.notifier).update(
                    fsCost: fsCost.copyWith(y2028: num.tryParse(value)));
              },
            ),
          )),
        ],
      ),
    ];
  }
}

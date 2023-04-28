import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/features/project/data/providers/options_provider.dart';
import 'package:pips/features/project/data/providers/project_provider.dart';
import 'package:pips/features/project/presentation/widgets/empty_indicator.dart';

import '../../../../../../common/resources/sizes_manager.dart';
import '../../../../../../common/resources/strings_manager.dart';
import '../../../domain/models/options.dart';
import '../select_dialog_content.dart';
import '../new_pap_form.dart';
import '../success_indicator.dart';

class UpdatePap extends ConsumerWidget {
  const UpdatePap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);

    return ListTile(
      title: const Text(AppStrings.programOrProject),
      subtitle: project.type != null
          ? Text(project.type!.label)
          : const Text(AppStrings.selectOne),
      trailing: project.type != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: () => _selectPap(context, ref),
    );
  }

  Future<void> _selectPap(context, ref) async {
    final project = ref.watch(projectProvider);
    final options = ref.watch(optionsState);
    //
    Option? response = await showDialog<Option>(
        context: context,
        builder: (context) {
          Option? selected = project.type;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.programOrProject),
            content: SelectDialogContent(
              options: options?.types ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
              },
            ),
            actions: [
              buildCancel(context),
              buildUpdate(context, () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    ref.read(projectProvider.notifier).update(type: response);

    // TODO: implement the autofill for program/project
    //   if (response != null) {
    //     setState(() {
    //       _project = _project.copyWith(type: response);
    //     });
    //
    //     // if program, set funding source to ng-local
    //     if (response.value == 1) {
    //       setState(() {
    //         _project = _project.copyWith(
    //           fundingSource: _options?.fundingSources?.first, // ng-local
    //           implementationMode:
    //               _options?.implementationModes?.first, // local procurement
    //           // implementation period for programs is 2023 to 2028
    //           startYear: _options?.years
    //               ?.where((element) => int.parse(element.label) == 2023)
    //               .first, // Option(value: 24, label: '2023'),
    //           endYear: _options?.years
    //               ?.where((element) => int.parse(element.label) == 2028)
    //               .first, // Option(value: 29, label: '2028'),
    //         );
    //       });
    //     }
    //   }
    // }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/resources/sizes_manager.dart';
import '../../../../../../common/resources/strings_manager.dart';
import '../../../data/providers/options_provider.dart';
import '../../../data/providers/project_provider.dart';
import '../../../domain/models/options.dart';
import '../empty_indicator.dart';
import '../select_dialog_content.dart';
import '../new_pap_form.dart';
import '../success_indicator.dart';

class UpdateInfraSectors extends ConsumerStatefulWidget {
  const UpdateInfraSectors({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdateInfraSectorsState();
}

class _UpdateInfraSectorsState extends ConsumerState<UpdateInfraSectors> {
  @override
  Widget build(BuildContext context) {
    return _buildInfraSectors();
  }

  Widget _buildInfraSectors() {
    final infrastructureSectors = ref
        .watch(projectProvider.select((value) => value.infrastructureSectors));
    final trip = ref.watch(projectProvider.select((value) => value.trip));

    return ListTile(
      enabled: trip ?? false,
      title: const Text('Main Infrastructure Sector/Subsector'),
      trailing: infrastructureSectors.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      subtitle: infrastructureSectors.isNotEmpty
          ? Text(
              infrastructureSectors.map((element) => element.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      onTap: _selectInfraSectors,
    );
  }

  Future<void> _selectInfraSectors() async {
    final infrastructureSectors = ref
        .watch(projectProvider.select((value) => value.infrastructureSectors));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option>? selected = infrastructureSectors;

          final infraSectors = options.infrastructureSectors ?? [];

          return AlertDialog(
            title: const Text('Main Infrastructure Sector/Subsector'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: infraSectors,
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
              },
            ),
            actions: [
              buildCancel(context),
              buildUpdate(context, () {
                Navigator.pop(context, selected);
              })
            ],
          );
        });

    ref.read(projectProvider.notifier).update(infrastructureSectors: response);
  }
}

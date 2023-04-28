import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/resources/strings_manager.dart';
import '../../../data/providers/project_provider.dart';
import '../empty_indicator.dart';
import '../get_input_decoration.dart';
import '../success_indicator.dart';

class UpdateTitle extends ConsumerStatefulWidget {
  const UpdateTitle({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTitle();
}

class _UpdateTitle extends ConsumerState {
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);

    return ListTile(
      title: const Text(AppStrings.title),
      subtitle: TextField(
        focusNode: _node,
        // controller: _titleController,
        autofocus: true,
        decoration: getTextInputDecoration(
          hintText: AppStrings.title,
        ),
        minLines: 1,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          ref.read(projectProvider.notifier).update(title: value);
        },
      ),
      trailing: project.title != null && project.title!.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: () {
        // focus title
        _node.requestFocus();
      },
    );
  }
}

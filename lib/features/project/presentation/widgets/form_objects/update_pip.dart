import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/resources/strings_manager.dart';
import '../../../data/providers/project_provider.dart';

class UpdatePip extends ConsumerStatefulWidget {
  const UpdatePip({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdatePipState();
}

class _UpdatePipState extends ConsumerState<UpdatePip> {
  @override
  Widget build(BuildContext context) {
    final pip = ref.watch(projectProvider.select((value) => value.pip));

    return SwitchListTile(
        value: pip ?? false,
        title: const Text(AppStrings.publicInvestmentProgram),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of PIP'),
        onChanged: (bool? value) {
          _togglePip(value);
        });
  }

  void _togglePip(bool? value) async {
    final response = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm PIP'),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // TODO: Add description
                children: const <Widget>[
                  Text(
                      'For the PAP to pass the PIP classification, it should meet the following criteria:'),
                  Text('Responsiveness'),
                  Text('- responsiveness details'),
                  Text('Readiness'),
                  Text('- readiness details'),
                  Text('Typology'),
                  Text('- typology details'),
                  Text('Read more link'),
                ]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('I understand'),
              ),
            ],
          );
        });

    ref.read(projectProvider.notifier).update(pip: response);
  }
}

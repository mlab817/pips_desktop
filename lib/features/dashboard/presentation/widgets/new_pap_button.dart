import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../../app/dep_injection.dart';
import '../../../../common/resources/sizes_manager.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/routing.dart';
import '../../../project/domain/models/presets.dart';
import '../../../project/domain/usecase/presets_usecase.dart';

class NewPapButton extends StatefulWidget {
  const NewPapButton({Key? key}) : super(key: key);

  @override
  State<NewPapButton> createState() => _NewPapButtonState();
}

class _NewPapButtonState extends State<NewPapButton> {
  final PresetsUseCase _presetsUseCase = instance<PresetsUseCase>();

  String? _error;
  List<Preset> _presets = [];

  Future<void> _loadPresets() async {
    (await _presetsUseCase.execute(Void())).fold((failure) {
      setState(() {
        _error = failure.message;
      });
    }, (response) {
      setState(() {
        _presets = response.data;
      });
    });
  }

  Future<void> _showNewProjectDialog() async {
    // show preset dialog
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          List<Widget> children = [
            ..._presets.map((preset) {
              return Expanded(
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: InkWell(
                    onTap: () {
                      // TODO: handle tap
                      Navigator.of(context).pop();
                      // TODO: handle tap
                      Future.delayed(Duration.zero, () {
                        Navigator.pushNamed(
                          context,
                          Routes.newPapRoute,
                          arguments: preset,
                        );
                      });
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              BootstrapIcons.file_earmark_medical_fill,
                              color: Colors.black54,
                              size: 54,
                            ),
                            const SizedBox(height: 20),
                            Text(preset.name),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: handle tap
                    Future.delayed(Duration.zero, () {
                      Navigator.pushNamed(context, Routes.newPapRoute);
                    });
                  },
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            BootstrapIcons.pencil_square,
                            color: Colors.black54,
                            size: 54,
                          ),
                          SizedBox(height: 20),
                          Text('Do not use a template'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ];

          return AlertDialog(
            title: const Text("Select a Template"),
            content: Row(
              children: children,
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadPresets();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // showNewProjectDialog()
          _showNewProjectDialog();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mode_edit_outline_outlined),
            const SizedBox(
              width: AppSize.s10,
            ),
            Text(_error != null ? _error! : 'New'),
          ],
        ));
  }
}

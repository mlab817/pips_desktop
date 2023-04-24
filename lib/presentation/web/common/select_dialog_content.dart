import 'package:flutter/material.dart';

import '../../../domain/models/options.dart';
import '../../resources/sizes_manager.dart';

class SelectDialogContent extends StatefulWidget {
  const SelectDialogContent({
    Key? key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.multiple,
  }) : super(key: key);

  final dynamic selected;
  final List<Option> options;
  final bool multiple;
  final Function(dynamic selected) onChanged;

  @override
  State<SelectDialogContent> createState() => _SelectDialogContentState();
}

class _SelectDialogContentState extends State<SelectDialogContent> {
  dynamic _selected;

  @override
  void initState() {
    super.initState();

    if (widget.multiple) {
      _selected = widget.selected as List<Option>?;
    } else {
      _selected = widget.selected as Option?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];

                if (widget.multiple) {
                  if (widget.options[index].children != null &&
                      widget.options[index].children!.isNotEmpty) {
                    final children = option.children!;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CheckboxListTile(
                            value: _selected?.contains(option) ?? false,
                            title: Text(option.label),
                            onChanged: (bool? value) {
                              debugPrint(value.toString());

                              if (value ?? false) {
                                setState(() {
                                  if (_selected != null) {
                                    _selected!.add(option);
                                  } else {
                                    _selected = [option];
                                  }

                                  for (Option child in children) {
                                    _selected!.add(child);
                                  }
                                });
                              } else {
                                setState(() {
                                  _selected?.remove(option);

                                  for (Option child in children) {
                                    _selected!.remove(child);
                                  }
                                });
                              }

                              widget.onChanged(_selected);
                            }),
                        ...List.generate(
                          children.length,
                          (index) {
                            final child = children[index];

                            return CheckboxListTile(
                              value:
                                  _selected?.contains(children[index]) ?? false,
                              title: Row(
                                children: [
                                  const Icon(Icons.subdirectory_arrow_right),
                                  const SizedBox(width: AppSize.s20),
                                  Text(child.label),
                                ],
                              ),
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  setState(() {
                                    if (_selected != null) {
                                      _selected?.add(child);
                                    } else {
                                      _selected = [child];
                                    }
                                  });
                                } else {
                                  setState(() {
                                    _selected?.remove(child);
                                  });
                                }

                                widget.onChanged(_selected);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return CheckboxListTile(
                      value: _selected?.contains(option) ?? false,
                      title: Text(option.label),
                      onChanged: (bool? value) {
                        if (value ?? false) {
                          setState(() {
                            if (_selected != null) {
                              _selected?.add(option);
                            } else {
                              _selected = [option];
                            }
                          });
                        } else {
                          setState(() {
                            _selected?.remove(option);
                          });
                        }

                        widget.onChanged(_selected);
                      });
                }

                return RadioListTile(
                    value: option,
                    groupValue: _selected,
                    title: Text(option.label),
                    onChanged: (value) {
                      setState(() {
                        _selected = value;
                      });

                      widget.onChanged(value);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

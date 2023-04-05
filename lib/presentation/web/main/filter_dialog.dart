import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../data/requests/projects/get_projects_request.dart';
import '../../../domain/models/options.dart';
import '../../../domain/usecase/options_usecase.dart';
import '../../resources/assets_manager.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog(
      {Key? key,
      required this.onDismiss,
      required this.getProjectsRequest,
      required this.onSubmit,
      required this.activeFilters})
      : super(key: key);

  final Function onDismiss;
  final GetProjectsRequest getProjectsRequest;
  final Function onSubmit;
  final List<String> activeFilters;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();

  late GetProjectsRequest _getProjectsRequest;
  late List<String> _activeFilters;

  Options? _options;
  String? _error;
  bool _loading = false;

  Future<void> _loadOptions() async {
    setState(() {
      _loading = true;
    });

    (await _optionsUseCase.execute(Void())).fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _options = response.data;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _loadOptions();

    _getProjectsRequest = widget.getProjectsRequest;

    _activeFilters = widget.activeFilters;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: move loading indicator to reusable component
    // also explore how to make it more responsive
    if (_loading) {
      return Center(
        child: Stack(
          children: [
            const CircleAvatar(
              radius: AppSize.s24,
              child: Padding(
                padding: EdgeInsets.zero,
                child: CircularProgressIndicator(),
              ),
            ),
            Positioned(
              top: AppSize.s12,
              left: AppSize.s12,
              child: ClipOval(
                child: Image.asset(AssetsManager.logo,
                    width: AppSize.s24, height: AppSize.s24),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.tune),
              SizedBox(width: AppSize.md),
              Text(AppStrings.filters),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  widget.onDismiss();
                },
                icon: const Icon(Icons.close)),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.xxxl),
            ),
          ),
        ),
        Expanded(
          child: _options != null
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getFilterHeader('TYPE'),
                      ...?_getTypes(),
                      _getFilterHeader('SPATIAL COVERAGE'),
                      ...?_getSpatialCoverages(),
                      // _getFilterHeader('PDP CHAPTER'),
                      // ...?_getPdpChapters(),
                      _getFilterHeader('CATEGORY'),
                      ...?_getCategories(),
                      _getFilterHeader('PROJECT STATUS'),
                      ...?_getProjectStatuses(),
                      _getFilterHeader('FUNDING SOURCE'),
                      ...?_getFundingSources(),
                      _getFilterHeader('PIPS STATUS'),
                      ...?_getPipsStatuses(),
                      _getFilterHeader('PIPOL STATUS'),
                      ...?_getPipolStatuses(),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Failed to Load Options'),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: AppSize.md,
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint("activeFilters: ${jsonEncode(_activeFilters)}");
                  widget.onSubmit(_getProjectsRequest, _activeFilters);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getFilterHeader(String header) {
    return ListTile(
      title: Text(
        header.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  List<Widget>? _getTypes() {
    return _options!.types?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.types?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedTypes = _getProjectsRequest.types?.toList();

          if (value ?? false) {
            if (selectedTypes != null) {
              selectedTypes.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedTypes = [e.value];
            }
          } else {
            selectedTypes?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedTypes.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(types: selectedTypes);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getSpatialCoverages() {
    return _options!.spatialCoverages?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.spatialCoverages?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.spatialCoverages?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(spatialCoverages: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPdpChapters() {
    return _options!.pdpChapters?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pdpChapters?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.pdpChapters?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pdpChapters: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getCategories() {
    return _options!.categories?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.categories?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.categories?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(categories: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getProjectStatuses() {
    return _options!.projectStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.projectStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.projectStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(projectStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getFundingSources() {
    return _options!.fundingSources?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.fundingSources?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.fundingSources?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              setState(() {
                _activeFilters.add(e.label);
              });
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            setState(() {
              _activeFilters.remove(e.label);
            });
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(fundingSources: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPipsStatuses() {
    return _options!.pipsStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pipsStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.pipsStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              _activeFilters.add(e.label);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            _activeFilters.remove(e.label);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pipsStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPipolStatuses() {
    return _options!.pipolStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pipolStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.pipolStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
              _activeFilters.add(e.label);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
            _activeFilters.remove(e.label);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pipolStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../app/routes.dart';
import '../../../domain/models/options.dart';
import '../../../domain/usecase/options_usecase.dart';
import '../../resources/sizes_manager.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();

  GetProjectsRequest _getProjectsRequest = GetProjectsRequest();

  bool _loading = true;

  Options? _options;

  String? _error;

  Future<void> _loadOptions() async {
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
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          children: [
            const Text('Failed to load options'),
            const SizedBox(
              height: AppSize.s20,
            ),
            ElevatedButton(
                onPressed: _loadOptions, child: const Text('TRY AGAIN')),
          ],
        ),
      );
    }

    return SingleChildScrollView(
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
          _getSubmitButton(),
        ],
      ),
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
            } else {
              selectedTypes = [e.value];
            }
          } else {
            selectedTypes?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
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

  Widget _getSubmitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: TextButton(
            onPressed: () {
              setState(() {
                _getProjectsRequest = GetProjectsRequest();
              });
            },
            child: const Text('RESET FILTERS'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.filterProjectsRoute,
                  arguments: _getProjectsRequest);
            },
            child: const Text('APPLY FILTERS'),
          ),
        ),
      ],
    );
  }
}

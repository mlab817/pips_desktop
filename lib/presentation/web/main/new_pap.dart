import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/usecase/options_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/options.dart';
import '../../../domain/usecase/chatrooms_usecase.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class NewPapView extends StatefulWidget {
  const NewPapView({Key? key}) : super(key: key);

  @override
  State<NewPapView> createState() => _NewPapViewState();
}

class _NewPapViewState extends State<NewPapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('New Program/Project'),
        actions: [
          FilledButton(
            onPressed: () {
              // TODO: handle submit
            },
            child: const Text(AppStrings.submit),
          ),
          const SizedBox(width: AppSize.lg),
        ],
      ),
      body: const NewPap(),
    );
  }
}

class NewPap extends StatefulWidget {
  const NewPap({Key? key}) : super(key: key);

  @override
  State<NewPap> createState() => _NewPapState();
}

class _NewPapState extends State<NewPap> {
  late ScrollController _scrollController;

  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();

  Options? _options;
  String? _error;

  String? _title;
  Option? _type;
  bool _regularProgram = false;
  List<Option>? _bases;
  String? _description;
  double? _totalProjectCost;
  Option? _office;
  List<Option>? _operatingUnits;
  Option? _spatialCoverage;
  List<Option>? _locations;
  bool _iccable = false;
  Option? _approvalLevel;
  DateTime? _approvalLevelDate;
  bool _pip = false;
  Option? _pipTypology;
  bool _cip = false;
  Option? _cipType;
  bool _trip = false;
  bool _rdip = false;
  bool _rdcEndorsementRequired = false;
  String? _rdcEndorsementDate;
  bool _research = false;
  bool _covid = false;
  Option? _pdpChapter;
  List<Option>? _pdpChapters;
  List<Option>? _infrastructureSectors;
  List<Option>? _prerequisites;
  String? _risk;
  String? _expectedOutputs;
  List<Option>? _agenda;
  List<Option>? _sdgs;
  Option? _gad;
  Option? _preparationDocument;
  bool _fsNeedsAssistance = false;
  Option? _fsStatus;

  // TODO: F/S cost
  bool _hasRow = false;

  // TODO: ROW cost
  bool _hasRap = false;

  // TODO: RAP cost
  bool _hasRowRap = false;

  // TODO: ROW/RAP cost
  int? _employmentGenerated;
  int? _employedMale;
  int? _employedFemale;

  Option? _fundingSource;
  List<Option>? _fundingSources;
  Option? _implementationMode;
  List<Option>? _fundingInstitutions;

  Option? _category;
  Option? _projectStatus;
  String? _updates;
  DateTime? _updatesAsOf;
  int? _startYear;
  int? _endYear;

  String? _uacsCode;

  String? _remarks;

  // monitor scroll position
  double _scrollPercentage = 0;

  Future<void> _selectPap() async {
    //
    Option? response = await showDialog<Option>(
        context: context,
        builder: (context) {
          Option? groupValue = _type;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Program or Project'),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.types ?? [];

                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              value: options[index],
                              groupValue: groupValue,
                              title: Text(options[index].label),
                              subtitle: Text(options[index].description ?? ''),
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value;
                                });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, groupValue);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _type = response;
      });
    }

    // if program, set funding source to ng-local
    if (response == _options?.types?.first) {
      setState(() {
        _fundingSource = _options?.fundingSources?.first; // ng-local
        _implementationMode =
            _options?.implementationModes?.first; // local procurement
        // implementation period for programs is 2023 to 2028
        _startYear = 2023;
        _endYear = 2028;
      });
    }
  }

  Future<void> _selectBases() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _bases ?? [];

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Basis for Implementation'),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.bases ?? [];

                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          prototypeItem: CheckboxListTile(
                            title: Text(options.first.label),
                            value: false,
                            onChanged: null,
                          ),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              value: selected.contains(options[index]),
                              title: Text(options[index].label),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value ?? false) {
                                    selected.add(options[index]);
                                  } else {
                                    selected.remove(options[index]);
                                  }
                                });

                                debugPrint(selected.length.toString());

                                setState(() {
                                  selected = selected;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _bases = response;
      });
    }
  }

  // show radio to select office
  Future<void> _selectOffice() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _office;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Office'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _options?.offices?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final offices = _options?.offices ?? [];

                            return RadioListTile(
                                title: Text(offices[index].label),
                                value: offices[index],
                                groupValue: selected,
                                onChanged: (Option? value) {
                                  setState(() {
                                    selected = value;
                                  });
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _office = response;
      });
    }
  }

  Future<void> _selectOus() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _operatingUnits ?? [];

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Operating Units'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _options?.operatingUnits?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var ous = _options?.operatingUnits ?? [];

                          return CheckboxListTile(
                              title: Text(ous[index].label),
                              value: selected.contains(ous[index]),
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  setState(() {
                                    selected.add(ous[index]);
                                  });
                                } else {
                                  setState(() {
                                    selected.remove(ous[index]);
                                  });
                                }
                              });
                        },
                      ),
                    ),
                  ]),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _operatingUnits = response;
      });
    }
  }

  Future<void> _selectPdpChapter() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _pdpChapter;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Main PDP Chapter'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _options?.pdpChapters?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final pdpChapters = _options?.pdpChapters ?? [];

                            return RadioListTile(
                                title: Text(pdpChapters[index].label),
                                value: pdpChapters[index],
                                groupValue: selected,
                                onChanged: (Option? value) {
                                  setState(() {
                                    selected = value;
                                  });
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _pdpChapter = response;
      });
    }
  }

  Future<void> _selectPdpChapters() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _pdpChapters ?? [];

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Other PDP Chapters'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _options?.pdpChapters?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final pdpChapters = _options?.pdpChapters ?? [];

                            return CheckboxListTile(
                                title: Text(pdpChapters[index].label),
                                value: selected.contains(pdpChapters[index]),
                                onChanged: (bool? value) {
                                  if (value ?? false) {
                                    setState(() {
                                      selected.add(pdpChapters[index]);
                                    });
                                  } else {
                                    setState(() {
                                      selected.remove(pdpChapters[index]);
                                    });
                                  }
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _pdpChapter = response;
      });
    }
  }

  Future<void> _selectSdgs() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _sdgs ?? [];

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Sustainable Development Goals'),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.sdgs ?? [];

                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                                title: Text(options[index].label),
                                value: selected.contains(options[index]),
                                onChanged: (bool? value) {
                                  if (value ?? false) {
                                    setState(() {
                                      selected.add(options[index]);
                                    });
                                  } else {
                                    setState(() {
                                      selected.remove(options[index]);
                                    });
                                  }
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    if (response != null) {
      setState(() {
        _sdgs = response;
      });
    }
  }

  Future<void> _loadOptions() async {
    (await _optionsUseCase.execute(Void())).fold((failure) {
      setState(() {
        _error = failure.message;
      });
    }, (response) {
      setState(() {
        _options = response.data;
      });
    });
  }

  // listen to and update scroll position
  void _updateScrollPercentage() {
    double maxHeight = _scrollController.position.maxScrollExtent;
    double currentPosition = _scrollController.position.pixels;

    setState(() {
      _scrollPercentage = currentPosition / maxHeight;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadOptions();

    _scrollController = ScrollController();

    _scrollController.addListener(_updateScrollPercentage);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    List<Widget> children = [
      const Text('General Information'),
      _buildTitle(),
      _buildPap(),
      _buildRegularProgram(),
      _buildBases(),
      _buildDescription(),
      _buildTotalProjectCost(),
      const Divider(),
      // office
      const Text('Implementers'),
      _buildOffice(),
      _buildOus(),
      const Divider(),
      _buildSpatialCoverage(),
      _buildLocations(),
      const Divider(),
      _buildPip(),
      _buildTypology(),
      _buildCip(),
      _buildCipType(),
      _buildTrip(),
      _buildRdip(),
      const Divider(),
      _buildIccable(),
      _buildApprovalLevel(),
      _buildApprovalLevelDate(),
      const Divider(),
      _buildPdpChapter(),
      _buildPdpChapters(),
      _buildExpectedOutputs(),
      const Divider(),
      _buildInfraSectors(),
      _buildPrerequisites(),
      _buildRisk(),
      const Divider(),
      _buildAgenda(),
      const Divider(),
      _buildSdgs(),
      const Divider(),
      _buildGad(),
      const Divider(),
      _buildPreparationDocument(),
      _buildFsStatus(),
      _buildNeedFsAssistance(),
      _buildFsCost(),
      const Divider(),
      _buildRow(),
      _buildRowCost(),
      const Divider(),
      _buildRap(),
      _buildRapCost(),
      const Divider(),
      _buildEmployment(),
      _buildEmploymentMale(),
      _buildEmploymentFemale(),
      const Divider(),
      const Text('Funding Source and Mode of Implementation'),
      _buildFundingSource(),
      _buildFundingSources(),
      _buildFundingInstitutions(),
      _buildImplementationMode(),
      const Divider(),
      _buildRegionalCost(),
      const Divider(),
      _buildProjectCost(),
      const Divider(),
      _buildCategory(),
      _buildReadiness(),
      // implementation period
      _buildStart(),
      _buildEnd(),
      _buildUpdates(),
      _buildUpdatesAsOf(),
      const Divider(),
      _buildPapCode(),
      _buildFinancialAccomplishments(),
      const Divider(),
      _buildRemarks(),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: Update to form progress
        LinearProgressIndicator(
          value: _scrollPercentage,
        ),
        SizedBox(
          height: height - AppSize.s60,
          // update if linear progress indicator resizes
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              // physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSize.s20),
                child: ListView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: false,
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return children[index];
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return ListTile(
      title: const Text('Title'),
      subtitle: TextFormField(
        autofocus: true,
        decoration: _getTextInputDecoration(
          hintText: 'Title',
        ),
        minLines: 1,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String? value) {
          setState(() {
            _title = value;
          });
        },
      ),
      trailing:
          _title != null ? _buildSuccessfulIndicator() : _buildEmptyIndicator(),
    );
  }

  Widget _buildPap() {
    return ListTile(
      title: const Text('Program or Project'),
      subtitle: _type != null ? Text(_type!.label) : const Text('Select one'),
      trailing:
          _type != null ? _buildSuccessfulIndicator() : _buildEmptyIndicator(),
      onTap: () {
        _selectPap();
      },
    );
  }

  Widget _buildRegularProgram() {
    return SwitchListTile(
      value: _regularProgram,
      onChanged: _type?.value == 1
          ? (bool value) {
              setState(() {
                _regularProgram = value;
              });
            }
          : null,
      title: const Text('Regular Program'),
      subtitle: const Text(
          'A regular program refers to a program being implemented by the agencies on a continuing basis.'),
    );
  }

  Widget _buildBases() {
    return ListTile(
      title: const Text('Basis for Implementation'),
      subtitle: Text(
        _bases?.map((e) => e.label).join(', ') ??
            AppStrings.selectAsManyAsApplicable,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _bases != null && _bases!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        _selectBases();
      },
    );
  }

  Widget _buildDescription() {
    String hintText =
        'Identify the Components of the Program/Project. If a Program, please identify the sub-programs/projects and explain the objective of the program/project in terms of responding to the PDP / RM. If the PAP will involve construction of a government facility, specify the definite purpose for the facility to be constructed.';

    return ListTile(
      title: const Text('Description'),
      subtitle: TextField(
        decoration: _getTextInputDecoration(hintText: hintText),
        minLines: 3,
        maxLines: 4,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String? value) {
          setState(() {
            _description = value;
          });
        },
      ),
      trailing: _description != null && _description!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
    );
  }

  Widget _buildTotalProjectCost() {
    return ListTile(
      title: const Text('Total Project Cost in absolute Php'),
      trailing: _totalProjectCost != null && _totalProjectCost! > 0
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      subtitle: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: _getTextInputDecoration(hintText: 'Total Project Cost'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          setState(() {
            _totalProjectCost = double.parse(value);
          });
        },
      ),
    );
  }

  Widget _buildOffice() {
    return ListTile(
        title: const Text('Office'),
        subtitle: Text(_office != null ? _office!.label : AppStrings.selectOne),
        trailing: _office != null
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () {
          _selectOffice();
        });
  }

  Widget _buildOus() {
    return ListTile(
        title: const Text('Operating Units'),
        subtitle: Text(_operatingUnits?.map((e) => e.label).join(', ') ??
            AppStrings.selectAsManyAsApplicable),
        trailing: _operatingUnits != null && _operatingUnits!.isNotEmpty
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () {
          _selectOus();
        });
  }

  Widget _buildSpatialCoverage() {
    return ListTile(
      title: const Text('Spatial Coverage'),
      subtitle: _spatialCoverage != null
          ? Text(_spatialCoverage!.label)
          : const Text('Select one'),
      trailing: _spatialCoverage != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectSpatialCoverage,
    );
  }

  Future<void> _selectSpatialCoverage() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _spatialCoverage;

          return AlertDialog(
            title: const Text('Spatial Coverage'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: StatefulBuilder(builder: (context, setState) {
              final options = _options?.spatialCoverages ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                          value: options[index],
                          groupValue: selected,
                          title: Text(options[index].label),
                          onChanged: (Option? value) {
                            setState(() {
                              selected = value;
                            });
                          });
                    },
                  )),
                ]),
              );
            }),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    setState(() {
      _spatialCoverage = response;
    });
  }

  Widget _buildLocations() {
    return ListTile(
      title: const Text('Location'),
      subtitle: const Text('// TODO: Add options'),
      onTap: () {
        _selectPdpChapter(); // TODO: locations
      },
    );
  }

  Widget _buildIccable() {
    return SwitchListTile(
      title: const Text(
          'Will require Investment Coordination Committee/NEDA Board Approval (ICC-able)?'),
      value: _iccable,
      onChanged: _cip
          ? (bool value) {
              setState(() {
                _iccable = value;
              });
            }
          : null,
    );
  }

  Widget _buildApprovalLevel() {
    return ListTile(
      enabled: _iccable,
      title: const Text('Level (Status) of Approval'),
      subtitle: _approvalLevel != null
          ? Text(_approvalLevel!.label)
          : const Text(AppStrings.selectOne),
      trailing: _approvalLevel != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectApprovalLevel,
    );
  }

  Future<void> _selectApprovalLevel() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _approvalLevel;

          return AlertDialog(
            title: const Text('Level (Status) of Approval'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: StatefulBuilder(builder: (context, setState) {
              final options = _options?.approvalLevels ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              value: options[index],
                              groupValue: selected,
                              title: Text(options[index].label),
                              onChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              });
                        }),
                  ),
                ]),
              );
            }),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    setState(() {
      _approvalLevel = response;
    });
  }

  Widget _buildPip() {
    return SwitchListTile(
        value: _pip,
        title: const Text('Public Investment Program'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of PIP'),
        onChanged: (bool? value) {
          _togglePip(value);
        });
  }

  void _togglePip(bool? value) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm PIP'),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // TODO: Add descriptipn
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
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes')),
            ],
          );
        }).then((value) {
      setState(() {
        _pip = value ?? false;
      });
    });
  }

  Widget _buildTypology() {
    return ListTile(
      enabled: _pip,
      title: const Text('Typology'),
      subtitle: _pipTypology != null
          ? Text(_pipTypology!.label)
          : const Text('Select one'),
      trailing: _pipTypology != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectTypology,
    );
  }

  Future<void> _selectTypology() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _pipTypology;

          return AlertDialog(
            title: const Text('Typology of PIP'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.typologies ?? [];

                return SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    value: options[index],
                                    title: Text(options[index].label),
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value;
                                      });
                                    });
                              }))
                    ]));
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    setState(() {
      _pipTypology = response;
    });
  }

  Widget _buildCip() {
    // TODO: add a confirmation dialog to check if the PAP meets any of the
    // CIP criteria
    return SwitchListTile(
        value: _cip,
        title: const Text('Core Investment Program/Project'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of CIP'),
        onChanged: (bool? value) {
          // if user is trying to change config
          _toggleCip(value);
        });
  }

  void _toggleCip(bool? value) {
    if (value != _cip) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('What the f*** are you trying to do?'),
                  Text('For CIPs, make sure you provide the following: '),
                  Text('- Status of NEDA-ICC processing and the as of date'),
                  Text(
                      '- The preparation document and details of Feasibility Study (if applicable)'),
                  Text(
                      '- Preinvestment costs such as Right of Way and Resettlement Action Plan (if applicable)'),
                  Text('- The level of GAD Responsivess'),
                  Text(
                      '- The number of male and female individuals to be employed'),
                ],
              ),
              actions: [
                _buildCancel(),
                _buildUpdate(onUpdate: () {
                  // push change
                  Navigator.pop(context, value);
                }),
              ],
            );
          });
    }

    setState(() {
      _cip = value ?? false;

      // automatically set iccable to true because all CIPs required NEDA board approval
      _iccable = true;
    });

    if (value ?? false) {
      _showSnackbar(
          message:
              'PAPs tagged as CIP require ICC/NEDA Board approval. Make sure to provide the type and processing status below.');
    }
  }

  Widget _buildCipType() {
    return ListTile(
      enabled: _cip,
      title: const Text('Type of CIP'),
      subtitle:
          _cipType != null ? Text(_cipType!.label) : const Text('Select one'),
      trailing: _cipType != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectCipType,
    );
  }

  Future<void> _selectCipType() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _cipType;

          return AlertDialog(
            title: const Text('Type of CIP'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.cipTypes ?? [];

                return SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    value: options[index],
                                    title: Text(options[index].label),
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value;
                                      });
                                    });
                              }))
                    ]));
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              }),
            ],
          );
        });

    setState(() {
      _cipType = response;
    });
  }

  Widget _buildTrip() {
    return SwitchListTile(
        value: _trip,
        title: const Text('Three Year Rolling Infrastructure Program'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of TRIP'),
        onChanged: (bool? value) {
          setState(() {
            _trip = value ?? false;
          });
        });
  }

  Widget _buildRdip() {
    return SwitchListTile(
        value: _rdip,
        title: const Text('Regional Development Investment Program'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of RDIP'),
        onChanged: (bool? value) {
          setState(() {
            _rdip = value ?? false;
          });
        });
    // TODO: require user to attach RDIP
    // For RDIP, the user should only submit two pages, 1 - RDC endorsement / reso
    // and 2 - the relevant page of the RDIP where the PAP is present
  }

  Widget _buildApprovalLevelDate() {
    return ListTile(
      enabled: _iccable,
      title: const Text('As of'),
      subtitle: _approvalLevelDate != null
          ? Text(DateFormat.yMMMd().format(_approvalLevelDate!))
          : const Text('Select date'),
      trailing: _approvalLevelDate != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      // TODO: update color on success
      onTap: _selectApprovalLevelDate,
    );
  }

  Future<void> _selectApprovalLevelDate() async {
    final DateTime? response = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2010),
      lastDate: DateTime.now(),
    );

    setState(() {
      _approvalLevelDate = response;
    });
  }

  Widget _buildPdpChapter() {
    //
    return ListTile(
      title: const Text('Main PDP Chapter'),
      subtitle: Text(_pdpChapter != null ? _pdpChapter!.label : 'Select one'),
      trailing: _pdpChapter != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(), // TODO: update color on success
      onTap: _selectPdpChapter,
    );
  }

  Widget _buildPdpChapters() {
    //
    return ListTile(
      title: const Text('Other PDP Chapters'),
      subtitle: _pdpChapters?.isNotEmpty != null
          ? Text(_pdpChapters!.map((e) => e.label).join(', '))
          : const Text('Select as many as applicable'),
      trailing: _pdpChapters != null && _pdpChapters!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(), // TODO: update color on success
      onTap: _selectPdpChapters,
    );
  }

  Widget _buildInfraSectors() {
    return ListTile(
        enabled: _trip,
        title: const Text('Main Infrastructure Sector/Subsector'),
        subtitle: const Text(AppStrings.selectAsManyAsApplicable),
        onTap: () async {
          final response = await showDialog(
              context: context,
              builder: (context) {
                final infraSectors = _options?.infrastructureSectors ?? [];

                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: infraSectors.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  value: false,
                                  title: Text(infraSectors[index].label),
                                  onChanged: (bool? value) {
                                    //
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildExpectedOutputs() {
    return ListTile(
      title: const Text('Expected Outputs/Deliverables'),
      subtitle: TextField(
          decoration: _getTextInputDecoration(
              hintText: 'Expected Outputs/Deliverables'),
          style: Theme.of(context).textTheme.bodyMedium,
          minLines: 3,
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              _expectedOutputs = value;
            });
          }),
      trailing: _expectedOutputs != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
    );
  }

  Widget _buildPrerequisites() {
    return ListTile(
      enabled: _trip,
      title: const Text('Status of Implementation Readiness'),
      subtitle: _prerequisites?.isNotEmpty != null
          ? Text(_prerequisites!.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _prerequisites != null && _prerequisites!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPrerequisites,
    );
  }

  Future<void> _selectPrerequisites() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _prerequisites ?? [];

          return AlertDialog(
            title: const Text('Status of Implementation Readiness'),
            content: StatefulBuilder(
              builder: (context, setState) {
                final options = _options?.prerequisites ?? [];
                //
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                value: selected.contains(options[index]),
                                title: Text(options[index].label),
                                onChanged: (bool? value) {
                                  if (value ?? false) {
                                    setState(() {
                                      selected.add(options[index]);
                                    });
                                  } else {
                                    setState(() {
                                      selected.remove(options[index]);
                                    });
                                  }
                                },
                              );
                            }),
                      )
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              })
            ],
          );
        });

    setState(() {
      _prerequisites = response;
    });
  }

  Widget _buildRisk() {
    return ListTile(
      enabled: _trip,
      title: const Text('Implementation Risks and Mitigation Strategies'),
      trailing:
          _risk != null ? _buildSuccessfulIndicator() : _buildEmptyIndicator(),
      subtitle: TextFormField(
          enabled: _trip,
          initialValue: _risk,
          decoration: _getTextInputDecoration(
              hintText: 'Implementation Risks and Mitigation Strategies'),
          // isDense: true,
          style: Theme.of(context).textTheme.bodyMedium,
          minLines: 3,
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              _risk = value;
            });
          }),
    );
  }

  Widget _buildSdgs() {
    //
    return ListTile(
      title: const Text('Sustainable Development Goals'),
      subtitle: _sdgs?.isNotEmpty != null
          ? Text(_sdgs!.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _sdgs != null && _sdgs!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        _selectSdgs();
      },
    );
  }

  Widget _buildAgenda() {
    //
    return ListTile(
      title: const Text('Socioeconomic Agenda'),
      subtitle: _agenda?.isNotEmpty != null
          ? Text(_agenda!.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _agenda?.isNotEmpty != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectAgenda,
    );
  }

  Future<void> _selectAgenda() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _agenda ?? [];
          //
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Socioeconomic Agenda'),
            content: StatefulBuilder(
              builder: (context, setState) {
                final agenda = _options?.agenda ?? [];

                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: agenda.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                                value: selected.contains(agenda[index]),
                                title: Text(agenda[index].label),
                                onChanged: (bool? value) {
                                  if (value ?? false) {
                                    setState(() {
                                      selected.add(agenda[index]);
                                    });
                                  } else {
                                    setState(() {
                                      selected.remove(agenda[index]);
                                    });
                                  }
                                });
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            actions: [
              _buildCancel(),
              _buildUpdate(
                onUpdate: () {
                  Navigator.pop(context, selected);
                },
              ),
            ],
          );
        });

    setState(() {
      _agenda = response;
    });
  }

  Widget _buildGad() {
    return ListTile(
      enabled: _cip,
      title: const Text('Level of Gender Responsiveness'),
      subtitle:
          _gad != null ? Text(_gad!.label) : const Text(AppStrings.selectOne),
      // TODO: trailing
      trailing:
          _gad != null ? _buildSuccessfulIndicator() : _buildEmptyIndicator(),
      onTap: _selectGad,
    );
  }

  Future<void> _selectGad() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _gad;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Level of Gender Responsiveness'),
          content: StatefulBuilder(
            builder: (context, setState) {
              var options = _options?.gads ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                  value: options[index],
                                  groupValue: selected,
                                  title: Text(options[index].label),
                                  onChanged: (value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  });
                            })),
                  ],
                ),
              );
            },
          ),
          actions: [
            _buildCancel(),
            _buildUpdate(
              onUpdate: () {
                Navigator.pop(context, selected);
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _gad = response;
    });
  }

  Widget _buildPreparationDocument() {
    return ListTile(
      enabled: _cip,
      title: const Text('Project Preparation Document'),
      subtitle: _preparationDocument != null
          ? Text(_preparationDocument!.label)
          : const Text(AppStrings.selectOne),
      trailing: _preparationDocument != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPreparationDocument,
    );
  }

  Future<void> _selectPreparationDocument() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _preparationDocument;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Project Preparation Document'),
          content: StatefulBuilder(
            builder: (context, setState) {
              var options = _options?.preparationDocuments ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              value: options[index],
                              groupValue: selected,
                              title: Text(options[index].label),
                              onChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            _buildCancel(),
            _buildUpdate(
              onUpdate: () {
                Navigator.pop(context, selected);
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _preparationDocument = response;
    });
  }

  // CIP only
  Widget _buildNeedFsAssistance() {
    return Container();
  }

  // CIP only
  Widget _buildFsStatus() {
    return Container();
  }

  // CIP only
  Widget _buildFsCost() {
    var windowWidth = MediaQuery.of(context).size.width - 128;

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
          columns: List.generate(6, (index) {
            return DataColumn(
                label: SizedBox(
                    width: windowWidth / 6,
                    child: Center(child: Text("FY ${2023 + index}"))));
          }),
          rows: [
            DataRow(
              cells: List.generate(
                6,
                (index) {
                  return DataCell(SizedBox(
                    width: windowWidth / 6,
                    child: TextField(
                      decoration: _getTextInputDecoration(),
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      expands: false,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CIP only
  Widget _buildRow() {
    return SwitchListTile(
      title: const Text('With Right of Way Component?'),
      value: _hasRow,
      onChanged: _cip
          ? (bool value) {
              setState(() {
                _hasRow = value;
              });
            }
          : null,
    );
  }

  // CIP only
  Widget _buildRowCost() {
    var windowWidth = MediaQuery.of(context).size.width - 128;

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
          columns: List.generate(6, (index) {
            return DataColumn(
                label: SizedBox(
                    width: windowWidth / 6,
                    child: Center(child: Text("FY ${2023 + index}"))));
          }),
          rows: [
            DataRow(
              cells: List.generate(
                6,
                (index) {
                  return DataCell(SizedBox(
                    width: windowWidth / 6,
                    child: TextField(
                      decoration: _getTextInputDecoration(),
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      expands: false,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CIP only
  Widget _buildRap() {
    return SwitchListTile(
      title: const Text('With Resettlement Component?'),
      value: _hasRap,
      onChanged: _cip
          ? (bool value) {
              setState(() {
                _hasRap = value;
              });
            }
          : null,
    );
  }

  // CIP only
  Widget _buildRapCost() {
    var windowWidth = MediaQuery.of(context).size.width - 128;

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
          columns: List.generate(6, (index) {
            return DataColumn(
                label: SizedBox(
                    width: windowWidth / 6,
                    child: Center(child: Text("FY ${2023 + index}"))));
          }),
          rows: [
            DataRow(
              cells: List.generate(
                6,
                (index) {
                  return DataCell(SizedBox(
                    width: windowWidth / 6,
                    child: TextField(
                      decoration: _getTextInputDecoration(),
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      expands: false,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CIP only
  Widget _buildRowRap() {
    return SwitchListTile(
      title: const Text('With Right and Way and Resettlement Component?'),
      value: _hasRap,
      onChanged: _cip
          ? (bool value) {
              setState(() {
                _hasRap = value;
              });
            }
          : null,
    );
  }

  Widget _buildEmployment() {
    var totalEmployment = (_employedFemale ?? 0) + (_employedMale ?? 0);

    return ListTile(
      enabled: _trip,
      title: const Text('No. of persons to be employed'),
      // subtitle: Text(totalEmployment.toString()),
    );
  }

  Widget _buildEmploymentMale() {
    return ListTile(
      enabled: _trip,
      title: const Text('No. of Males'),
      subtitle: TextField(
        decoration: _getTextInputDecoration(hintText: 'No. of Males'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String? value) {
          setState(() {
            _description = value;
          });
        },
      ),
    );
  }

  Widget _buildEmploymentFemale() {
    return ListTile(
      enabled: _trip,
      title: const Text('No. of Females'),
      subtitle: TextField(
        decoration: _getTextInputDecoration(hintText: 'No. of Females'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String? value) {
          setState(() {
            _description = value;
          });
        },
      ),
    );
  }

  Widget _buildFundingSource() {
    return ListTile(
      title: const Text('Main Funding Source'),
      subtitle: _fundingSource != null
          ? Text(_fundingSource!.label)
          : const Text(AppStrings.selectOne),
      trailing: _fundingSource != null
          ? const Icon(
              Icons.done_outline,
              color: Colors.green,
            )
          : const Icon(Icons.done_outline),
      onTap: _type?.value != 1 ? _selectFundingSource : null,
    );
  }

  Future<void> _selectFundingSource() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _fundingSource;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Main Funding Source'),
          content: StatefulBuilder(
            builder: (context, setState) {
              var options = _options?.fundingSources ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _options?.fundingSources?.length ?? 0,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              value: options[index],
                              groupValue: selected,
                              title: Text(options[index].label),
                              onChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            _buildCancel(),
            _buildUpdate(
              onUpdate: () {
                Navigator.pop(context, selected);
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _fundingSource = response;
    });
  }

  Widget _buildFundingSources() {
    return ListTile(
      enabled: _type?.value != 1,
      // enable only if pap type if not a program
      title: const Text(AppStrings.otherFundingSources),
      subtitle: _fundingSources?.isNotEmpty != null
          ? Text(_fundingSources!.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _fundingSources != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectFundingSources,
    );
  }

  Future<void> _selectFundingSources() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Option> selected = _fundingSources ?? [];

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.otherFundingSources),
          content: StatefulBuilder(
            builder: (context, setState) {
              final options = _options?.fundingSources ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                              value: selected.contains(options[index]),
                              title: Text(options[index].label),
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  setState(() {
                                    selected.add(options[index]);
                                  });
                                } else {
                                  setState(() {
                                    selected.remove(options[index]);
                                  });
                                }
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            _buildCancel(),
            _buildUpdate(
              onUpdate: () {
                Navigator.pop(context, selected);
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _fundingSources = response;
    });
  }

  Widget _buildImplementationMode() {
    return ListTile(
      title: const Text(AppStrings.modeOfImplementation),
      subtitle: _implementationMode != null
          ? Text(_implementationMode!.label)
          : const Text(AppStrings.selectOne),
      trailing: _implementationMode != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _type?.value != 1
          ? () async {
              final response = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  Option? selected = _implementationMode;

                  //
                  return AlertDialog(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: AppPadding.lg),
                    title: const Text('Mode of Implementation'),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        final options = _options?.implementationModes ?? [];

                        return SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      _options?.implementationModes?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        value: options[index],
                                        groupValue: selected,
                                        title: Text(options[index].label),
                                        onChanged: (value) {
                                          setState(() {
                                            selected = value;
                                          });
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actions: [
                      _buildCancel(),
                      _buildUpdate(onUpdate: () {
                        Navigator.pop(context, selected);
                      }),
                    ],
                  );
                },
              );

              setState(() {
                _implementationMode = response;
              });
            }
          : null,
    );
  }

  Widget _buildFundingInstitutions() {
    return Container();
  }

  Widget _buildRegionalCost() {
    var windowWidth =
        MediaQuery.of(context).size.width - 128; // remove horizontal margins

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
          columns: <DataColumn>[
            DataColumn(
              label: SizedBox(
                width: windowWidth / 10,
                child: const Text(
                  'REGION',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ...List.generate(
                8,
                (index) => DataColumn(
                      label: SizedBox(
                        width: windowWidth / 10,
                        child: Center(
                          child: Text(
                            "${2022 + index}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )),
            DataColumn(
              label: SizedBox(
                width: windowWidth / 10,
                child: const Center(
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],

          rows: _options?.regions
                  ?.map(
                    (e) => DataRow(
                      key: UniqueKey(),
                      cells: [
                        DataCell(
                          SizedBox(
                            width: windowWidth / 10,
                            child: Text(e.label),
                          ),
                        ),
                        ...List.generate(
                          9,
                          (index) => DataCell(
                            SizedBox(
                              width: windowWidth / 10,
                              child: TextField(
                                decoration: _getTextInputDecoration(),
                                textAlign: TextAlign.right,
                                textAlignVertical: TextAlignVertical.center,
                                expands: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList() ??
              <DataRow>[],
          // total ROW
        ),
      ),
    );
  }

  Widget _buildProjectCost() {
    var windowWidth =
        MediaQuery.of(context).size.width - 128; // remove horizontal margins

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          dataRowHeight: AppSize.s40,
          columnSpacing: AppSize.s1,
          columns: <DataColumn>[
            DataColumn(
              label: SizedBox(
                width: windowWidth / 10,
                child: const Text(
                  'FUNDING SOURCE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ...List.generate(
                8,
                (index) => DataColumn(
                      label: SizedBox(
                        width: windowWidth / 10,
                        child: Center(
                          child: Text(
                            "${2022 + index}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )),
            DataColumn(
              label: SizedBox(
                width: windowWidth / 10,
                child: const Center(
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
          border: TableBorder.all(
            color: Colors.grey,
            width: AppSize.s0_5,
            borderRadius: BorderRadius.circular(AppSize.lg),
          ),
          rows: _options?.fundingSources
                  ?.map(
                    (e) => DataRow(
                      key: UniqueKey(),
                      cells: [
                        DataCell(
                          SizedBox(
                            width: windowWidth / 10,
                            child: Text(e.label),
                          ),
                        ),
                        ...List.generate(
                          9,
                          (index) => DataCell(
                            SizedBox(
                              width: windowWidth / 10,
                              child: TextField(
                                decoration: _getTextInputDecoration(),
                                textAlign: TextAlign.right,
                                textAlignVertical: TextAlignVertical.center,
                                expands: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList() ??
              <DataRow>[],
          // total ROW
        ),
      ),
    );
  }

  // TRIP only
  Widget _buildCategory() {
    return ListTile(
        enabled: _trip,
        title: const Text(AppStrings.category),
        subtitle: _category != null
            ? Text(_category!.label)
            : const Text(AppStrings.selectOne),
        trailing: _category != null
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () async {
          final response = await showDialog(
            context: context,
            builder: (BuildContext context) {
              Option? selected;

              //
              return AlertDialog(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: AppPadding.lg),
                title: const Text('Category'),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    var categories = _options?.categories ?? [];

                    return SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: _options?.categories?.length ?? 0,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    value: categories[index],
                                    groupValue: selected,
                                    title: Text(categories[index].label),
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value;
                                      });
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                actions: [
                  _buildCancel(),
                  _buildUpdate(onUpdate: () {
                    Navigator.pop(context, selected);
                  })
                ],
              );
            },
          );

          setState(() {
            _category = response;
          });
        });
  }

  Widget _buildReadiness() {
    return ListTile(
        enabled: _trip,
        title: const Text('Status of Implementation Readiness'),
        subtitle: _projectStatus != null
            ? Text(_projectStatus!.label)
            : const Text(AppStrings.selectOne),
        trailing: _projectStatus != null
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () async {
          final response = await showDialog(
            context: context,
            builder: (BuildContext context) {
              Option? selected;

              //
              return AlertDialog(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: AppPadding.lg),
                title: const Text('Status of Implementation Readiness'),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    var options = _options?.projectStatuses ?? [];

                    return SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: _options?.projectStatuses?.length ?? 0,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    value: options[index],
                                    groupValue: selected,
                                    title: Text(options[index].label),
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value;
                                      });
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                actions: [
                  _buildCancel(),
                  _buildUpdate(onUpdate: () {
                    Navigator.pop(context, selected);
                  }),
                ],
              );
            },
          );

          // TODO: update category
          setState(() {
            _projectStatus = response;
          });
        });
  }

  Widget _buildUpdates() {
    return ListTile(
      title: const Text(AppStrings.updates),
      subtitle: TextFormField(
          decoration: _getTextInputDecoration(hintText: AppStrings.updates),
          initialValue: _updates,
          minLines: 3,
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: (String value) {
            setState(() {
              _updates = value;
            });
          }),
      trailing: _updates != null
          ? const Icon(Icons.done_outline, color: Colors.green)
          : const Icon(Icons.done_outline),
    );
  }

  Widget _buildUpdatesAsOf() {
    return ListTile(
      title: const Text(AppStrings.asOf),
      subtitle: Text(_updatesAsOf != null
          ? DateFormat.yMMMd().format(_updatesAsOf!)
          : 'Select date'),
      trailing: _updatesAsOf != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () async {
        final DateTime? result = await showDatePicker(
          context: context,
          initialDate: _updatesAsOf != null ? _updatesAsOf! : DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime.now(),
        );

        setState(() {
          _updatesAsOf = result;
        });
      },
    );
  }

  Widget _buildStart() {
    return ListTile(
        enabled: _type?.value != 1,
        // disable when type is program
        title: const Text('Start of Project Implementation'),
        subtitle: _startYear != null
            ? Text(_startYear!.toString())
            : const Text('Select year'),
        trailing: _startYear != null
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () async {
          final response = await showDialog(
              context: context,
              builder: (context) {
                int? selected = _startYear;

                return AlertDialog(
                  title: const Text('Start of Project Implementation'),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: AppPadding.lg),
                  content: StatefulBuilder(
                    builder: (context, setState) {
                      return SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 29, // generate from 2000 to 2028
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      value: 2000 + index,
                                      title: Text((2000 + index).toString()),
                                      groupValue: selected,
                                      onChanged: (value) {
                                        setState(() {
                                          selected = value;
                                        });
                                      });
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  actions: [
                    _buildCancel(),
                    _buildUpdate(onUpdate: () {
                      Navigator.pop(context, selected);
                    }),
                  ],
                );
              });

          // clear end year if it is before start year
          if (_endYear != null && response != null && _endYear! < response!) {
            setState(() {
              _endYear = null;
            });

            _showSnackbar(
                message:
                    'Year of project completion has been removed because it is before the selected start of project implementation.');
          }

          setState(() {
            _startYear = response;
          });
        });
  }

  Widget _buildEnd() {
    return ListTile(
        enabled: _startYear != null,
        title: const Text('Year of Project Completion'),
        subtitle: _endYear != null
            ? Text(_endYear!.toString())
            : (_startYear != null
                ? const Text('Select year')
                : const Text('Select start of project implementation first')),
        trailing: _endYear != null
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () async {
          final response = await showDialog(
              context: context,
              builder: (context) {
                int? selected = _endYear;

                return AlertDialog(
                  title: const Text('Year of Project Completion'),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: AppPadding.lg),
                  content: StatefulBuilder(
                    builder: (context, setState) {
                      return SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 18,
                                itemBuilder: (BuildContext context, int index) {
                                  // the end year starts at 2023 because if it starts at 2022,
                                  // then, it will not be within allowed implementation period 2023-2028
                                  var year = 2023 + index;

                                  return RadioListTile(
                                    value: year,
                                    title: Text(year.toString()),
                                    groupValue: selected,
                                    onChanged: _startYear == null ||
                                            (_startYear != null &&
                                                _startYear! <= year)
                                        ? (int? value) {
                                            setState(() {
                                              selected = value;
                                            });
                                          }
                                        : null,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: [
                    _buildCancel(),
                    _buildUpdate(onUpdate: () {
                      Navigator.pop(context, selected);
                    }),
                  ],
                );
              });

          setState(() {
            _endYear = response;
          });
        });
  }

  Widget _buildPapCode() {
    return ListTile(
      title: const Text('PAP/UACS Code'),
      trailing: _uacsCode != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      subtitle: TextFormField(
        initialValue: _uacsCode,
        decoration: _getTextInputDecoration(hintText: 'PREXC_FPAP_ID'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String? value) {
          setState(() {
            _uacsCode = value;
          });
        },
      ),
    );
  }

  Widget _buildFinancialAccomplishments() {
    var windowWidth = MediaQuery.of(context).size.width - 128;

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
          columns: <DataColumn>[
            DataColumn(
                label: SizedBox(
                    width: windowWidth / 4,
                    child: const Center(child: Text('Year')))),
            DataColumn(
                label: SizedBox(
                    width: windowWidth / 4,
                    child: const Center(child: Text('NEP')))),
            DataColumn(
                label: SizedBox(
                    width: windowWidth / 4,
                    child: const Center(child: Text('GAA')))),
            DataColumn(
                label: SizedBox(
                    width: windowWidth / 4,
                    child: const Center(child: Text('Disbursement')))),
          ],
          rows: List.generate(6, (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(
                  SizedBox(
                      width: windowWidth / 4,
                      child: Text("FY ${index + 2023}")),
                ),
                DataCell(SizedBox(
                  width: windowWidth / 4,
                  child: TextField(
                    decoration: _getTextInputDecoration(),
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    expands: false,
                  ),
                )),
                DataCell(SizedBox(
                  width: windowWidth / 4,
                  child: TextField(
                    decoration: _getTextInputDecoration(),
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    expands: false,
                  ),
                )),
                DataCell(SizedBox(
                  width: windowWidth / 4,
                  child: TextField(
                    decoration: _getTextInputDecoration(),
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    expands: false,
                  ),
                )),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRemarks() {
    return ListTile(
      title: const Text('Remarks (optional)'),
      subtitle: TextFormField(
        initialValue: _remarks,
        decoration: const InputDecoration(
          filled: false,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          hintText: 'Remarks',
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 5,
        onChanged: (String? value) {
          setState(() {
            _remarks = value;
          });
        },
      ),
    );
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  Widget _buildCancel() {
    return TextButton(
        onPressed: _dismissDialog, child: const Text(AppStrings.cancel));
  }

  Widget _buildUpdate({required Function onUpdate}) {
    return FilledButton(
      onPressed: () {
        onUpdate();
      },
      child: const Text(AppStrings.update),
    );
  }

  Widget _buildSuccessfulIndicator() {
    return const Icon(
      Icons.done_outline,
      color: Colors.green,
    );
  }

  Widget _buildEmptyIndicator() {
    return const Icon(
      Icons.done_outline,
    );
  }

  InputDecoration _getTextInputDecoration({String? hintText}) {
    return InputDecoration(
      isCollapsed: true,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      fillColor: Colors.transparent,
      hoverColor: Colors.transparent,
      hintText: hintText ?? '',
    );
  }

  // show a snackbar for the given message
  void _showSnackbar({required String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // clear CIP related fields
  void _clearCipFields() {
    setState(() {
      _iccable = false;
      _cipType = null;
      _approvalLevel = null;
      _approvalLevelDate = null;
      _gad = null;
    });
  }
}

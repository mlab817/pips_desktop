import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/project/full_project_request.dart';
import 'package:pips/domain/models/full_project.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';
import 'package:pips/domain/usecase/offices_usecase.dart';
import 'package:pips/presentation/common/loading_overlay.dart';
import 'package:pips/presentation/resources/assets_manager.dart';

import '../../../app/dep_injection.dart';
import '../../../data/responses/presets/presets.dart';
import '../../../domain/models/office.dart';
import '../../../domain/models/options.dart';
import '../../../domain/usecase/options_usecase.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';
import '../common/cost_field.dart';
import '../common/select_dialog_content.dart';

enum Status {
  error,
  success,
  neutral,
}

class NewPap extends StatefulWidget {
  const NewPap({Key? key, this.preset}) : super(key: key);

  final Preset? preset;

  @override
  State<NewPap> createState() => _NewPapState();
}

class _NewPapState extends State<NewPap> {
  late ScrollController _scrollController;

  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();
  final OfficesUseCase _officesUseCase = instance<OfficesUseCase>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _employedMaleController = TextEditingController();
  final TextEditingController _employedFemaleController =
      TextEditingController();
  final TextEditingController _expectedOutputController =
      TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();
  final TextEditingController _riskController = TextEditingController();
  final TextEditingController _rowAffectedHouseholdsController =
      TextEditingController();
  final TextEditingController _rapAffectedHouseholdsController =
      TextEditingController();
  final TextEditingController _updateController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _papCodeController = TextEditingController();
  final TextEditingController _nep2023Controller = TextEditingController();
  final TextEditingController _nep2024Controller = TextEditingController();
  final TextEditingController _nep2025Controller = TextEditingController();
  final TextEditingController _nep2026Controller = TextEditingController();
  final TextEditingController _nep2027Controller = TextEditingController();
  final TextEditingController _nep2028Controller = TextEditingController();
  final TextEditingController _gaa2023Controller = TextEditingController();
  final TextEditingController _gaa2024Controller = TextEditingController();
  final TextEditingController _gaa2025Controller = TextEditingController();
  final TextEditingController _gaa2026Controller = TextEditingController();
  final TextEditingController _gaa2027Controller = TextEditingController();
  final TextEditingController _gaa2028Controller = TextEditingController();
  final TextEditingController _disbursement2023Controller =
      TextEditingController();
  final TextEditingController _disbursement2024Controller =
      TextEditingController();
  final TextEditingController _disbursement2025Controller =
      TextEditingController();
  final TextEditingController _disbursement2026Controller =
      TextEditingController();
  final TextEditingController _disbursement2027Controller =
      TextEditingController();
  final TextEditingController _disbursement2028Controller =
      TextEditingController();

  // for reviewers use only
  final TextEditingController _commentController = TextEditingController();

  final List<TextEditingController> _fsCostControllers =
      <TextEditingController>[];
  final List<TextEditingController> _rowCostControllers =
      <TextEditingController>[];
  final List<TextEditingController> _rapCostControllers =
      <TextEditingController>[];
  final List<TextEditingController> _regionControllers =
      <TextEditingController>[];
  final List<TextEditingController> _fsControllers = <TextEditingController>[];
  final Map<String, TextEditingController> _faControllers =
      <String, TextEditingController>{};

  // focus nodes
  final FocusNode _titleNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final FocusNode _totalCostNode = FocusNode();
  final FocusNode _employedMaleNode = FocusNode();
  final FocusNode _employedFemaleNode = FocusNode();
  final FocusNode _expectedOutputNode = FocusNode();
  final FocusNode _riskNode = FocusNode();
  final FocusNode _updateNode = FocusNode();
  final FocusNode _remarkNode = FocusNode();
  final FocusNode _papCodeNode = FocusNode();
  final FocusNode _commentNode = FocusNode();

  final List<int> _allYears = [
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
    2029,
  ];

  final List<int> _inclusiveYears = [
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
  ];

  final List<String> _accomplishments = [
    'nep',
    'gaa',
    'disbursement',
  ];

  List<Office>? _offices;

  int get _totalEmployment =>
      (_employedMaleController.text.isNotEmpty
          ? int.parse(_employedMaleController.text)
          : 0) +
      (_employedFemaleController.text.isNotEmpty
          ? int.parse(_employedFemaleController.text)
          : 0);

  Options? _options;
  bool _loading = false;
  String? _error;

  late FullProject _project;

  // monitor scroll position
  double _scrollPercentage = 0;

  Future<void> _selectPap() async {
    //
    Option? response = await showDialog<Option>(
        context: context,
        builder: (context) {
          Option? selected = _project.type;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.programOrProject),
            content: SelectDialogContent(
              options: _options?.types ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(type: response);
      });

      // if program, set funding source to ng-local
      if (response.value == 1) {
        setState(() {
          _project = _project.copyWith(
            fundingSource: _options?.fundingSources?.first, // ng-local
            implementationMode:
                _options?.implementationModes?.first, // local procurement
            // implementation period for programs is 2023 to 2028
            startYear: _options?.years
                ?.where((element) => int.parse(element.label) == 2023)
                .first, // Option(value: 24, label: '2023'),
            endYear: _options?.years
                ?.where((element) => int.parse(element.label) == 2028)
                .first, // Option(value: 29, label: '2028'),
          );
        });
      }
    }
  }

  Future<void> _selectBases() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.bases;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.basisForImplementation),
            content: SelectDialogContent(
              options: _options?.bases ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(bases: response);
      });
    }
  }

  // show radio to select office
  Future<void> _selectOffice() async {
    debugPrint(_project.office.toString());

    final Office? response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Office? selected = _project.office;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.office),
            content: StatefulBuilder(builder: (BuildContext context, setState) {
              final options = _offices ?? [];

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                            value: options[index],
                            groupValue: selected,
                            title: Text(options[index].acronym),
                            onChanged: (Office? value) {
                              setState(() {
                                selected = value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
      _project = _project.copyWith(office: response);
    });
  }

  Future<void> _selectOus() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.operatingUnits;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.operatingUnits),
            content: SelectDialogContent(
              options: _options?.operatingUnits ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(operatingUnits: response);
      });
    }
  }

  Future<void> _selectPdpChapter() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.pdpChapter;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.mainFundingSource),
            content: SelectDialogContent(
              options: _options?.pdpChapters ?? [],
              selected: selected,
              multiple: false,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(pdpChapter: response);
      });
    }
  }

  Future<void> _selectPdpChapters() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.pdpChapters;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.otherPdpChapters),
            content: SelectDialogContent(
              options: _options?.pdpChapters ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(pdpChapters: response);
      });
    }
  }

  Future<void> _selectSdgs() async {
    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.sdgs;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.sustainableDevelopmentGoals),
            content: SelectDialogContent(
              options: _options?.sdgs ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
        _project = _project.copyWith(sdgs: response);
      });
    }
  }

  Future<void> _loadOptions() async {
    setState(() {
      _loading = true;
    });

    (await _optionsUseCase.execute(Void())).fold((failure) {
      if (context.mounted) {
        setState(() {
          _error = failure.message;
          _loading = false;
        });
      }
    }, (response) {
      if (context.mounted) {
        setState(() {
          _options = response.data;
          _loading = false;
        });
      }
    });
  }

  Future<void> _loadOffices() async {
    (await _officesUseCase.execute(GetOfficesRequest(perPage: 100))).fold(
        (failure) {
      _showSnackbar(message: failure.message, status: Status.error);
    }, (response) {
      setState(() {
        _offices = response.data;
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

    _loadOffices();

    _scrollController = ScrollController();

    _scrollController.addListener(_updateScrollPercentage);

    _titleController.addListener(() {
      setState(() {
        _project = _project.copyWith(title: _titleController.text);
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        _project = _project.copyWith(description: _descriptionController.text);
      });
    });

    _employedMaleController.addListener(() {
      setState(() {
        _project = _project.copyWith(
            employedMale: int.parse(_employedMaleController.text));
      });
    });

    _employedFemaleController.addListener(() {
      setState(() {
        _project = _project.copyWith(
            employedFemale: int.parse(_employedFemaleController.text));
      });
    });

    _expectedOutputController.addListener(() {
      setState(() {
        _project =
            _project.copyWith(expectedOutputs: _expectedOutputController.text);
      });
    });

    _totalCostController.addListener(() {
      setState(() {
        _project = _project.copyWith(
            totalCost: _totalCostController.text.isNotEmpty
                ? double.parse(_totalCostController.text)
                : 0);
      });
    });

    _riskController.addListener(() {
      setState(() {
        _project = _project.copyWith(risk: _riskController.text);
      });
    });

    _updateController.addListener(() {
      setState(() {
        _project = _project.copyWith(updates: _updateController.text);
      });
    });

    _remarkController.addListener(() {
      setState(() {
        _project = _project.copyWith(remarks: _remarkController.text);
      });
    });

    _nep2023Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2023: num.parse(_nep2023Controller.text)));
      });
    });
    _nep2024Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2024: num.parse(_nep2024Controller.text)));
      });
    });
    _nep2025Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2025: num.parse(_nep2025Controller.text)));
      });
    });
    _nep2026Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2026: num.parse(_nep2026Controller.text)));
      });
    });
    _nep2027Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2027: num.parse(_nep2027Controller.text)));
      });
    });
    _nep2028Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(nep2028: num.parse(_nep2028Controller.text)));
      });
    });
    _gaa2023Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2023: num.parse(_gaa2023Controller.text)));
      });
    });
    _gaa2024Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2024: num.parse(_gaa2024Controller.text)));
      });
    });
    _gaa2025Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2025: num.parse(_gaa2025Controller.text)));
      });
    });
    _gaa2026Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2026: num.parse(_gaa2026Controller.text)));
      });
    });
    _gaa2027Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2027: num.parse(_gaa2027Controller.text)));
      });
    });
    _gaa2028Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment
                .copyWith(gaa2028: num.parse(_gaa2028Controller.text)));
      });
    });
    _disbursement2023Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2023: num.parse(_disbursement2023Controller.text)));
      });
    });
    _disbursement2024Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2024: num.parse(_disbursement2024Controller.text)));
      });
    });
    _disbursement2025Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2025: num.parse(_disbursement2025Controller.text)));
      });
    });
    _disbursement2026Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2026: num.parse(_disbursement2026Controller.text)));
      });
    });
    _disbursement2027Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2027: num.parse(_disbursement2027Controller.text)));
      });
    });
    _disbursement2028Controller.addListener(() {
      setState(() {
        _project = _project.copyWith(
            financialAccomplishment: _project.financialAccomplishment.copyWith(
                disbursement2028: num.parse(_disbursement2028Controller.text)));
      });
    });

    _project = FullProject();

    // initialize project variable
    // apply preset
    if (widget.preset != null) {
      _project.applyPresets(widget.preset!);
    }
  }

  @override
  void dispose() {
    // dispose controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _employedMaleController.dispose();
    _employedFemaleController.dispose();
    _totalCostController.dispose();
    _riskController.dispose();
    _rowAffectedHouseholdsController.dispose();
    _rapAffectedHouseholdsController.dispose();
    _papCodeController.dispose();
    _updateController.dispose();
    _remarkController.dispose();
    _commentController.dispose();
    _expectedOutputController.dispose();
    _nep2023Controller.dispose();
    _nep2024Controller.dispose();
    _nep2025Controller.dispose();
    _nep2026Controller.dispose();
    _nep2027Controller.dispose();
    _nep2028Controller.dispose();
    _gaa2023Controller.dispose();
    _gaa2024Controller.dispose();
    _gaa2025Controller.dispose();
    _gaa2026Controller.dispose();
    _gaa2027Controller.dispose();
    _gaa2028Controller.dispose();
    _disbursement2023Controller.dispose();
    _disbursement2024Controller.dispose();
    _disbursement2025Controller.dispose();
    _disbursement2026Controller.dispose();
    _disbursement2027Controller.dispose();
    _disbursement2028Controller.dispose();

    for (TextEditingController element in _regionControllers) {
      element.dispose();
    }

    // dispose funding source controllers
    for (TextEditingController element in _fsControllers) {
      element.dispose();
    }

    for (TextEditingController controller in _faControllers.values) {
      controller.dispose();
    }

    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (_loading) {
      return const Center(
        child: LoadingOverlay(),
      );
    }

    if (_options == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetsManager.animMaintenanceJson,
              height: height * 0.5,
            ),
            Text(
              _error ?? 'Unknown error.',
              style: const TextStyle(
                fontSize: FontSize.xl,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: _loadOptions,
              child: const Text('TRY AGAIN'),
            ),
          ],
        ),
      );
    }

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
      _buildResearch(),
      _buildCovid(),
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
      _buildFsCompletionDate(),
      const Divider(),
      _buildRow(),
      _buildRowCost(),
      _buildRowAffectedHouseholds(),
      const Divider(),
      _buildRap(),
      _buildRapCost(),
      _buildRapAffectedHouseholds(),
      const Divider(),
      _buildRowRap(),
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
      _buildPureGrant(),
      _buildPapCode(),
      _buildFinancialAccomplishments(),
      const Divider(),
      _buildRemarks(),
      const Divider(),
      _buildComments(),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(AppStrings.newProgramProject),
          actions: [
            FilledButton(
              onPressed: () {
                // TODO: handle submit
                FullProjectRequest projectToSubmit =
                    FullProjectRequest.fromFullProject(_project);

                debugPrint(projectToSubmit.toJson().toString());
              },
              child: const Text(AppStrings.save),
            ),
            const SizedBox(width: AppSize.lg),
          ],
        ),
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
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSize.s20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
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
      title: const Text(AppStrings.title),
      subtitle: TextFormField(
        focusNode: _titleNode,
        controller: _titleController,
        autofocus: true,
        decoration: _getTextInputDecoration(
          hintText: AppStrings.title,
        ),
        minLines: 1,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: _project.title != null && _project.title!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        // focus title
        _titleNode.requestFocus();
      },
    );
  }

  Widget _buildPap() {
    return ListTile(
      title: const Text(AppStrings.programOrProject),
      subtitle: _project.type != null
          ? Text(_project.type!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.type != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPap,
    );
  }

  Widget _buildRegularProgram() {
    return SwitchListTile(
      value: _project.regularProgram ?? false,
      onChanged: _project.type?.value == 1
          ? (bool value) {
              setState(() {
                _project = _project.copyWith(regularProgram: value);
              });
            }
          : null,
      title: const Text(AppStrings.regularProgram),
      subtitle: const Text(
          'A regular program refers to a program being implemented by the agencies on a continuing basis.'),
    );
  }

  Widget _buildBases() {
    return ListTile(
      title: const Text(AppStrings.basisForImplementation),
      subtitle: _project.bases.isNotEmpty
          ? Text(_project.bases.map((e) => e.label).join(', '))
          : const Text(
              AppStrings.selectAsManyAsApplicable,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      trailing: _project.bases.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectBases,
    );
  }

  Widget _buildDescription() {
    String hintText =
        'Identify the Components of the Program/Project. If a Program, please identify the sub-programs/projects and explain the objective of the program/project in terms of responding to the PDP / RM. If the PAP will involve construction of a government facility, specify the definite purpose for the facility to be constructed.';

    return ListTile(
      title: const Text('Description'),
      subtitle: TextField(
        focusNode: _descriptionNode,
        controller: _descriptionController,
        decoration: _getTextInputDecoration(hintText: hintText),
        minLines: 3,
        maxLines: 4,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: _project.description != null && _project.description!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        _descriptionNode.requestFocus();
      },
    );
  }

  Widget _buildTotalProjectCost() {
    return ListTile(
      title: const Text('Total Project Cost in absolute PHP'),
      trailing: _project.totalCost != null && _project.totalCost! > 0
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      subtitle: TextField(
        focusNode: _totalCostNode,
        controller: _totalCostController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration:
            _getTextInputDecoration(hintText: AppStrings.totalProjectCost),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        _totalCostNode.requestFocus();
      },
    );
  }

  Widget _buildOffice() {
    return ListTile(
      title: const Text(AppStrings.office),
      subtitle: _project.office != null
          ? Text(_project.office!.acronym)
          : const Text(AppStrings.selectOne),
      trailing: _project.office != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectOffice,
    );
  }

  Widget _buildOus() {
    return ListTile(
      title: const Text(AppStrings.operatingUnits),
      subtitle: _project.operatingUnits.isNotEmpty
          ? Text(_project.operatingUnits.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.operatingUnits.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectOus,
    );
  }

  Widget _buildSpatialCoverage() {
    return ListTile(
      title: const Text('Spatial Coverage'),
      subtitle: _project.spatialCoverage != null
          ? Text(_project.spatialCoverage!.label)
          : const Text('Select one'),
      trailing: _project.spatialCoverage != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectSpatialCoverage,
    );
  }

  Future<void> _selectSpatialCoverage() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.spatialCoverage;

          return AlertDialog(
            title: const Text(AppStrings.spatialCoverage),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: _options?.spatialCoverages ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(spatialCoverage: response);
    });
  }

  Widget _buildLocations() {
    return ListTile(
      title: const Text('Regions/Provinces'),
      subtitle: _project.locations.isNotEmpty
          ? Text(_project.locations.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.locations.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectLocations,
    );
  }

  Future<void> _selectLocations() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option>? selected = _project.locations;

          return AlertDialog(
            title: const Text(AppStrings.regionsProvinces),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
                options: _options?.locations ?? [],
                selected: selected,
                multiple: true,
                onChanged: (value) {
                  selected = value;
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
      _project = _project.copyWith(locations: response);
    });
  }

  Widget _buildIccable() {
    return SwitchListTile(
      title: const Text(
          'Will require Investment Coordination Committee/NEDA Board Approval (ICC-able)?'),
      value: _project.iccable ?? false,
      onChanged: _project.cip ?? false
          ? (bool value) {
              setState(() {
                _project = _project.copyWith(iccable: value);
              });
            }
          : null,
    );
  }

  Widget _buildApprovalLevel() {
    return ListTile(
      enabled: _project.iccable ?? false,
      title: const Text('Level (Status) of Approval'),
      subtitle: _project.approvalLevel != null
          ? Text(_project.approvalLevel!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.approvalLevel != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectApprovalLevel,
    );
  }

  Future<void> _selectApprovalLevel() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.approvalLevel;

          return AlertDialog(
            title: const Text('Level (Status) of Approval'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: _options?.approvalLevels ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(approvalLevel: response);
    });
  }

  Widget _buildPip() {
    return SwitchListTile(
        value: _project.pip ?? false,
        title: const Text(AppStrings.publicInvestmentProgram),
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
                  child: const Text('No')),
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes')),
            ],
          );
        }).then((value) {
      setState(() {
        _project = _project.copyWith(pip: value ?? false);
      });
    });
  }

  Widget _buildTypology() {
    return ListTile(
      enabled: _project.pip ?? false,
      title: const Text('Typology'),
      subtitle: _project.typology != null
          ? Text(_project.typology!.label)
          : const Text('Select one'),
      trailing: _project.typology != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectTypology,
    );
  }

  Future<void> _selectTypology() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.typology;

          return AlertDialog(
            title: const Text(AppStrings.typologyOfPip),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: _options?.typologies ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(typology: response);
    });
  }

  Widget _buildCip() {
    // TODO: add a confirmation dialog to check if the PAP meets any of the
    // CIP criteria
    return SwitchListTile(
        value: _project.cip ?? false,
        title: const Text('Core Investment Program/Project'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of CIP'),
        onChanged: (bool? value) {
          // if user is trying to change config
          _toggleCip(value);
        });
  }

  void _toggleCip(bool? value) {
    if (value != _project.cip) {
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
                      '- Pre-investment costs such as Right of Way and Resettlement Action Plan (if applicable)'),
                  Text('- The level of GAD Responsiveness'),
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
      _project = _project.copyWith(
        cip: value ?? false,
        iccable: true,
      );

      // automatically set iccable to true because all CIPs required NEDA board approval
    });

    if (value ?? false) {
      _showSnackbar(
          message:
              'PAPs tagged as CIP require ICC/NEDA Board approval. Make sure to provide the type and processing status below.');
    }
  }

  Widget _buildCipType() {
    return ListTile(
      enabled: _project.cip ?? false,
      title: const Text('Type of CIP'),
      subtitle: _project.cipType != null
          ? Text(_project.cipType!.label)
          : const Text('Select one'),
      trailing: _project.cipType != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectCipType,
    );
  }

  Future<void> _selectCipType() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.cipType;

          return AlertDialog(
            title: const Text('Type of CIP'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: _options?.cipTypes ?? [],
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(cipType: response);
    });
  }

  Widget _buildTrip() {
    return SwitchListTile(
        value: _project.trip ?? false,
        title: const Text('Three Year Rolling Infrastructure Program'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of TRIP'),
        onChanged: (bool? value) {
          setState(() {
            _project = _project.copyWith(trip: value ?? false);
          });
        });
  }

  Widget _buildRdip() {
    return SwitchListTile(
        value: _project.rdip ?? false,
        title: const Text('Regional Development Investment Program'),
        // TODO: Explain the requirements to be part of RDIP
        subtitle: const Text(
            'To facilitate validation, please make sure to upload the relevant RDC endorsement later.'),
        onChanged: (bool? value) {
          setState(() {
            _project = _project.copyWith(rdip: value ?? false);
          });
        });
    // TODO: require user to attach RDIP
    // For RDIP, the user should only submit two pages, 1 - RDC endorsement / reso
    // and 2 - the relevant page of the RDIP where the PAP is present
  }

  Widget _buildResearch() {
    return SwitchListTile(
        value: _project.research ?? false,
        title: const Text('Is it a research and development project?'),
        // TODO: Explain the requirements to be part of RDIP
        onChanged: (bool? value) {
          setState(() {
            _project = _project.copyWith(research: value ?? false);
          });
        });
  }

  Widget _buildCovid() {
    return SwitchListTile(
        value: _project.covid ?? false,
        title: const Text('Is it response to COVID-19 pandemic'),
        // TODO: Explain the requirements to be a response of COVID-19
        onChanged: (bool? value) {
          setState(() {
            _project = _project.copyWith(covid: value ?? false);
          });
        });
  }

  Widget _buildApprovalLevelDate() {
    return ListTile(
      enabled: _project.iccable ?? false,
      title: const Text(AppStrings.asOf),
      subtitle: _project.approvalLevelDate != null
          ? Text(DateFormat.yMMMd().format(_project.approvalLevelDate!))
          : const Text(AppStrings.selectDate),
      trailing: _project.approvalLevelDate != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      // TODO: update color on success
      onTap: _selectApprovalLevelDate,
    );
  }

  Future<void> _selectApprovalLevelDate() async {
    DateTime? approvalLevelDate = _project.approvalLevelDate;

    final DateTime? response = await showDatePicker(
      context: context,
      initialDate: approvalLevelDate ?? DateTime.now(),
      firstDate: DateTime.utc(2010),
      lastDate: DateTime.now(),
    );

    setState(() {
      _project = _project.copyWith(approvalLevelDate: response);
    });
  }

  Widget _buildPdpChapter() {
    //
    return ListTile(
      title: const Text('Main PDP Chapter'),
      subtitle: Text(_project.pdpChapter != null
          ? _project.pdpChapter!.label
          : 'Select one'),
      trailing: _project.pdpChapter != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPdpChapter,
    );
  }

  Widget _buildPdpChapters() {
    //
    return ListTile(
      title: const Text('Other PDP Chapters'),
      subtitle: _project.pdpChapters.isNotEmpty
          ? Text(_project.pdpChapters.map((e) => e.label).join(', '))
          : const Text('Select as many as applicable'),
      trailing: _project.pdpChapters.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(), // TODO: update color on success
      onTap: _selectPdpChapters,
    );
  }

  Widget _buildInfraSectors() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text('Main Infrastructure Sector/Subsector'),
      trailing: _project.infrastructureSectors.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      subtitle: _project.infrastructureSectors.isNotEmpty
          ? Text(_project.infrastructureSectors
              .map((element) => element.label)
              .join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      onTap: _selectInfraSectors,
    );
  }

  Future<void> _selectInfraSectors() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option>? selected = _project.infrastructureSectors;

          final infraSectors = _options?.infrastructureSectors ?? [];

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
              _buildCancel(),
              _buildUpdate(onUpdate: () {
                Navigator.pop(context, selected);
              })
            ],
          );
        });

    setState(() {
      _project = _project.copyWith(infrastructureSectors: response);
    });
  }

  Widget _buildExpectedOutputs() {
    return ListTile(
        title: const Text('Expected Outputs/Deliverables'),
        subtitle: TextField(
          focusNode: _expectedOutputNode,
          controller: _expectedOutputController,
          decoration: _getTextInputDecoration(
              hintText: 'Expected Outputs/Deliverables'),
          style: Theme.of(context).textTheme.bodyMedium,
          minLines: 3,
          maxLines: 4,
        ),
        trailing: _project.expectedOutputs != null &&
                _project.expectedOutputs!.isNotEmpty
            ? _buildSuccessfulIndicator()
            : _buildEmptyIndicator(),
        onTap: () {
          _expectedOutputNode.requestFocus();
        });
  }

  Widget _buildPrerequisites() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text('Status of Implementation Readiness'),
      subtitle: _project.prerequisites.isNotEmpty
          ? Text(_project.prerequisites.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.prerequisites.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPrerequisites,
    );
  }

  Future<void> _selectPrerequisites() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.prerequisites;

          return AlertDialog(
            title: const Text('Status of Implementation Readiness'),
            content: SelectDialogContent(
              options: _options?.prerequisites ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(prerequisites: response);
    });
  }

  Widget _buildRisk() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text('Implementation Risks and Mitigation Strategies'),
      trailing: _project.risk != null && _project.risk!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      subtitle: TextFormField(
        enabled: _project.trip ?? false,
        focusNode: _riskNode,
        controller: _riskController,
        decoration: _getTextInputDecoration(
            hintText: 'Implementation Risks and Mitigation Strategies'),
        // isDense: true,
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 4,
      ),
      onTap: () {
        _riskNode.requestFocus();
      },
    );
  }

  Widget _buildSdgs() {
    //
    return ListTile(
      title: const Text('Sustainable Development Goals'),
      subtitle: _project.sdgs.isNotEmpty
          ? Text(_project.sdgs.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.sdgs.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectSdgs,
    );
  }

  Widget _buildAgenda() {
    //
    return ListTile(
      title: const Text('Socioeconomic Agenda'),
      subtitle: _project.agenda.isNotEmpty
          ? Text(_project.agenda.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.agenda.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectAgenda,
    );
  }

  Future<void> _selectAgenda() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = _project.agenda;
          //
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Socioeconomic Agenda'),
            content: SelectDialogContent(
              options: _options?.agenda ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(agenda: response);
    });
  }

  Widget _buildGad() {
    return ListTile(
      enabled: _project.cip ?? false,
      title: const Text('Level of Gender Responsiveness'),
      subtitle: _project.gad != null
          ? Text(_project.gad!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.gad != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectGad,
    );
  }

  Future<void> _selectGad() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _project.gad;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Level of Gender Responsiveness'),
          content: SelectDialogContent(
            options: _options?.gads ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(gad: response);
    });
  }

  Widget _buildPreparationDocument() {
    return ListTile(
      enabled: _project.cip ?? false,
      title: const Text('Project Preparation Document'),
      subtitle: _project.preparationDocument != null
          ? Text(_project.preparationDocument!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.preparationDocument != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectPreparationDocument,
    );
  }

  Future<void> _selectPreparationDocument() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _project.preparationDocument;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Project Preparation Document'),
          content: SelectDialogContent(
            options: _options?.preparationDocuments ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(preparationDocument: response);
    });
  }

  // CIP only
  Widget _buildNeedFsAssistance() {
    return SwitchListTile(
      value: _project.fsNeedsAssistance ?? false,
      title:
          const Text('Requires assistance in the conduct of Feasibility Study'),
      onChanged: (bool value) {
        setState(() {
          _project = _project.copyWith(fsNeedsAssistance: value);
        });
      },
    );
  }

  // CIP only
  Widget _buildFsStatus() {
    return ListTile(
      title: const Text('Status of Feasibility Study'),
      subtitle: _project.fsStatus != null
          ? Text(_project.fsStatus!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.fsStatus != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _project.cip ?? false ? _selectFsStatus : null,
    );
  }

  Future<void> _selectFsStatus() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.fsStatus;

          //
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Status of Feasibility Study'),
            content: SelectDialogContent(
                options: _options?.fsStatuses ?? [],
                selected: selected,
                multiple: false,
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                }),
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
      _project = _project.copyWith(fsStatus: response);
    });
  }

  Widget _buildFsCompletionDate() {
    return ListTile(
      title: const Text('F/S Target Completion Date'),
      subtitle: _project.fsCompletionDate != null
          ? Text(DateFormat.yMMMd().format(_project.fsCompletionDate!))
          : const Text('Select date'),
      trailing: _project.fsCompletionDate != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectFsCompletionDate,
    );
  }

  Future<void> _selectFsCompletionDate() async {
    final DateTime? response = await showDatePicker(
      context: context,
      initialDate: _project.fsCompletionDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2028),
    );

    setState(() {
      _project = _project.copyWith(fsCompletionDate: response);
    });
  }

  // CIP only
  Widget _buildFsCost() {
    final windowWidth = MediaQuery.of(context).size.width - 128;
    final columnWidth = windowWidth / 6;

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
                width: columnWidth,
                child: Center(
                  child: Text("FY ${2023 + index}"),
                ),
              ),
            );
          }),
          rows: [
            DataRow(
              cells: List.generate(
                6,
                (index) {
                  return DataCell(SizedBox(
                    width: columnWidth,
                    child: TextField(
                      key: ValueKey("fs_cost_$index"),
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
      value: _project.hasRow ?? false,
      onChanged: _project.cip ?? false
          ? (bool value) {
              setState(() {
                _project = _project.copyWith(hasRow: value);
              });
            }
          : null,
    );
  }

  // CIP only
  Widget _buildRowCost() {
    final windowWidth = Breakpoints().getScreenWidth(context) - 128;
    final columnWidth = windowWidth / 6;

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
                width: columnWidth,
                child: Center(
                  child: Text("FY ${2023 + index}"),
                ),
              ),
            );
          }),
          rows: [
            DataRow(
              cells: List.generate(
                6,
                (index) {
                  return DataCell(SizedBox(
                    width: columnWidth,
                    child: TextField(
                      key: ValueKey("row_$index"),
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

  Widget _buildRowAffectedHouseholds() {
    return ListTile(
      title: const Text('Affected Households'),
      subtitle: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: _rowAffectedHouseholdsController,
        decoration: _getTextInputDecoration(),
      ),
    );
  }

  // CIP only
  Widget _buildRap() {
    return SwitchListTile(
      title: const Text('With Resettlement Component?'),
      value: _project.hasRap ?? false,
      onChanged: _project.cip ?? false
          ? (bool value) {
              setState(() {
                _project = _project.copyWith(hasRap: value);
              });
            }
          : null,
    );
  }

  // CIP only
  Widget _buildRapCost() {
    final windowWidth = MediaQuery.of(context).size.width - 128;
    final columnWidth = windowWidth / 6;

    final columns = List.generate(6, (index) {
      return DataColumn(
          label: SizedBox(
              width: columnWidth,
              child: Center(child: Text("FY ${2023 + index}"))));
    });

    final rows = [
      DataRow(
        cells: List.generate(
          6,
          (index) {
            return DataCell(SizedBox(
              width: columnWidth,
              child: TextField(
                key: ValueKey("rap_$index"),
                decoration: _getTextInputDecoration(),
                textAlign: TextAlign.right,
                textAlignVertical: TextAlignVertical.center,
                expands: false,
              ),
            ));
          },
        ),
      ),
    ];

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
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }

  Widget _buildRapAffectedHouseholds() {
    return ListTile(
      title: const Text('Affected Households'),
      subtitle: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: _rapAffectedHouseholdsController,
        decoration: _getTextInputDecoration(),
      ),
    );
  }

  // CIP only
  Widget _buildRowRap() {
    return SwitchListTile(
      title: const Text('With Right and Way and Resettlement Component?'),
      value: _project.hasRowRap ?? false,
      onChanged: _project.cip ?? false
          ? (bool value) {
              setState(() {
                _project = _project.copyWith(hasRowRap: value);
              });
            }
          : null,
    );
  }

  Widget _buildEmployment() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text('No. of persons to be employed'),
      subtitle: Text(_totalEmployment.toString()),
    );
  }

  Widget _buildEmploymentMale() {
    return ListTile(
      title: const Text('No. of Males'),
      subtitle: TextField(
        focusNode: _employedMaleNode,
        controller: _employedMaleController,
        keyboardType: TextInputType.number,
        decoration: _getTextInputDecoration(hintText: 'No. of Males'),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        _employedMaleNode.requestFocus();
      },
    );
  }

  Widget _buildEmploymentFemale() {
    return ListTile(
      title: const Text('No. of Females'),
      subtitle: TextField(
        focusNode: _employedFemaleNode,
        controller: _employedFemaleController,
        keyboardType: TextInputType.number,
        decoration: _getTextInputDecoration(hintText: 'No. of Females'),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        _employedFemaleNode.requestFocus();
      },
    );
  }

  Widget _buildFundingSource() {
    return ListTile(
      title: const Text('Main Funding Source'),
      subtitle: _project.fundingSource != null
          ? Text(_project.fundingSource!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.fundingSource != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _project.type?.value != 1 ? _selectFundingSource : null,
    );
  }

  Future<void> _selectFundingSource() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _project.fundingSource;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Main Funding Source'),
          content: SelectDialogContent(
            options: _options?.fundingSources ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(fundingSource: response);
    });
  }

  Widget _buildFundingSources() {
    return ListTile(
      enabled: _project.type?.value != 1,
      // enable only if pap type if not a program
      title: const Text(AppStrings.otherFundingSources),
      subtitle: _project.fundingSources.isNotEmpty
          ? Text(_project.fundingSources.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.fundingSources.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectFundingSources,
    );
  }

  Future<void> _selectFundingSources() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Option> selected = _project.fundingSources;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.otherFundingSources),
          content: SelectDialogContent(
            options: _options?.fundingSources ?? [],
            multiple: true,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(fundingSources: response);
    });
  }

  Widget _buildImplementationMode() {
    return ListTile(
      title: const Text(AppStrings.modeOfImplementation),
      subtitle: _project.implementationMode != null
          ? Text(_project.implementationMode!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.implementationMode != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _project.type?.value != 1 ? _selectImplementationMode : null,
    );
  }

  Future<void> _selectImplementationMode() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _project.implementationMode;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Mode of Implementation'),
          content: SelectDialogContent(
            options: _options?.implementationModes ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(implementationMode: response);
    });
  }

  Widget _buildFundingInstitutions() {
    return ListTile(
      title: const Text(AppStrings.fundingInstitutions),
      subtitle: _project.fundingInstitutions.isNotEmpty
          ? Text(_project.fundingInstitutions
              .map((element) => element.label)
              .join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: _project.fundingInstitutions.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectFundingInstitutions,
    );
  }

  Future<void> _selectFundingInstitutions() async {
    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          List<Option> selected = _project.fundingInstitutions;

          return AlertDialog(
            title: const Text(AppStrings.fundingInstitutions),
            content: SelectDialogContent(
              options: _options?.fundingInstitutions ?? [],
              multiple: true,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(fundingInstitutions: response);
    });
  }

  Widget _buildRegionalCost() {
    final windowWidth = Breakpoints().getScreenWidth(context) -
        128; // remove horizontal margins
    final columnWidth = windowWidth / 10;

    final columns = <DataColumn>[
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
      ...List.generate(8, (index) {
        final year = 2022 + index;

        return DataColumn(
          label: SizedBox(
            width: columnWidth,
            child: Center(
              child: Text(
                "$year",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
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
    ];

    final rows = _options?.regions?.map((e) {
          final label = e.label;

          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: columnWidth,
                  child: Text(label),
                ),
              ),
              ...List.generate(
                9,
                (index) {
                  final newController = TextEditingController();

                  _regionControllers.add(newController);

                  return DataCell(
                    SizedBox(
                      width: columnWidth,
                      child: CostField(
                        controller: newController,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }).toList() ??
        <DataRow>[];

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
          columns: columns,
          rows: rows,
          // total ROW
        ),
      ),
    );
  }

  Widget _buildProjectCost() {
    final windowWidth =
        MediaQuery.of(context).size.width - 128; // remove horizontal margins
    final columnWidth = windowWidth / 10;

    final rows = _options?.fundingSources?.map((e) {
          final newTextController = TextEditingController();

          _fsControllers.add(newTextController);

          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: columnWidth,
                  child: Text(e.label),
                ),
              ),
              ...List.generate(
                9,
                (index) => DataCell(
                  SizedBox(
                    width: columnWidth,
                    child: CostField(
                      controller: newTextController,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList() ??
        <DataRow>[];

    final columns = <DataColumn>[
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: Text(
            AppStrings.fundingSource.toUpperCase(),
            style: const TextStyle(
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
            width: columnWidth,
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
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
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
    ];

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
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }

  /// TRIP only
  Widget _buildCategory() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text(AppStrings.category),
      subtitle: _project.category != null
          ? Text(_project.category!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.category != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectCategory,
    );
  }

  ///
  ///
  Future<void> _selectCategory() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.category),
          content: SelectDialogContent(
            options: _options?.categories ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(category: response);
    });
  }

  Widget _buildReadiness() {
    return ListTile(
      enabled: _project.trip ?? false,
      title: const Text(AppStrings.statusOfImplementationReadiness),
      subtitle: _project.projectStatus != null
          ? Text(_project.projectStatus!.label)
          : const Text(AppStrings.selectOne),
      trailing: _project.projectStatus != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectReadiness,
    );
  }

  Future<void> _selectReadiness() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = _project.projectStatus;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.statusOfImplementationReadiness),
          content: SelectDialogContent(
            options: _options?.projectStatuses ?? [],
            multiple: false,
            selected: selected,
            onChanged: (value) {
              selected = value;
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
      _project = _project.copyWith(projectStatus: response);
    });
  }

  ///
  ///
  Widget _buildUpdates() {
    return ListTile(
      title: const Text(AppStrings.updates),
      subtitle: TextFormField(
        focusNode: _updateNode,
        controller: _updateController,
        decoration: _getTextInputDecoration(
            hintText:
                'For proposed program/project, please indicate the physical status of the program/project in terms of project preparation, approval, funding, etc. If ongoing, please provide information on the delivery of outputs, percentage of completion and financial status/ accomplishment in terms of utilization rate. Indicate the date of reference of the updates provided i.e. as of (month, day, year).'),
        minLines: 3,
        maxLines: 4,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: _project.updates != null && _project.updates!.isNotEmpty
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        _updateNode.requestFocus();
      },
    );
  }

  ///
  ///
  Widget _buildUpdatesAsOf() {
    return ListTile(
      title: const Text(AppStrings.asOf),
      subtitle: Text(_project.asOf != null && _project.asOf != null
          ? DateFormat.yMMMd().format(_project.asOf!)
          : AppStrings.selectDate),
      trailing: _project.asOf != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _selectUpdatesAsOf,
    );
  }

  ///
  ///
  Future<void> _selectUpdatesAsOf() async {
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: _project.asOf ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    setState(() {
      _project = _project.copyWith(asOf: result);
    });
  }

  ///
  ///
  Widget _buildStart() {
    return ListTile(
      title: const Text(AppStrings.startOfProjectImplementation),
      subtitle: _project.startYear != null
          ? Text(_project.startYear!.label)
          : const Text(AppStrings.selectYear),
      trailing: _project.startYear != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      // _project.type?.value != 1
      onTap: _project.type?.value != 1
          ? _selectStart
          : () {
              //
              _showSnackbar(
                message: 'Unable to change implementation period for programs.',
                status: Status.error,
              );
            },
    );
  }

  ///
  ///
  Future<void> _selectStart() async {
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = _project.startYear;
          final options = _options?.years
                  ?.where((element) => (element.value.toInt() <= 2028))
                  .toList() ??
              [];

          return AlertDialog(
            title: const Text(AppStrings.startOfProjectImplementation),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options,
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
    if (_project.endYear != null &&
        response != null &&
        _project.endYear!.value < response!.value) {
      setState(() {
        _project = _project.copyWith(endYear: null);
      });

      _showSnackbar(
          message:
              'Year of project completion has been removed because it is before the selected start of project implementation.');
    }

    setState(() {
      _project = _project.copyWith(startYear: response);
    });
  }

  Widget _buildEnd() {
    return ListTile(
      enabled: _project.startYear != null,
      title: const Text('Year of Project Completion'),
      subtitle: _project.endYear != null
          ? Text(_project.endYear!.label)
          : (_project.startYear != null
              ? const Text(AppStrings.selectYear)
              : const Text('Select start of project implementation first')),
      trailing: _project.endYear != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: _project.type?.value != 1
          ? _selectEnd
          : () {
              //
              _showSnackbar(
                message: 'Unable to change implementation period for programs.',
                status: Status.error,
              );
            },
    );
  }

  Future<void> _selectEnd() async {
    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Option? selected = _project.endYear;
          final options = _options?.years
                  ?.where((element) => (element.value.toInt() >= 2023))
                  .toList() ??
              [];

          return AlertDialog(
            title: const Text(AppStrings.yearOfProjectCompletion),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options,
              multiple: false,
              selected: selected,
              onChanged: (value) {
                selected = value;
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
      _project = _project.copyWith(endYear: response);
    });
  }

  Widget _buildPapCode() {
    return ListTile(
      enabled: !(_project.pureGrant ?? false),
      title: const Text(AppStrings.papUacsCode),
      trailing: _project.uacsCode != null
          ? _buildSuccessfulIndicator()
          : _buildEmptyIndicator(),
      onTap: () {
        _papCodeNode.requestFocus();
      },
      subtitle: TextFormField(
        enabled: !(_project.pureGrant ?? false),
        focusNode: _papCodeNode,
        controller: _papCodeController,
        decoration: _getTextInputDecoration(hintText: '15-digit PREXC_FPAP_ID'),
        style: Theme.of(context).textTheme.bodyMedium,
        maxLength: 15,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Widget _buildFinancialAccomplishments() {
    final windowWidth = Breakpoints().getScreenWidth(context) - AppSize.s128;
    final columnWidth = windowWidth / 4;

    final columns = <DataColumn>[
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.year),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.nep),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.gaa),
          ),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: columnWidth,
          child: const Center(
            child: Text(AppStrings.disbursement),
          ),
        ),
      ),
    ];

    final rows = [
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2023")),
          ),
          DataCell(
            CostField(
              controller: _nep2023Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2023Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2023Controller,
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2024")),
          ),
          DataCell(
            CostField(
              controller: _nep2024Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2024Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2024Controller,
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2025")),
          ),
          DataCell(
            CostField(
              controller: _nep2025Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2025Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2025Controller,
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2026")),
          ),
          DataCell(
            CostField(
              controller: _nep2026Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2026Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2026Controller,
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2027")),
          ),
          DataCell(
            CostField(
              controller: _nep2027Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2027Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2027Controller,
            ),
          ),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(width: columnWidth, child: const Text("FY 2028")),
          ),
          DataCell(
            CostField(
              controller: _nep2028Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _gaa2028Controller,
            ),
          ),
          DataCell(
            CostField(
              controller: _disbursement2028Controller,
            ),
          ),
        ],
      ),
    ];

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
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }

  Widget _buildPureGrant() {
    return SwitchListTile(
      value: _project.pureGrant ?? false,
      title: const Text(AppStrings.thisIsPureGrant),
      //
      onChanged: _project.type?.value != 1
          ? (bool? value) {
              setState(() {
                _project = _project.copyWith(pureGrant: value ?? false);
              });
            }
          : null,
    );
  }

  Widget _buildRemarks() {
    return ListTile(
      title: const Text('Remarks (optional)'),
      onTap: () {
        _remarkNode.requestFocus();
      },
      subtitle: TextFormField(
        focusNode: _remarkNode,
        controller: _remarkController,
        decoration: _getTextInputDecoration(hintText: AppStrings.remarks),
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 5,
      ),
    );
  }

  Widget _buildComments() {
    return ListTile(
      title: const Text('Comments'),
      onTap: () {
        _commentNode.requestFocus();
      },
      subtitle: TextFormField(
        focusNode: _commentNode,
        controller: _commentController,
        decoration: _getTextInputDecoration(hintText: 'Comments'),
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 5,
      ),
    );
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  Widget _buildCancel() {
    return TextButton(
      onPressed: _dismissDialog,
      child: const Text(AppStrings.cancel),
    );
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
      BootstrapIcons.check_circle_fill,
      color: Colors.green,
    );
  }

  Widget _buildEmptyIndicator() {
    return const Icon(
      BootstrapIcons.check_circle,
      color: Colors.redAccent,
    );
  }

  InputDecoration _getTextInputDecoration({String? hintText}) {
    return InputDecoration(
      isCollapsed: true,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      fillColor: Colors.transparent,
      hoverColor: Colors.transparent,
      hintText: hintText ?? '',
    );
  }

  // show a snackbar for the given message
  void _showSnackbar(
      {required String message, Status status = Status.neutral}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            status == Status.error ? Colors.red[800] : Colors.green[800],
      ),
    );
  }

  // clear CIP related fields
  void _clearCipFields() {
    setState(() {
      _project = _project.copyWith(
        iccable: false,
        cipType: null,
        approvalLevel: null,
        approvalLevelDate: null,
        gad: null,
      );
    });
  }
}

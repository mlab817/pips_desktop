import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forme_file_picker/forme_file_picker.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/models/full_project.dart';
import 'package:pips/domain/usecase/options_usecase.dart';
import 'package:pips/presentation/resources/assets_manager.dart';

import '../../app/dep_injection.dart';
import '../../domain/models/options.dart';
import '../resources/sizes_manager.dart';
import '../resources/strings_manager.dart';

class NewProjectView extends StatefulWidget {
  const NewProjectView({Key? key}) : super(key: key);

  @override
  State<NewProjectView> createState() => _NewProjectViewState();
}

class _NewProjectViewState extends State<NewProjectView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();
  Options? _options;

  final PageController _pageController = PageController();

  int _currentStep = 0;

  final List<Section> _profileSection = [
    Section(
      icon: const Icon(Icons.info_outline),
      title: 'General Information',
      pageNumber: 1,
    ),
    Section(
      icon: const Icon(Icons.account_balance),
      title: 'Implementing Units',
      pageNumber: 2,
    ),
    Section(
      icon: const Icon(Icons.location_on_outlined),
      title: 'Spatial Coverage',
      pageNumber: 3,
    ),
    Section(
      icon: const Icon(Icons.approval),
      title: 'Level of Approval',
      pageNumber: 4,
    ),
    Section(
      icon: const Icon(Icons.document_scanner),
      title: 'Programming Document',
      pageNumber: 5,
    ),
    Section(
      icon: const Icon(Icons.align_horizontal_left),
      title: 'PDP Chapters',
      pageNumber: 6,
    ),
    Section(
      icon: const Icon(Icons.business_sharp),
      title: 'TRIP Requirements',
      pageNumber: 7,
    ),
    Section(
      icon: const Icon(Icons.delivery_dining),
      title: 'Expected Outputs/Deliverables',
      pageNumber: 8,
    ),
    Section(
      icon: const Icon(Icons.checklist),
      title: 'Socioeconomic Agenda',
      pageNumber: 9,
    ),
    Section(
      icon: const Icon(Icons.checklist),
      title: 'Sustainable Development Goals',
      pageNumber: 10,
    ),
    Section(
      icon: const Icon(Icons.precision_manufacturing),
      title: 'Pre-Construction Costs',
      pageNumber: 11,
    ),
    Section(
      icon: const Icon(Icons.details),
      title: 'Preparation Details',
      pageNumber: 12,
    ),
    Section(
      icon: const Icon(Icons.person),
      title: 'Employment Generated',
      pageNumber: 13,
    ),
    Section(
      icon: const Icon(Icons.money),
      title: 'Funding Source and Mode of Implementation',
      pageNumber: 14,
    ),
    Section(
      icon: const Icon(Icons.account_tree),
      title: 'Physical and Financial Status',
      pageNumber: 15,
    ),
    Section(
      icon: const Icon(Icons.attachment),
      title: 'Attachments',
      pageNumber: 16,
    ),
    Section(
      icon: const Icon(Icons.send),
      title: 'Submit',
      pageNumber: 17,
    ),
  ];

  late List<String> _list;

  late FullProject _project;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();
  final TextEditingController _searchOuController = TextEditingController();
  final TextEditingController _riskController = TextEditingController();
  final TextEditingController _expectedOutputsController =
      TextEditingController();
  final TextEditingController _updatesController = TextEditingController();
  final TextEditingController _employmentGeneratedController =
      TextEditingController();
  final TextEditingController _employedMaleController = TextEditingController();
  final TextEditingController _employedFemaleController =
      TextEditingController();
  late FlipCardController _flipCardController;

  // final List<Option> _options = [
  //   Option(value: 1, label: 'Option 1'),
  //   Option(value: 2, label: 'Option 2'),
  //   Option(value: 3, label: 'Option 3'),
  //   Option(value: 4, label: 'Option 4'),
  //   Option(value: 5, label: 'Option 5'),
  //   Option(value: 6, label: 'Option 6'),
  //   Option(value: 7, label: 'Option 7'),
  // ];

  final List<Sdg> sdgs = [
    Sdg(
        image: AssetsManager.sdg1,
        value: 1,
        label: 'End poverty in all its forms everywhere'),
    Sdg(
        image: AssetsManager.sdg2,
        value: 2,
        label:
            'End hunger, achieve food security and improved nutrition and promote sustainable agriculture'),
    Sdg(
        image: AssetsManager.sdg3,
        value: 3,
        label:
            'Ensure healthy lives and promote well-being for all at all ages'),
    Sdg(
        image: AssetsManager.sdg4,
        value: 4,
        label:
            'Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all'),
    Sdg(
        image: AssetsManager.sdg5,
        value: 5,
        label: 'Achieve gender equality and empower all women and girls'),
    Sdg(
        image: AssetsManager.sdg6,
        value: 6,
        label:
            'Ensure availability and sustainable management of water and sanitation for all'),
    Sdg(
        image: AssetsManager.sdg7,
        value: 7,
        label:
            'Ensure access to affordable, reliable, sustainable and modern energy for all'),
    Sdg(
        image: AssetsManager.sdg8,
        value: 8,
        label:
            'Promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all'),
    Sdg(
        image: AssetsManager.sdg9,
        value: 9,
        label:
            'Build resilient infrastructure, promote inclusive and sustainable industrialization and foster innovation'),
    Sdg(
        image: AssetsManager.sdg10,
        value: 10,
        label: 'Reduce inequality within and among countries'),
    Sdg(
        image: AssetsManager.sdg11,
        value: 11,
        label:
            'Make cities and human settlements inclusive, safe, resilient and sustainable'),
    Sdg(
        image: AssetsManager.sdg12,
        value: 12,
        label: 'Ensure sustainable consumption and production patterns'),
    Sdg(
        image: AssetsManager.sdg13,
        value: 13,
        label: 'Take urgent action to combat climate change and its impacts'),
    Sdg(
        image: AssetsManager.sdg14,
        value: 14,
        label:
            'Conserve and sustainably use the oceans, seas and marine resources for sustainable development'),
    Sdg(
        image: AssetsManager.sdg15,
        value: 15,
        label:
            'Protect, restore and promote sustainable use of terrestrial ecosystems, sustainably manage forests, combat desertification, and halt and reverse land degradation and halt biodiversity loss'),
    Sdg(
        image: AssetsManager.sdg16,
        value: 16,
        label:
            'Promote peaceful and inclusive societies for sustainable development, provide access to justice for all and build effective, accountable and inclusive institutions at all levels'),
    Sdg(
        image: AssetsManager.sdg17,
        value: 17,
        label:
            'Strengthen the means of implementation and revitalize the global partnership for sustainable development'),
  ];

  final Map<int, bool> _stepCompleted = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
    11: false,
    12: false,
    13: false,
    14: false,
    15: false,
    16: false,
  };

  Future<void> _loadOptions() async {
    final response = await _optionsUseCase.execute(null);

    setState(() {
      if (response.success) {
        _options = response.data?.data;
        _filteredOus = _options?.operatingUnits ?? [];
      } else {
        _options = null;
      }
    });
  }

  List<Step> _stepList() => [
        _getOne(),
        _getTwo(),
        _getThree(),
        _getFour(),
        _getFive(),
        _getSix(),
        _getSeven(),
        _getEight(),
        _getNine(),
        _getTen(),
        _getEleven(),
        _getTwelve(),
        _getThirteen(),
        _getFourteen(),
        _getFifteen(),
        _getSixteen(),
        _getSeventeen(),
      ];

  String _ouFilter = '';
  List<Option> _filteredOus = [];

  void _filterOus() {
    setState(() {
      //
      _ouFilter = _searchOuController.text.toLowerCase();
      if (_ouFilter.isNotEmpty) {
        _filteredOus = _options?.operatingUnits
                ?.where((item) => item.label.toLowerCase().contains(_ouFilter))
                .toList() ??
            [];
      } else {
        _filteredOus = _options?.operatingUnits ?? [];
      }
    });
  }

  @override
  void initState() {
    _loadOptions();

    super.initState();

    _searchOuController.addListener(_filterOus);

    _project = FullProject(
      id: null,
      uuid: null,
      title: '',
      typeId: null,
      regularProgram: false,
      description: '',
      totalCost: 0,
      expectedOutputs: '',
      spatialCoverageId: null,
      approvalLevelId: null,
      approvalLevelDate: '',
      pip: false,
      pipTypologyId: null,
      cip: false,
      cipTypeId: null,
      trip: false,
      rdip: false,
      covid: false,
      research: false,
      rdcEndorsementRequired: false,
      pdpChapterId: null,
      fundingSourceId: null,
      implementationModeId: null,
      updates: '',
      employedMale: 0,
      employedFemale: 0,
      employmentGenerated: 0,
      bases: [],
      operatingUnits: [],
      pdpChapters: [],
      agendas: [],
      fundingSources: [],
      sdgs: [],
      prerequisites: [],
      locations: [],
      infrastructureSectors: [],
      fundingInstitutions: [],
    );

    _flipCardController = FlipCardController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _totalCostController.dispose();
    _searchOuController.dispose();
    _riskController.dispose();
    _expectedOutputsController.dispose();
    _updatesController.dispose();
    _employmentGeneratedController.dispose();
    _employedMaleController.dispose();
    _employedFemaleController.dispose();

    _searchOuController.removeListener(_filterOus);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.newProgramProject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Stepper(
          steps: _stepList(),
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < (_stepList().length - 1)) {
              setState(() {
                _currentStep += 1;
              });
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _currentStep = index;
            });
          },
        ),
      ),
    );
  }

  Step _getOne() {
    final bases = _options?.bases ?? [];

    return Step(
      title: Text(_profileSection[0].title),
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          const SizedBox(height: AppSize.s20),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                labelText: AppStrings.programProjectTitle,
                helperText:
                    'The title should be identical with the program/project\'s title in the budget proposal to be submitted to the Department of Budget and Management (DBM). Please refrain from affixing unnecessary numbers, words, and other identifiers to the title, unless these are meant to distinguish one from another.',
                helperMaxLines: 3),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(title: value ?? '');
              });
            },
          ),
          const Spacer(),
          const ListTile(
            title: Text('Program or Project'),
            subtitle: Text('Select the appropriate classification.'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.types
                    ?.map(
                      (Option option) => RadioListTile(
                          value: option.value,
                          groupValue: _project.typeId,
                          title: Text(option.label),
                          subtitle: (option.description != null)
                              ? Text(option.description!)
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _project = _project.copyWith(typeId: value);
                            });
                          }),
                    )
                    .toList() ??
                [Container()],
          ),
          const Spacer(),
          CheckboxListTile(
            value: _project.regularProgram,
            title: const Text(AppStrings.regularProgram),
            subtitle: const Text(
                'A regular program refers to a program being implemented by agencies on a continuing basis.'),
            // TODO: add to description of investment requirements, For regular programs, only the investment targets covering 2023-2028 shall be submitted.
            onChanged: (bool? value) {
              setState(() {
                _project = _project.copyWith(regularProgram: value ?? false);
              });
            },
          ),
          const Spacer(),
          const ListTile(
            title: Text('Basis for Implementation'),
            subtitle: Text(
                'Identify the basis/es for the implementation of the program/ project below. If the program/project is based on an existing masterplan/sector studies/procurement plan, list of RDC-endorsed programs/projects, signed Agreements / International Commitments, existing laws, rules or regulations or regular program, please specify.'),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bases.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                selected: _project.bases.contains(bases[index].value),
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(bases[index].label),
                onChanged: (bool? value) {
                  List<int> selectedBases = _project.bases.toList();
                  int currentValue = bases[index].value;
                  // if bases contains the value
                  if (value ?? false) {
                    selectedBases.add(currentValue);
                  } else {
                    selectedBases.remove(currentValue);
                  }

                  setState(() {
                    _project = _project.copyWith(bases: selectedBases);
                  });
                },
                value: _project.bases.contains(bases[index].value),
              );
            },
          ),
          const Spacer(),
          TextFormField(
            controller: _descriptionController,
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: AppStrings.description,
              helperText:
                  'Identify the components of the program/project, and explain the objective of the program/project in terms of responsiveness to the Philippine Development Plan (PDP). If a program, please identify the sub-programs/projects. If the program/project involves construction, rehabilitation, or improvement of a government facility, specify the definite purpose for the facility to be constructed, rehabilitated or improved.',
              helperMaxLines: 5,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(description: value ?? '');
              });
            },
          ),
          const Spacer(),
          TextFormField(
            controller: _totalCostController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: AppStrings.totalCostInAbsolutePhp,
              prefixText: AppStrings.php,
              helperText:
                  'Indicate the total cost of the PAP in absolute PhP. For programs, include only the investment targets within the plan period (2023-2028) while for projects, compute the total investment targets of the PAP from the beginning to completion.',
              helperMaxLines: 2,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(
                    totalCost: double.tryParse(value ?? '') ?? 0);
              });
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Step _getTwo() {
    return Step(
      title: Text(_profileSection[1].title),
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 1,
      content: Column(
        children: [
          const ListTile(
            title: Text('Implementing Units'),
            subtitle: Text(
                'Select all operating units that are involved in the implementation of the PAP. The implementing units should be identified based on whether they are allocated budget directly from the GAA.'),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: TextField(
              controller: _searchOuController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), labelText: 'Search OUs'),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _filteredOus.map((Option option) {
              return CheckboxListTile(
                  selected: _project.operatingUnits.contains(option.value),
                  value: _project.operatingUnits.contains(option.value),
                  title: Text(option.label),
                  onChanged: (bool? value) {
                    List<int> selectedOus = _project.operatingUnits.toList();
                    int currentValue = option.value;
                    // if bases contains the value
                    if (value ?? false) {
                      selectedOus.add(currentValue);
                    } else {
                      selectedOus.remove(currentValue);
                    }

                    setState(() {
                      _project = _project.copyWith(operatingUnits: selectedOus);
                    });
                  });
            }).toList(),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Step _getThree() {
    return Step(
      title: Text(_profileSection[2].title),
      content: Column(
        children: <Widget>[
          // spatial coverage,
          const ListTile(
            title: Text(AppStrings.spatialCoverage),
            subtitle: Text(
                'Select the appropriate spatial coverage of the program/project.'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.spatialCoverages
                    ?.map(
                      (Option option) => RadioListTile(
                          value: option.value,
                          groupValue: _project.spatialCoverageId,
                          title: Text(option.label),
                          subtitle: option.description != null
                              ? Text(option.description!)
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _project =
                                  _project.copyWith(spatialCoverageId: value);
                            });
                          }),
                    )
                    .toList() ??
                [Container()],
          ),
          // regions and provinces
          const Spacer(),
          const ListTile(
            title: Text('Regions/Provinces'),
            subtitle: Text(
                'Select all regions/provinces where the PAP will be implemented.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _project = _project.copyWith(locations: []);
                      });
                    },
                    child: const Text('Clear')),
                const SizedBox(
                  width: AppSize.s10,
                ),
                ElevatedButton(
                    onPressed: () {
                      List<int> selectedItems = _options?.locations
                              ?.map((Option option) => option.value)
                              .toList() ??
                          [];
                      setState(() {
                        _project = _project.copyWith(locations: selectedItems);
                      });
                    },
                    child: const Text('Select all')),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.locations?.map((Option option) {
                  return CheckboxListTile(
                      value: _project.locations.contains(option.value),
                      title: Text(option.label),
                      onChanged: (bool? value) {
                        List<int> selectedLocations =
                            _project.locations.toList();

                        if (value ?? false) {
                          selectedLocations.add(option.value);
                        } else {
                          selectedLocations.remove(option.value);
                        }

                        setState(() {
                          _project =
                              _project.copyWith(locations: selectedLocations);
                        });
                      });
                }).toList() ??
                [Container()],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Step _getFour() {
    return Step(
      title: Text(_profileSection[3].title),
      content: Column(
        children: [
          const ListTile(
            title: Text(AppStrings.levelOfApproval),
            subtitle: Text(
                'If the project/program will require Investment Coordination Committee (ICC)/NEDA Board approval, select the current status of ICC/NEDA Board processing of the program/project and indicate the date being required. Select Not Applicable if the PAP will not undergo ICC evaluation.'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.approvalLevels
                    ?.map(
                      (Option option) => RadioListTile(
                          value: option.value,
                          groupValue: _project.approvalLevelId,
                          title: Text(option.label),
                          onChanged: (value) {
                            setState(() {
                              _project =
                                  _project.copyWith(approvalLevelId: value);
                            });
                          }),
                    )
                    .toList() ??
                [Container()],
          ),
          const Spacer(),
          const ListTile(
            title: Text(AppStrings.asOf),
            subtitle: Text(
                'Indicate the date when the level of approval was last updated.'),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now(),
                    );

                    setState(() {
                      _project = _project.copyWith(
                          approvalLevelDate: date?.toIso8601String() ?? '');
                    });
                  },
                  icon: const Icon(Icons.calendar_month)),
              _project.approvalLevelDate.isNotEmpty
                  ? Text(_project.approvalLevelDate)
                  : const Text('Select date'),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Step _getFive() {
    return Step(
      title: Text(_profileSection[4].title),
      content: Column(
        children: <Widget>[
          CheckboxListTile(
              value: _project.pip,
              title: const Text(AppStrings.publicInvestmentProgram),
              subtitle: const Text(
                  'The PIP contains priority PAPs to be implemented by NGAs, GOCCs, GFIs and other NG offices (including SUCs) within the medium-term that contribute to meeting the targets in the PDP and achieving the outcomes in the Results Matrix.'),
              // controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(pip: value ?? false);
                });
              }),
          const Spacer(),
          const ListTile(
              title: Text(AppStrings.typologyOfPip),
              subtitle: Text(
                  'Select under which typology the program/project can be classified as provided in the guidelines:')),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.typologies
                    ?.map((Option option) => RadioListTile(
                        value: option.value,
                        title: Text(option.label),
                        subtitle: option.description != null
                            ? Text(option.description!)
                            : null,
                        groupValue: _project.pipTypologyId,
                        onChanged: (int? value) {
                          setState(() {
                            _project = _project.copyWith(pipTypologyId: value!);
                          });
                        }))
                    .toList() ??
                [Container()],
          ),
          const Divider(),
          CheckboxListTile(
              value: _project.cip,
              title: const Text(AppStrings.coreInvestmentProgramsProjects),
              // controlAffinity: ListTileControlAffinity.leading,
              subtitle: const Text(
                  'The CIPs refer to the new or proposed big-ticket programs and projects under the PIP that serve as pipeline for the ICC and NEDA Board action.'),
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(cip: value ?? false);
                });
              }),
          const Spacer(),
          const ListTile(
              title: Text('Typology of CIP'),
              subtitle:
                  Text('Identify the CIP typology of the program/project.')),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.cipTypes
                    ?.map((Option option) => RadioListTile(
                        value: option.value,
                        title: Text(option.label),
                        groupValue: _project.cipTypeId,
                        onChanged: (int? value) {
                          setState(() {
                            _project = _project.copyWith(cipTypeId: value!);
                          });
                        }))
                    .toList() ??
                [Container()],
          ),
          const Divider(),
          CheckboxListTile(
              value: _project.trip,
              title:
                  const Text(AppStrings.threeYearRollingInfrastructureProgram),
              subtitle: const Text(
                  'The TRIP contains nationally-funded infrastructure projects irrespective of cost with emphasis on immediate priorities to be undertaken in three-year period.'),
              // controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(trip: value ?? false);
                });
              }),
          const Spacer(),
          const Divider(),
          CheckboxListTile(
              value: _project.rdip,
              title:
                  const Text(AppStrings.regionalDevelopmentInvestmentProgram),
              subtitle: const Text(
                  'If the PAP is included in the RDIP, please upload the RDC endorsement for verification.'),
              // controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(rdip: value ?? false);
                });
              }),
          const Spacer(),
          const Divider(),
          CheckboxListTile(
              value: _project.research,
              title: const Text('Research and Development Program/Project?'),
              subtitle: const Text(
                  'Indicate if the Program/Project is a Research and Development Program/Project.'),
              // controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(research: value ?? false);
                });
              }),
          const Spacer(),
          const Divider(),
          CheckboxListTile(
              value: _project.covid,
              title: const Text('COVID-19/New Normal Intervention'),
              subtitle: const Text(
                  'Indicate if the program/project is a strategic response to the COVID-19 pandemic or is a New Normal Intervention.'),
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(covid: value ?? false);
                });
              }),
          const Spacer(),
        ],
      ),
    );
  }

  Step _getSix() {
    return Step(
      title: Text(_profileSection[5].title),
      content: Column(
        children: [
          const ListTile(
              title: Text(AppStrings.mainPdpChapter),
              subtitle: Text(
                  'Select the Main PDP Chapter under which the program/project is expected to primarily contribute.')),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.pdpChapters?.map((Option option) {
                  return RadioListTile(
                      groupValue: _project.pdpChapterId,
                      value: option.value,
                      title: Text(option.label),
                      onChanged: (value) {
                        setState(() {
                          _project = _project.copyWith(pdpChapterId: value);
                        });
                      });
                }).toList() ??
                [Container()],
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.otherPdpChapters),
            subtitle: Text(
                'If the program/project cuts across sectors, Other PDP Chapters may be selected in addition to the Main PDP Chapter. Select as many as applicable.'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.pdpChapters?.map((Option option) {
                  // copy immutable state to new array
                  List<int> selectedChapters = _project.pdpChapters.toList();

                  return CheckboxListTile(
                      value: _project.pdpChapters.contains(option.value),
                      title: Text(option.label),
                      onChanged: (bool? value) {
                        if (value ?? false) {
                          selectedChapters.add(option.value);
                        } else {
                          selectedChapters.remove(option.value);
                        }
                        setState(() {
                          _project =
                              _project.copyWith(pdpChapters: selectedChapters);
                        });
                      });
                }).toList() ??
                [Container()],
          ),
        ],
      ),
    );
  }

  Step _getSeven() {
    return Step(
        title: Text(_profileSection[6].title),
        content: Column(
          children: [
            const Text(''),
            const ListTile(
              title: Text('Infrastructure Sector'),
              subtitle: Text('TODO'),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _options?.infrastructureSectors?.map((Option option) {
                    return CheckboxListTile(
                        value: _project.infrastructureSectors
                            .contains(option.value),
                        title: Text(option.label),
                        onChanged: (bool? value) {});
                  }).toList() ??
                  [Container()],
            ),
            const Spacer(),
            const Divider(),
            const ListTile(
              title: Text('Status of Implementation Readiness'),
              subtitle: Text(
                  'Choose among the requirements /indicators of implementation readiness for the program/project have already been complied with. A check mark indicates that a particular requirement has been complied with and that the same may be provided in the technical budget hearings or as may be requested by NEDA or DBM.'),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _options?.prerequisites?.map((Option option) {
                    return CheckboxListTile(
                        value: _project.prerequisites.contains(option.value),
                        title: Text(option.label),
                        onChanged: (bool? value) {});
                  }).toList() ??
                  [Container()],
            ),
            const Spacer(),
            TextFormField(
              controller: _riskController,
              minLines: 5,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Implementation Risk and Mitigation Strategies',
                helperText:
                    'Provide information on the potential or actual risks, if any, that may hinder the program/project from being implemented and the corresponding strategy/strategies that may be done to mitigate the risks identified.',
                helperMaxLines: 2,
              ),
              onChanged: (String? value) {
                setState(() {
                  _project = _project.copyWith(risk: value ?? '');
                });
              },
            ),
          ],
        ));
  }

  Step _getEight() {
    return Step(
      title: Text(_profileSection[7].title),
      content: TextField(
        controller: _expectedOutputsController,
        minLines: 5,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: AppStrings.expectedOutputs,
          helperText:
              'Enumerate the Expected Outputs or Actual Deliverables of the program/project. Please provide specific outputs and units of measure (e.g., 100 km of paved roads, 1,000 classrooms, etc.).',
          helperMaxLines: 3,
        ),
        onChanged: (String? value) {
          setState(() {
            _project = _project.copyWith(expectedOutputs: value ?? '');
          });
        },
      ),
    );
  }

  Step _getNine() {
    return Step(
      title: Text(_profileSection[8].title),
      content: Column(
        children: [
          const ListTile(
            title: Text(AppStrings.socioeconomicAgenda),
            subtitle: Text(
                'Select which of the 8-Point Socioeconomic Agenda the program/project is expected to address. Select as many as applicable.'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.agenda
                    ?.map((Option option) => CheckboxListTile(
                        value: _project.agendas.contains(option.value),
                        title: Text(option.label),
                        subtitle: option.description != null
                            ? Text(option.description!)
                            : null,
                        onChanged: (bool? value) {
                          List<int> agendas = _project.agendas.toList();

                          if (value ?? false) {
                            agendas.add(option.value);
                          } else {
                            agendas.remove(option.value);
                          }
                          setState(() {
                            _project = _project.copyWith(agendas: agendas);
                          });
                        }))
                    .toList() ??
                [Container()],
          ),
        ],
      ),
    );
  }

  Step _getTen() {
    return Step(
      title: Text(_profileSection[9].title),
      content: Column(
        children: [
          const ListTile(
            title: Text(AppStrings.sustainableDevelopmentGoals),
            subtitle: Text(
                'Select which of the SDGs the program/project is expected to contribute. Select as many as applicable.'),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sdgs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: AppSize.s20,
                mainAxisSpacing: AppSize.s20,
              ),
              itemBuilder: (context, index) {
                final sdg = sdgs[index];

                return InkWell(
                  onTap: () {
                    List<int> selectedSdgs = _project.sdgs.toList();

                    setState(() {
                      if (selectedSdgs.contains(sdg.value)) {
                        selectedSdgs.remove(sdg.value);
                      } else {
                        selectedSdgs.add(sdg.value);
                      }
                    });

                    setState(() {
                      _project = _project.copyWith(sdgs: selectedSdgs);
                    });
                  },
                  child: Stack(
                    children: [
                      SdgCard(
                        back: Padding(
                          padding: const EdgeInsets.all(AppPadding.md),
                          child: Text(sdg.label),
                        ),
                        front: Image.asset(
                          sdg.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Checkbox(
                          value: _project.sdgs.contains(sdg.value),
                          onChanged: (bool? value) {
                            List<int> selectedSdgs = _project.sdgs.toList();

                            if (value ?? false) {
                              selectedSdgs.add(sdg.value);
                            } else {
                              selectedSdgs.remove(sdg.value);
                            }

                            setState(() {
                              _project = _project.copyWith(sdgs: selectedSdgs);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Step _getEleven() {
    return Step(
      title: Text(_profileSection[10].title),
      content: Column(mainAxisSize: MainAxisSize.max, children: const [
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Has Right of Way and Resettlement Action Plan'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text(AppStrings.rightOfWay),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Right of Way Total Cost (in absolute PhP terms)'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('No. of Households Affected'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text(AppStrings.resettlementActionPlan),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text(
                  'Resettlement Action Plan Total Cost (in absolute PhP terms)'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('No. of Households Affected'),
            )),
      ]),
    );
  }

  Step _getTwelve() {
    return Step(
      title: Text(_profileSection[11].title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Preparation Document'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Details of F/S'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text(
                    'Will require assistance for the conduct of F/S (from NEDA)?'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('F/S Completion Date'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Status of FS'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Total Cost of F/S (in absolute PhP terms)'),
              )),
        ],
      ),
    );
  }

  Step _getThirteen() {
    return Step(
      title: Text(_profileSection[12].title),
      content: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.employmentGenerated),
          ),
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              child: TextFormField(
                controller: _employedMaleController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(labelText: 'Male'),
              ),
            ),
            const SizedBox(width: AppSize.md),
            Expanded(
              child: TextFormField(
                controller: _employedFemaleController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(labelText: 'Female'),
              ),
            ),
            const SizedBox(width: AppSize.md),
            Expanded(
              child: TextFormField(
                readOnly: true,
                controller: _employmentGeneratedController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(labelText: 'Total'),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Step _getFourteen() {
    return Step(
      title: Text(_profileSection[13].title),
      content: Column(mainAxisSize: MainAxisSize.max, children: [
        const ListTile(
          title: Text(AppStrings.mainFundingSource),
          subtitle: Text('TODO'),
        ),
        Column(
          children: _options?.fundingSources?.map((Option option) {
                return RadioListTile(
                    value: option.value,
                    title: Text(option.label),
                    subtitle: option.description != null
                        ? Text(option.description!)
                        : null,
                    groupValue: _project.fundingSourceId,
                    onChanged: (value) {
                      setState(() {
                        _project = _project.copyWith(fundingSourceId: value);
                      });
                    });
              }).toList() ??
              [Container()],
        ),
        const Spacer(),
        const Divider(),
        const ListTile(
          title: Text(AppStrings.otherFundingSources),
          subtitle: Text('TODO'),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _options?.fundingSources?.map((Option option) {
                return CheckboxListTile(
                    value: _project.fundingSources.contains(option.value),
                    title: Text(option.label),
                    onChanged: (bool? value) {
                      List<int> selectedFs = _project.fundingSources.toList();

                      if (value ?? false) {
                        selectedFs.add(option.value);
                      } else {
                        selectedFs.remove(option.value);
                      }

                      setState(() {
                        _project =
                            _project.copyWith(fundingSources: selectedFs);
                      });
                    });
              }).toList() ??
              [Container()],
        ),
        const Spacer(),
        const Divider(),
        const ListTile(
          title: Text(AppStrings.fundingInstitutions),
          subtitle: Text('TODO'),
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search'),
          ),
        ),
        Container(
          height: AppSize.s250,
          margin: const EdgeInsets.all(AppPadding.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(AppSize.s12),
            border: Border.all(
              width: AppSize.s0_5,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _options?.fundingInstitutions?.map((Option option) {
                    return CheckboxListTile(
                        value:
                            _project.fundingInstitutions.contains(option.value),
                        title: Text(option.label),
                        onChanged: (bool? value) {
                          final fundingInstitutions =
                              _project.fundingInstitutions.toList();

                          if (value ?? false) {
                            fundingInstitutions.add(option.value);
                          } else {
                            fundingInstitutions.remove(option.value);
                          }

                          setState(() {
                            _project = _project.copyWith(
                                fundingInstitutions: fundingInstitutions);
                          });
                        });
                  }).toList() ??
                  [Container()],
            ),
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        const Spacer(),
        const ListTile(
          title: Text(AppStrings.modeOfImplementation),
          subtitle: Text('TODO'),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _options?.implementationModes?.map((Option option) {
                return RadioListTile(
                    value: option.value,
                    title: Text(option.label),
                    groupValue: _project.implementationModeId,
                    onChanged: (value) {
                      setState(() {
                        _project =
                            _project.copyWith(implementationModeId: value);
                      });
                    });
              }).toList() ??
              [Container()],
        ),
        const Spacer(),
      ]),
    );
  }

  Step _getFifteen() {
    return Step(
      title: Text(_profileSection[14].title),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const ListTile(
            title: Text('Status of Implementation Readiness'),
            subtitle: Text('TODO'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.projectStatuses
                    ?.map((Option option) => RadioListTile(
                          value: option.value,
                          title: Text(option.label),
                          onChanged: (int? value) {
                            setState(() {
                              _project =
                                  _project.copyWith(projectStatusId: value);
                            });
                          },
                          groupValue: _project.projectStatusId,
                        ))
                    .toList() ??
                [Container()],
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.levelOfReadiness),
            subtitle: Text(''),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.readinessLevels
                    ?.map((Option option) => RadioListTile(
                          value: option.value,
                          title: Text(option.label),
                          onChanged: (int? value) {
                            setState(() {
                              _project =
                                  _project.copyWith(readinessLevelId: value);
                            });
                          },
                          groupValue: _project.readinessLevelId,
                        ))
                    .toList() ??
                [const Text('Failed to load options')],
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.category),
            subtitle: Text(
                'Identify the Tier category of the program/project as provided in the DBM Guide to the Two-Tier Budget Approach:'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _options?.categories
                    ?.map((Option option) => RadioListTile(
                          value: option.value,
                          title: Text(option.label),
                          onChanged: (int? value) {
                            setState(() {
                              _project = _project.copyWith(categoryId: value);
                            });
                          },
                          groupValue: _project.categoryId,
                        ))
                    .toList() ??
                [const Text('Failed to load options')],
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.implementationPeriod),
            subtitle: Text(
                'Indicate the start year of the implementation and the year of completion of the program/project.'),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            final DateTime? dt = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365 * 20)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365 * 20)));

                            debugPrint(dt.toString());
                          },
                          icon: const Icon(Icons.calendar_month)),
                      const Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Start of Project Implementation',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppSize.s20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            final DateTime? dt = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 365 * 20)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365 * 20)));

                            debugPrint(dt.toString());
                          },
                          icon: const Icon(Icons.calendar_month)),
                      const Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'End of Project Implementation',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.updates),
          ),
          TextFormField(
            controller: _updatesController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: AppStrings.updates,
              helperText:
                  'For proposed program/project, please indicate the physical status of the program/project in terms of project preparation, approval, funding, etc. If ongoing, please provide information on the delivery of outputs, percentage of completion and financial status/ accomplishment in terms of utilization rate.',
              helperMaxLines: 3,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(updates: value);
              });
            },
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text(AppStrings.asOf),
            subtitle: Text(
                'Indicate the date of reference of the updates provided i.e. As of (month, day, year).'),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 1, 1),
                      lastDate: DateTime.now(),
                    );

                    debugPrint(selectedDate.toString());

                    setState(() {
                      _project =
                          _project.copyWith(asOf: selectedDate?.toString());
                    });
                  },
                  icon: const Icon(Icons.calendar_month)),
              Expanded(
                  child: Text(_project.asOf != null
                      ? DateFormat.yMMMd()
                          .format(DateTime.parse(_project.asOf!))
                      : AppStrings.selectDate)),
            ],
          ),
        ],
      ),
    );
  }

  Step _getSixteen() {
    return Step(
      title: Text(_profileSection[15].title),
      content: Column(
        children: [
          const Text(AppStrings.attachments),
          FormeFileGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            pickFiles: (FormeFileGridState state, int? maximum) {},
            name: '',
          )
        ],
      ),
    );
  }

  Step _getSeventeen() {
    return Step(
      title: Text(_profileSection[16].title),
      content: Column(
        children: const [
          Text('Confirm submission'),
          SizedBox(
            height: AppSize.s20,
          ),
          Placeholder(
            child: Text('PDF Preview'),
          ),
        ],
      ),
    );
  }
}

class Spacer extends StatelessWidget {
  const Spacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppSize.s36,
    );
  }
}

class Section {
  Section({
    required this.icon,
    required this.title,
    required this.pageNumber,
  });

  Icon icon;

  String title;

  int pageNumber;
}

class Sdg {
  String image;

  int value;

  String label;

  Sdg({
    required this.image,
    required this.value,
    required this.label,
  });
}

class SdgCard extends StatefulWidget {
  const SdgCard({Key? key, required this.front, required this.back})
      : super(key: key);

  final Widget front;
  final Widget back;

  @override
  State<SdgCard> createState() => _SdgCardState();
}

class _SdgCardState extends State<SdgCard> {
  late FlipCardController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {},
      child: FlipCard(
        controller: _controller,
        back: widget.back,
        front: widget.front,
      ),
    );
  }
}

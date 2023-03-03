import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forme_file_picker/forme_file_picker.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/models/full_project.dart';
import 'package:pips/domain/usecase/options_usecase.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';

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
  final TextEditingController _riskController = TextEditingController();
  final TextEditingController _expectedOutputsController =
      TextEditingController();
  final TextEditingController _updatesController = TextEditingController();
  final TextEditingController _employmentGeneratedController =
      TextEditingController();
  final TextEditingController _employedMaleController = TextEditingController();
  final TextEditingController _employedFemaleController =
      TextEditingController();

  int _currentPage = 0;

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
    Sdg(image: AssetsManager.sdg1, value: 1),
    Sdg(image: AssetsManager.sdg2, value: 2),
    Sdg(image: AssetsManager.sdg3, value: 3),
    Sdg(image: AssetsManager.sdg4, value: 4),
    Sdg(image: AssetsManager.sdg5, value: 5),
    Sdg(image: AssetsManager.sdg6, value: 6),
    Sdg(image: AssetsManager.sdg7, value: 7),
    Sdg(image: AssetsManager.sdg8, value: 8),
    Sdg(image: AssetsManager.sdg9, value: 9),
    Sdg(image: AssetsManager.sdg10, value: 10),
    Sdg(image: AssetsManager.sdg11, value: 11),
    Sdg(image: AssetsManager.sdg12, value: 12),
    Sdg(image: AssetsManager.sdg13, value: 13),
    Sdg(image: AssetsManager.sdg14, value: 14),
    Sdg(image: AssetsManager.sdg15, value: 15),
    Sdg(image: AssetsManager.sdg16, value: 16),
    Sdg(image: AssetsManager.sdg17, value: 17),
  ];

  final List _selectedOptions = [];

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
      } else {
        _options = null;
      }
    });
  }

  @override
  void initState() {
    _loadOptions();

    super.initState();

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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _totalCostController.dispose();
    _riskController.dispose();
    _expectedOutputsController.dispose();
    _updatesController.dispose();
    _employmentGeneratedController.dispose();
    _employedMaleController.dispose();
    _employedFemaleController.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.newProgramProject),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppPadding.md),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: AppSize.s0_5),
                ),
              ),
              child: ListView.builder(
                itemCount: _profileSection.length,
                itemBuilder: (context, index) {
                  final section = _profileSection[index];

                  return ListTile(
                    dense: true,
                    leading: section.icon,
                    trailing: _stepCompleted[index] ?? false
                        ? Icon(
                            Icons.check,
                            color: ColorManager.blue,
                          )
                        : const Icon(Icons.check),
                    title: Text(_profileSection[index].title),
                    selected: _currentPage == index,
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.md),
              child: Column(
                children: [
                  Expanded(
                    child: _options != null
                        ? PageView(
                            controller: _pageController,
                            scrollDirection: Axis.vertical,
                            children: [
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
                            ],
                            onPageChanged: (index) {
                              //
                              setState(() {
                                _currentPage = index;
                              });
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  // Bottom Arrow Controls
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOne() {
    final bases = _options?.bases ?? [];

    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: AppStrings.programProjectTitle,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(title: value ?? '');
              });
            },
          ),
          const Spacer(),
          Row(
            children: _options?.types
                    ?.map(
                      (Option option) => Expanded(
                        child: RadioListTile(
                            value: option.value,
                            groupValue: _project.typeId,
                            title: Text(option.label),
                            onChanged: (value) {
                              setState(() {
                                _project = _project.copyWith(typeId: value);
                              });
                            }),
                      ),
                    )
                    .toList() ??
                [Container()],
          ),
          const Spacer(),
          CheckboxListTile(
            dense: true,
            value: _project.regularProgram,
            onChanged: (bool? value) {
              setState(() {
                _project = _project.copyWith(regularProgram: value ?? false);
              });
            },
            title: const Text(AppStrings.regularProgram),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: ColorManager.primary,
          ),
          const Spacer(),
          ListView.builder(
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
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(
                    totalCost: double.tryParse(value ?? '') ?? 0);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _getTwo() {
    final operatingUnits = _options?.operatingUnits ?? [];

    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: operatingUnits.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              selected:
                  _project.operatingUnits.contains(operatingUnits[index].value),
              value:
                  _project.operatingUnits.contains(operatingUnits[index].value),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(operatingUnits[index].label),
              onChanged: (bool? value) {
                List<int> selectedOus = _project.operatingUnits.toList();
                int currentValue = operatingUnits[index].value;
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
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      ),
    );
  }

  Widget _getThree() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // spatial coverage,
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.spatialCoverage),
          ),
          SizedBox(
            height: AppSize.s200,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: _options?.spatialCoverages
                      ?.map(
                        (Option option) => Expanded(
                          child: RadioListTile(
                              value: option.value,
                              groupValue: _project.spatialCoverageId,
                              title: Text(option.label),
                              onChanged: (value) {
                                setState(() {
                                  _project = _project.copyWith(
                                      spatialCoverageId: value);
                                });
                              }),
                        ),
                      )
                      .toList() ??
                  [Container()],
            ),
          ),
          // regions and provinces
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.locations),
          ),
        ],
      ),
    );
  }

  Widget _getFour() {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(AppStrings.levelOfApproval),
        ),
        Column(
          children: _options?.approvalLevels
                  ?.map(
                    (Option option) => Expanded(
                      child: RadioListTile(
                          value: option.value,
                          groupValue: _project.approvalLevelId,
                          title: Text(option.label),
                          onChanged: (value) {
                            setState(() {
                              _project =
                                  _project.copyWith(approvalLevelId: value);
                            });
                          }),
                    ),
                  )
                  .toList() ??
              [Container()],
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(AppStrings.asOf),
        ),
        CalendarDatePicker(
            initialDate: _project.approvalLevelDate.isNotEmpty
                ? DateTime.parse(_project.approvalLevelDate)
                : DateTime.now(),
            firstDate: DateTime(2023, 1, 1),
            lastDate: DateTime(2023, 12, 31),
            onDateChanged: (DateTime dateTime) {
              setState(() {
                _project = _project.copyWith(
                    approvalLevelDate: dateTime.toIso8601String());
              });
            }),
      ],
    );
  }

  Widget _getFive() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Text(AppStrings.pip),
          CheckboxListTile(
              value: _project.pip,
              title: const Text(AppStrings.publicInvestmentProgram),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(pip: value ?? false);
                });
              }),
          const Text(AppStrings.typologyOfPip),
          Column(
            children: _options?.typologies
                    ?.map((Option option) => RadioListTile(
                        value: option.value,
                        title: Text(option.label),
                        groupValue: _project.pipTypologyId,
                        onChanged: (int? value) {
                          setState(() {
                            _project = _project.copyWith(pipTypologyId: value!);
                          });
                        }))
                    .toList() ??
                [Container()],
          ),
          const Text(AppStrings.cip),
          CheckboxListTile(
              value: _project.cip,
              title: const Text(AppStrings.coreInvestmentProgramsProjects),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(cip: value ?? false);
                });
              }),
          const Text(AppStrings.typeOfCip),
          Column(
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
          const Text(AppStrings.trip),
          CheckboxListTile(
              value: _project.trip,
              title:
                  const Text(AppStrings.threeYearRollingInfrastructureProgram),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(trip: value ?? false);
                });
              }),
          const Text(AppStrings.rdip),
          CheckboxListTile(
              value: _project.rdip,
              title:
                  const Text(AppStrings.regionalDevelopmentInvestmentProgram),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _project = _project.copyWith(rdip: value ?? false);
                });
              }),
          const Text('Research'),
          const Text('ICT'),
          const Text('COVID'),
        ],
      ),
    );
  }

  Widget _getSix() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.mainPdpChapter),
          ),
          Column(
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
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.otherPdpChapters),
          ),
          Column(
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

  Widget _getSeven() {
    return Column(
      children: <Widget>[
        const Text('Infrastructure Sector'),
        const Text('Status of Implementation Readiness'),
        const Text('Implementation Risk and Mitigation Strategies'),
        TextFormField(
          controller: _riskController,
          decoration: const InputDecoration(
            labelText: 'Implementation Risk and Mitigation Strategies',
          ),
          onChanged: (String? value) {
            setState(() {
              _project = _project.copyWith(risk: value ?? '');
            });
          },
        ),
      ],
    );
  }

  final List<int> _selectedSdgs = [];

  Widget _getEight() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: _expectedOutputsController,
            decoration: const InputDecoration(
              labelText: AppStrings.expectedOutputs,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(expectedOutputs: value ?? '');
              });
            },
          )
        ],
      ),
    );
  }

  Widget _getTen() {
    return Column(
      children: [
        Text(_selectedSdgs.length.toString()),
        GridView.builder(
          shrinkWrap: true,
          itemCount: sdgs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s8,
          ),
          itemBuilder: (context, index) {
            final sdg = sdgs[index];

            return InkWell(
              onTap: () {
                setState(() {
                  if (!_selectedSdgs.contains(sdg.value)) {
                    _selectedSdgs.add(sdg.value);
                  } else {
                    _selectedSdgs.remove(sdg.value);
                  }
                });
              },
              child: Stack(
                children: [
                  Image.asset(
                    sdg.image,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Checkbox(
                      value: _selectedSdgs.contains(sdg.value),
                      onChanged: (_) {
                        setState(() {
                          if (!_selectedSdgs.contains(sdg.value)) {
                            _selectedSdgs.add(sdg.value);
                          } else {
                            _selectedSdgs.remove(sdg.value);
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
      ],
    );
  }

  Widget _getNine() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.socioeconomicAgenda),
          ),
          Column(
              children: _options?.agenda
                      ?.map((Option option) => CheckboxListTile(
                          value: _project.agendas.contains(option.value),
                          title: Text(option.label),
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
                  [Container()]),
        ],
      ),
    );
  }

  Widget _getEleven() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.max, children: const [
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
              child: Text('Right of Way'),
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
              child: Text('Resettlement Action Plan'),
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

  Widget _getTwelve() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.max, children: const [
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
      ]),
    );
  }

  Widget _getThirteen() {
    return SingleChildScrollView(
      child: Column(
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

  Widget _getFourteen() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(AppStrings.mainFundingSource),
        ),
        Column(
          children: _options?.fundingSources?.map((Option option) {
                return RadioListTile(
                    value: option.value,
                    title: Text(option.label),
                    groupValue: _project.fundingSourceId,
                    onChanged: (value) {
                      setState(() {
                        _project = _project.copyWith(fundingSourceId: value);
                      });
                    });
              }).toList() ??
              [Container()],
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(AppStrings.otherFundingSources),
        ),
        Column(
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
        const SizedBox(
          height: AppSize.s20,
        ),
        const SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text(AppStrings.fundingInstitutions),
            )),
        const SizedBox(
          height: AppSize.s20,
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(AppStrings.modeOfImplementation),
        ),
        Column(
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
      ]),
    );
  }

  Widget _getFifteen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.projectStatus),
          ),
          Column(
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
          const SizedBox(
            height: AppSize.s20,
          ),
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.category),
          ),
          Column(
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
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.implementationPeriod),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: Row(
              children: const [
                Expanded(
                  child: Text('Start Year'),
                ),
                Expanded(
                  child: Text('End Year'),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.levelOfReadiness),
          ),
          Column(
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
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.updates),
          ),
          TextFormField(
            controller: _updatesController,
            decoration: const InputDecoration(
              labelText: AppStrings.updates,
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(updates: value);
              });
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: Text(AppStrings.asOf),
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

  Widget _getSixteen() {
    return Center(
      child: Column(
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

  Widget _getSeventeen() {
    return Expanded(
      child: ListView(
        children: const [
          Text('Confirm submission'),
          SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: Placeholder(
              child: Text('PDF Preview'),
            ),
          )
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

  Sdg({
    required this.image,
    required this.value,
  });
}

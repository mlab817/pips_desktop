import 'package:flutter/material.dart';
import 'package:forme_file_picker/forme_file_picker.dart';
import 'package:pips/domain/models/full_project.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';

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
      icon: const Icon(Icons.money),
      title: 'Funding Source and Mode of Implementation',
      pageNumber: 13,
    ),
    Section(
      icon: const Icon(Icons.account_tree),
      title: 'Physical and Financial Status',
      pageNumber: 14,
    ),
    Section(
      icon: const Icon(Icons.attachment),
      title: 'Attachments',
      pageNumber: 15,
    ),
    Section(
      icon: const Icon(Icons.send),
      title: 'Submit',
      pageNumber: 16,
    ),
  ];

  late List<String> _list;

  late FullProject _project;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();

  int _currentPage = 0;

  final List<Option> _options = [
    Option(value: 1, label: 'Option 1'),
    Option(value: 2, label: 'Option 2'),
    Option(value: 3, label: 'Option 3'),
    Option(value: 4, label: 'Option 4'),
    Option(value: 5, label: 'Option 5'),
    Option(value: 6, label: 'Option 6'),
    Option(value: 7, label: 'Option 7'),
  ];

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

  @override
  void initState() {
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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _totalCostController.dispose();

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
                    child: PageView(
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
                    ),
                  ),
                  // Bottom Arrow Controls
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: AppSize.s0_5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // IconButton(
                        //   icon: const Icon(Icons.chevron_left),
                        //   onPressed: () {
                        //     setState(() {
                        //       if (_currentPage == 0) {
                        //         //
                        //       }

                        //       _currentPage--;
                        //     });
                        //   },
                        // ),
                        // Text("${_currentPage + 1} of ${_pages.length}"),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            // if (_currentPage == _pages.length - 1) {
                            //   setState(() {
                            //     _currentPage = 0;
                            //   });
                            //   return;
                            // }

                            setState(() {
                              _pageController.animateToPage(
                                17,
                                duration: const Duration(
                                  milliseconds: 400,
                                ),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOne() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Program/Project Title',
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(title: value ?? '');
              });
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                    value: 1,
                    groupValue: _project.typeId,
                    title: const Text('Program'),
                    onChanged: (value) {
                      setState(() {
                        _project = _project.copyWith(typeId: value);
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    value: 2,
                    groupValue: _project.typeId,
                    title: const Text('Project'),
                    onChanged: (value) {
                      setState(() {
                        _project = _project.copyWith(typeId: value);
                      });
                    }),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
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
            title: const Text('Regular Program'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: ColorManager.primary,
          ),
          const Spacer(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _options.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  value: _selectedOptions.contains(_options[index].value),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(_options[index].label),
                  onChanged: (_) {
                    if (_selectedOptions.contains(index)) {
                      _selectedOptions.remove(index); // unselect
                    } else {
                      _selectedOptions.add(index); // select
                    }
                  });
            },
          ),
          const Spacer(),
          TextField(
            controller: _descriptionController,
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            onChanged: (String? value) {
              setState(() {
                _project = _project.copyWith(description: value ?? '');
              });
            },
          ),
          const Spacer(),
          TextField(
            controller: _totalCostController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Total Cost in absolute PhP',
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _options.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
            value: _selectedOptions.contains(_options[index].value),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(_options[index].label),
            onChanged: (_) {
              if (_selectedOptions.contains(index)) {
                _selectedOptions.remove(index); // unselect
              } else {
                _selectedOptions.add(index); // select
              }
            });
      },
    );
  }

  Widget _getThree() {
    return Column(
      children: <Widget>[
        // spatial coverage,
        const Text('Spatial Coverage'),
        DropdownButton(
            items: const [
              DropdownMenuItem(value: 1, child: Text('Item 1')),
              DropdownMenuItem(value: 2, child: Text('Item 2')),
              DropdownMenuItem(value: 3, child: Text('Item 3')),
            ],
            onChanged: (int? newValue) {
              //
            }),
        // regions and provinces
        const Text('Locations')
      ],
    );
  }

  Widget _getFour() {
    return Column(
      children: const <Widget>[
        Text('Level of Approval'),
        Text('As of'),
      ],
    );
  }

  Widget _getFive() {
    return Column(
      children: const <Widget>[
        Text('PIP'),
        Text('PIP Typology'),
        Text('CIP'),
        Text('CIP Type'),
        Text('TRIP'),
        Text('RDIP'),
        Text('Research'),
        Text('ICT'),
        Text('COVID'),
      ],
    );
  }

  Widget _getSix() {
    return Column(
      children: const <Widget>[
        Text('Main PDP Chapter'),
        Text('Other PDP Chapters'),
      ],
    );
  }

  Widget _getSeven() {
    return Column(
      children: const <Widget>[
        Text('Infrastructure Sector'),
        Text('Status of Implementation Readiness'),
        Text('Implementation Risk and Mitigation Strategies'),
      ],
    );
  }

  final List<int> _selectedSdgs = [];

  Widget _getEight() {
    return Container();
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
                        debugPrint(
                            _selectedSdgs.contains(sdg.value).toString());
                        debugPrint(sdg.value.toString());
                        debugPrint(
                            "selected sdgs: ${_selectedSdgs.length.toString()}");

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
    return Container();
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
      child: Column(mainAxisSize: MainAxisSize.max, children: const [
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Total'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Male'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Female'),
            )),
      ]),
    );
  }

  Widget _getFourteen() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.max, children: const [
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Funding Source'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Other Funding Source'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Funding Institutions'),
            )),
        SizedBox(
          height: AppSize.s20,
        ),
        SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Mode of Implementation'),
            )),
      ]),
    );
  }

  Widget _getFifteen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Project Status'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: AppSize.s200,
              width: double.infinity,
              child: Placeholder(
                child: Text('Category'),
              )),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Start Year'),
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('End Year'),
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Level of Readiness'),
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('Updates'),
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
            height: AppSize.s200,
            width: double.infinity,
            child: Placeholder(
              child: Text('As of'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSixteen() {
    return Center(
      child: Column(
        children: [
          const Text('Attachments'),
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
        children: [
          const Text('Confirm submission'),
          ListTile(
            title: const Text('Title'),
            trailing: Text(_project.title),
          ),
          ListTile(
            title: const Text('Description'),
            trailing: Text(_project.description),
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

  Sdg({
    required this.image,
    required this.value,
  });
}

import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';

import '../../domain/models/options.dart';
import '../resources/sizes_manager.dart';

class NewProjectView extends StatefulWidget {
  const NewProjectView({Key? key}) : super(key: key);

  @override
  State<NewProjectView> createState() => _NewProjectViewState();
}

class _NewProjectViewState extends State<NewProjectView> {
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

  int _selectedIndex = 0;

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

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Program/Project')),
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
                  return ListTile(
                    dense: true,
                    leading: _profileSection[index].icon,
                    trailing: const Icon(Icons.check),
                    title: Text(_profileSection[index].title),
                    selected: _selectedIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      _pageController.animateToPage(
                        _profileSection[index].pageNumber,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
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
                        _getTen(),
                        _getTen(),
                        _getOne(),
                        _getOne(),
                        _getOne(),
                        _getOne(),
                        _getOne(),
                        _getOne(),
                        _getSixteen(),
                      ],
                    ),
                  ),
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
                        //       if (_selectedIndex == 0) {
                        //         //
                        //       }

                        //       _selectedIndex--;
                        //     });
                        //   },
                        // ),
                        // Text("${_selectedIndex + 1} of ${_pages.length}"),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            // if (_selectedIndex == _pages.length - 1) {
                            //   setState(() {
                            //     _selectedIndex = 0;
                            //   });
                            //   return;
                            // }

                            setState(() {
                              _pageController.animateToPage(
                                16,
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
          const TextField(
            decoration: InputDecoration(
              labelText: 'Program/Project Title',
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: RadioListTile(
                    value: 1,
                    groupValue: null,
                    title: const Text('Program'),
                    onChanged: (value) {
                      setState(() {
                        // do something
                      });
                    }),
              ),
              Expanded(
                flex: 3,
                child: RadioListTile(
                    value: 2,
                    groupValue: null,
                    title: const Text('Project'),
                    onChanged: (value) {
                      setState(() {
                        // do something
                      });
                    }),
              ),
            ],
          ),
          const Spacer(),
          CheckboxListTile(
            dense: true,
            value: true,
            onChanged: (value) {
              setState(() {
                //
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
          const TextField(
            minLines: 5,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
          const Spacer(),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Total Cost in absolute PhP',
            ),
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
      children: const <Widget>[
        // spatial coverage,
        Text('Spatial Coverage'),
        // regions and provinces
        Text('Locations')
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

            return Stack(children: [
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
                      })),
            ]);
          },
        ),
      ],
    );
  }

  Widget _getSixteen() {
    return const Center(
      child: Text('Confirm submission'),
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

import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/color_manager.dart';

import '../../domain/models/options.dart';
import '../resources/sizes_manager.dart';

class NewProjectView extends StatefulWidget {
  const NewProjectView({Key? key}) : super(key: key);

  @override
  State<NewProjectView> createState() => _NewProjectViewState();
}

class _NewProjectViewState extends State<NewProjectView> {
  final List<Section> _profileSection = [
    Section(
      icon: const Icon(Icons.info_outline),
      title: 'General Information',
    ),
    Section(
      icon: const Icon(Icons.account_balance),
      title: 'Implementing Units',
    ),
    Section(
      icon: const Icon(Icons.location_on_outlined),
      title: 'Spatial Coverage',
    ),
    Section(
      icon: const Icon(Icons.approval),
      title: 'Level of Approval',
    ),
    Section(
      icon: const Icon(Icons.document_scanner),
      title: 'Programming Document',
    ),
    Section(
      icon: const Icon(Icons.align_horizontal_left),
      title: 'PDP Chapters',
    ),
    Section(
      icon: const Icon(Icons.business_sharp),
      title: 'TRIP Requirements',
    ),
    Section(
      icon: const Icon(Icons.delivery_dining),
      title: 'Expected Outputs/Deliverables',
    ),
    Section(
      icon: const Icon(Icons.checklist),
      title: 'Socioeconomic Agenda',
    ),
    Section(
      icon: const Icon(Icons.checklist),
      title: 'Sustainable Development Goals',
    ),
    Section(
      icon: const Icon(Icons.precision_manufacturing),
      title: 'Pre-Construction Costs',
    ),
    Section(
      icon: const Icon(Icons.details),
      title: 'Preparation Details',
    ),
    Section(
      icon: const Icon(Icons.money),
      title: 'Funding Source and Mode of Implementation',
    ),
    Section(
      icon: const Icon(Icons.account_tree),
      title: 'Physical and Financial Status',
    ),
    Section(
      icon: const Icon(Icons.attachment),
      title: 'Attachments',
    ),
    Section(
      icon: const Icon(Icons.send),
      title: 'Submit',
    ),
  ];

  late List<Widget> _pages;

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

  final List _selectedOptions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list = List.generate(10, (index) => "Item ${index.toString()}");

    _pages = [
      _getOne(),
      _getTwo(),
      _getThree(),
      _getFour(),
      _getFive(),
      _getSix(),
      _getSeven(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getOne(),
      _getSixteen(),
    ];
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
                  Expanded(child: _pages[_selectedIndex]),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: AppSize.s0_5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            setState(() {
                              if (_selectedIndex == 0) {
                                _selectedIndex = _pages.length;
                              }

                              _selectedIndex--;
                            });
                          },
                        ),
                        Text("${_selectedIndex + 1} of ${_pages.length}"),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            if (_selectedIndex == _pages.length - 1) {
                              setState(() {
                                _selectedIndex = 0;
                              });
                              return;
                            }

                            setState(() {
                              _selectedIndex++;
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
  });

  Icon icon;

  String title;
}

import 'package:flutter/material.dart';
import 'package:pips/common/resources/sizes_manager.dart';

import '../../../../app/dep_injection.dart';
import '../../../../constants/constants.dart';
import '../../../project/domain/models/office.dart';
import '../../../project/domain/usecase/alloffices_usecase.dart';

class OfficeBottomSheet extends StatefulWidget {
  const OfficeBottomSheet({Key? key, required this.onTap}) : super(key: key);

  final Function(Office office) onTap;

  @override
  State<OfficeBottomSheet> createState() => _OfficeBottomSheetState();
}

class _OfficeBottomSheetState extends State<OfficeBottomSheet>
    with AutomaticKeepAliveClientMixin {
  final AllOfficesUseCase _allOfficesUseCase = instance<AllOfficesUseCase>();

  final TextEditingController _filterOfficeController = TextEditingController();

  List<Office>? _options;
  List<Office> _filteredOffices = [];

  bool _loading = false;

  Future<void> _loadOffices() async {
    setState(() {
      _loading = true;
    });

    (await _allOfficesUseCase.execute(Void())).fold((failure) {
      setState(() {
        _options = [];
        _loading = false;
      });
    }, (response) {
      setState(() {
        _options = response.data;
        _filteredOffices = response.data;
        _loading = false;
      });
    });
  }

  void _filterOffices() {
    if (_filterOfficeController.text.isEmpty) {
      setState(() {
        _filteredOffices = _options?.toList() ?? [];
      });
    } else {
      setState(() {
        _filteredOffices = _options
                ?.where((element) => element.acronym
                    .toLowerCase()
                    .contains(_filterOfficeController.text.toLowerCase()))
                .toList() ??
            [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadOffices();

    _filterOfficeController.addListener(_filterOffices);
  }

  @override
  void dispose() {
    _filterOfficeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: TextField(
            controller: _filterOfficeController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const Text(
          'Offices',
          textAlign: TextAlign.start,
        ),
        _loading
            ? const Padding(
                padding: EdgeInsets.all(AppPadding.md),
                child: Center(child: CircularProgressIndicator()),
              )
            : Expanded(
                child: _filteredOffices.isEmpty
                    ? const ListTile(
                        title: Text('No office found'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredOffices.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              widget.onTap(_filteredOffices[index]);
                            },
                            title: Text(_filteredOffices[index].acronym),
                          );
                        },
                      ),
              ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

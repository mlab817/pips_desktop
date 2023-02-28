import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/office_usecase.dart';
import 'package:pips/presentation/common/project_item.dart';

import '../../../domain/models/office.dart';

class OfficeView extends StatefulWidget {
  const OfficeView({Key? key, required this.officeId}) : super(key: key);

  final String officeId;

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  final OfficeUseCase _officeUseCase = instance<OfficeUseCase>();

  Office? _office;

  List<Project>? _projects;

  bool _loading = false;

  // handle fetch of office data

  Future<void> _getOffice() async {
    setState(() {
      _loading = true;
    });
    // remove projects
    _projects = null;

    // await office use cases
    debugPrint("_getOffice triggered");

    final officeResponse = await _officeUseCase.execute(widget.officeId);
    if (officeResponse.success) {
      if (mounted) {
        setState(() {
          _office = officeResponse.data?.data;
          _projects = officeResponse.data?.data.projects ?? <Project>[];
          _loading = false;
        });
      }
    } else {
      debugPrint(officeResponse.error);
      setState(() {
        _loading = false;
      });
    }
    // load selected office info
  }

  @override
  void initState() {
    super.initState();

    _getOffice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_office?.acronym ?? 'Office'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final project = _projects![index];

                debugPrint(project.toString());

                return ProjectItem(
                  project: _projects![index],
                  onTap: () {
                    // handle onTap
                  },
                );
              },
              itemCount: _projects?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

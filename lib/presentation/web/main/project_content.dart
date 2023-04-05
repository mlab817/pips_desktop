import 'package:flutter/material.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/project_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/full_project.dart';
import '../../common/loading_overlay.dart';
import '../../resources/sizes_manager.dart';

class ProjectContentView extends StatefulWidget {
  const ProjectContentView(
      {Key? key, required this.project, required this.onBack})
      : super(key: key);

  final Project project;
  final Function onBack;

  @override
  State<ProjectContentView> createState() => _ProjectContentViewState();
}

class _ProjectContentViewState extends State<ProjectContentView> {
  final ProjectUseCase _projectUseCase = instance<ProjectUseCase>();

  final ScrollController _scrollController = ScrollController();

  FullProject? _project;
  String? _error;
  bool _loading = false;

  // load project
  Future<void> _loadProject() async {
    setState(() {
      _loading = true;
    });

    (await _projectUseCase.execute(widget.project.uuid)).fold((failure) {
      setState(() {
        _project = null;
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _project = response.project;
        _error = null;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _loadProject();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var windowHeight = MediaQuery.of(context).size.height;

    if (_loading) {
      return const LoadingOverlay();
    }

    return Card(
      elevation: AppElevation.none,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.lg),
          topRight: Radius.circular(AppSize.lg),
          bottomLeft: Radius.circular(AppSize.lg),
        ),
      ),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.onBack();
              },
            ),
            title: Text(_error != null ? _error! : _project!.title),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          SizedBox(
            height: windowHeight - AppSize.s140,
            child: _error != null
                ? Center(child: Text(_error ?? 'Unknown Error'))
                : Scrollbar(
                    radius: Radius.zero,
                    thickness: AppSize.s12,
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppPadding.lg),
                        child: ListView(
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.account_circle_outlined),
                              title: Text(_project!.user?.fullname ?? 'User'),
                              subtitle:
                                  Text(_project!.user?.position ?? 'Position'),
                              trailing:
                                  Text(formatDate(_project!.updatedAt ?? '')),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('Title'),
                              title: Text(_project!.title),
                              trailing: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {},
                              ),
                            ),
                            ListTile(
                              leading: const Text('Type'),
                              title: Text(_project!.type?.name ?? ''),
                            ),
                            ListTile(
                              leading: const Text('Regular Program'),
                              title:
                                  Text(_project!.regularProgram ? 'Yes' : 'No'),
                            ),
                            ListTile(
                              leading: const Text('Basis for Implementation'),
                              title: Text(_project!.basisDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'No basis'),
                            ),
                            ListTile(
                              leading: const Text('Description'),
                              title: Text(_project!.description),
                              trailing: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {},
                              ),
                            ),
                            ListTile(
                              leading: const Text('Total Cost'),
                              title:
                                  Text(_project!.totalCost.toStringAsFixed(0)),
                              trailing: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {},
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('Office'),
                              title: Text(
                                  _project!.office?.acronym ?? 'No Office'),
                            ),
                            ListTile(
                              leading: const Text('Implementing Units'),
                              title: Text(_project!.operatingUnitDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'No Office'),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('Spatial Coverage'),
                              title: Text(_project!.spatialCoverage?.name ??
                                  'No spatial coverage'),
                            ),
                            ListTile(
                              leading: const Text('Locations'),
                              title: Text(_project!.locationDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'No location'),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('Level of Approval'),
                              title:
                                  Text(_project!.approvalLevel?.name ?? 'N/A'),
                            ),
                            ListTile(
                              leading: const Text('As of'),
                              title: Text(
                                  _project!.approvalLevelDate ?? 'No date'),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('PIP'),
                              title: _project!.pip
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text('Typology'),
                              title: Text(
                                  _project!.pipTypology?.name ?? 'No typology'),
                            ),
                            ListTile(
                              leading: const Text('TRIP'),
                              title: _project!.trip
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text('CIP'),
                              title: _project!.cip
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text('Type of CIP'),
                              title: Text(_project!.cipType?.name ?? 'N/A'),
                            ),
                            ListTile(
                              leading: const Text('COVID'),
                              title: _project!.covid
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text('Research'),
                              title: _project!.research
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text('RDIP'),
                              title: _project!.rdip
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            const Divider(),
                            ListTile(
                                leading: const Text('Main PDP Chapter'),
                                title:
                                    Text(_project!.pdpChapter?.name ?? 'N/A')),
                            ListTile(
                                leading: const Text('Other PDP Chapters'),
                                title: Text(_project!.pdpChapterDetails
                                        ?.map((e) => e.name)
                                        .join(', ') ??
                                    'N/A')),
                            const Divider(),
                            ListTile(
                              leading: const Text(
                                  'Main Infrastructure Sector/Subsector'),
                              title: Text(_project!.infrastructureSectorDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'N/A'),
                            ),
                            ListTile(
                              leading: const Text('Prerequisites'),
                              title: Text(_project!.prerequisiteDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'N/A'),
                            ),
                            ListTile(
                              leading: const Text(
                                  'Implementation Risks and Mitigation Strategies'),
                              title: Text(_project!.risk ?? 'N/A'),
                            ),
                            const Divider(),
                            ListTile(
                              leading:
                                  const Text('Expected Outputs/Deliverables'),
                              title: Text(_project!.expectedOutputs),
                            ),
                            const Divider(),
                            ListTile(
                              leading:
                                  const Text('8-Point Socioeconomic Agenda'),
                              title: Text(_project!.agendaDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'N/A'),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text(
                                  'Sustainable Development Goals (SDGs)'),
                              title: Text(_project!.sdgDetails
                                      ?.map((e) => e.name)
                                      .join(', ') ??
                                  'N/A'),
                            ),
                            const Divider(),
                            ListTile(
                              leading:
                                  const Text('Level of GAD Responsiveness'),
                              title: Text(_project!.gad?.name ?? 'N/A'),
                            ),
                            const Divider(),
                            ListTile(
                              leading:
                                  const Text('Project Preparation Details'),
                              title: Text(
                                  _project!.preparationDocument?.name ?? 'N/A'),
                            ),
                            ListTile(
                              leading:
                                  const Text('Status of Feasibility Study'),
                              title: Text(_project!.fsStatus?.name ?? 'N/A'),
                            ),
                            ListTile(
                              leading: const Text(
                                  'Will require assistance for the conduct of F/S?'),
                              title: _project!.fsNeedsAssistance != null &&
                                      _project!.fsNeedsAssistance!
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.close),
                            ),
                            ListTile(
                              leading: const Text(
                                  'Target/Actual date of completion'),
                              title: Text(_project!.fsCompletionDate ?? 'N/A'),
                            ),
                            ListTile(
                              leading:
                                  const Text('Total Cost of Feasibility Study'),
                              title: Text(_project!.fsTotalCost ?? "0"),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.copy),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Text('Right of Way'),
                              title: Text(
                                  _project!.hasRow != null && _project!.hasRow!
                                      ? 'Yes'
                                      : ' No'),
                            ),
                            ListTile(
                              leading: const Text('Affected Households'),
                              title: Text(
                                  _project!.rowAffectedHouseholds?.toString() ??
                                      '0'),
                            ),
                            ListTile(
                              leading: const Text('Affected Households'),
                              title: Text(
                                  _project!.rowTotalCost?.toString() ?? '0'),
                            ),
                            ListTile(
                              leading: const Text('Resettlement Action Plan'),
                              title: Text(
                                  _project!.hasRap != null && _project!.hasRap!
                                      ? 'Yes'
                                      : ' No'),
                            ),
                            ListTile(
                              leading: const Text('Affected Households'),
                              title: Text(
                                  _project!.rapAffectedHouseholds?.toString() ??
                                      '0'),
                            ),
                            ListTile(
                              leading: const Text('Affected Households'),
                              title: Text(
                                  _project!.rapTotalCost?.toString() ?? '0'),
                            ),
                            ListTile(
                              leading: const Text(
                                  'Has Right of Way and Resettlement Action Plan'),
                              title: Text(_project!.hasRowRap != null &&
                                      _project!.hasRowRap!
                                  ? 'Yes'
                                  : ' No'),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

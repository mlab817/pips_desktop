import 'package:bootstrap_breakpoints/bootstrap_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/common/resources/assets_manager.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/project/full_project_request.dart';
import 'package:pips/features/project/domain/usecase/createproject_usecase.dart';
import 'package:pips/features/project/domain/usecase/offices_usecase.dart';
import 'package:pips/features/project/presentation/widgets/empty_indicator.dart';
import 'package:pips/features/project/presentation/widgets/success_indicator.dart';

import '../../../../../app/dep_injection.dart';
import '../../../../../common/resources/sizes_manager.dart';
import '../../../../../common/resources/strings_manager.dart';
import '../../../../../common/widgets/loading_overlay.dart';
import '../../../../constants/constants.dart';
import '../../data/providers/options_provider.dart';
import '../../data/providers/project_provider.dart';
import '../../domain/models/office.dart';
import '../../domain/models/options.dart';
import '../../domain/models/presets.dart';
import '../../domain/usecase/options_usecase.dart';
import 'form_objects/update_description.dart';
import 'form_objects/update_financial_accomplishment.dart';
import 'form_objects/update_fs_cost.dart';
import 'form_objects/update_infra_sectors.dart';
import 'form_objects/update_investment_cost.dart';
import 'form_objects/update_pap.dart';
import 'form_objects/update_pip.dart';
import 'form_objects/update_regional_cost.dart';
import 'form_objects/update_title.dart';
import 'get_input_decoration.dart';
import 'select_dialog_content.dart';

enum Status {
  error,
  success,
  neutral,
}

class NewPap extends ConsumerStatefulWidget {
  const NewPap({Key? key, this.preset}) : super(key: key);

  final Preset? preset;

  @override
  ConsumerState<NewPap> createState() => _NewPapState();
}

class _NewPapState extends ConsumerState<NewPap> {
  late ScrollController _scrollController;

  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();
  final OfficesUseCase _officesUseCase = instance<OfficesUseCase>();

  final CreateProjectUseCase _createProjectUseCase =
      instance<CreateProjectUseCase>();

  // for reviewers use only

  // focus nodes
  final FocusNode _totalCostNode = FocusNode();
  final FocusNode _employedMaleNode = FocusNode();
  final FocusNode _employedFemaleNode = FocusNode();
  final FocusNode _expectedOutputNode = FocusNode();
  final FocusNode _riskNode = FocusNode();
  final FocusNode _updateNode = FocusNode();
  final FocusNode _remarkNode = FocusNode();
  final FocusNode _papCodeNode = FocusNode();
  final FocusNode _commentNode = FocusNode();

  List<Office>? _offices;

  int get _totalEmployment {
    int male =
        ref.watch(projectProvider.select((value) => value.employedMale)) ?? 0;
    int female =
        ref.watch(projectProvider.select((value) => value.employedFemale)) ?? 0;

    return male + female;
  }

  Options? _options;
  bool _loading = false;
  String? _error;

  // monitor scroll position
  double _scrollPercentage = 0;

  Future<void> _loadOffices() async {
    (await _officesUseCase.execute(GetOfficesRequest(perPage: 100))).fold(
        (failure) {
      _showSnackbar(
          message: 'Failed to load offices due to ${failure.message}.');
    }, (response) {
      setState(() {
        _offices = response.data;
      });
    });
  }

  Future<void> _selectBases() async {
    final bases = ref.watch(projectProvider.select((value) => value.bases));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (context) {
        List<Option> selected = bases;

        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.basisForImplementation),
          content: SelectDialogContent(
            options: options.bases ?? [],
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

    ref.read(projectProvider.notifier).update(bases: response);
  }

  // show radio to select office
  Future<void> _selectOffice() async {
    final office = ref.watch(projectProvider.select((value) => value.office));
    final offices = _offices ?? [];

    final Office? response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Office? selected = office;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.office),
            content: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: offices.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: offices[index],
                        groupValue: selected,
                        title: Text(offices[index].acronym),
                        onChanged: (Office? value) {
                          setState(() {
                            selected = value;
                          });
                        },
                      );
                    },
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

    ref.read(projectProvider.notifier).update(office: response);
  }

  Future<void> _selectOus() async {
    final operatingUnits =
        ref.watch(projectProvider.select((value) => value.operatingUnits));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = operatingUnits;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.operatingUnits),
            content: SelectDialogContent(
              options: options.operatingUnits ?? [],
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

    ref.read(projectProvider.notifier).update(operatingUnits: response);
  }

  Future<void> _selectPdpChapter() async {
    final pdpChapter =
        ref.watch(projectProvider.select((value) => value.pdpChapter));
    final options = ref.watch(optionsState);

    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = pdpChapter;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.mainPdpChapter),
            content: SelectDialogContent(
              options: options.pdpChapters ?? [],
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

    ref.read(projectProvider.notifier).update(pdpChapter: response);
  }

  Future<void> _selectPdpChapters() async {
    final pdpChapters =
        ref.watch(projectProvider.select((value) => value.pdpChapters));
    final options = ref.watch(optionsState);

    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = pdpChapters;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.otherPdpChapters),
            content: SelectDialogContent(
              options: options.pdpChapters ?? [],
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

    ref.read(projectProvider.notifier).update(pdpChapters: response);
  }

  Future<void> _selectSdgs() async {
    final sdgs = ref.watch(projectProvider.select((value) => value.sdgs));
    final options = ref.watch(optionsState);

    //
    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = sdgs;

          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text(AppStrings.sustainableDevelopmentGoals),
            content: SelectDialogContent(
              options: options.sdgs ?? [],
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

    ref.read(projectProvider.notifier).update(sdgs: response);
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
        ref.read(optionsState.notifier).setState(response.data!);
        setState(() {
          _options = response.data;
          _loading = false;
        });
      }
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
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final project = ref.watch(projectProvider);

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
              _error ?? AppStrings.unknownError,
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
              child: const Text(AppStrings.tryAgain),
            ),
          ],
        ),
      );
    }

    List<Widget> children = [
      const Text('General Information'),
      const UpdateTitle(),
      const UpdatePap(),
      _buildRegularProgram(),
      _buildBases(),
      const UpdateDescription(),
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
      const UpdatePip(),
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
      const UpdateInfraSectors(),
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
      const UpdateFsCost(),
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
      const UpdateRegionalCost(),
      const Divider(),
      const UpdateInvestmentCost(),
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
      const UpdateFinancialAccomplishment(),
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
              onPressed: () async {
                // TODO: handle submit
                FullProjectRequest projectToSubmit =
                    FullProjectRequest.fromFullProject(project);

                debugPrint(projectToSubmit.toJson().toString());

                (await _createProjectUseCase.execute(projectToSubmit)).fold(
                    (l) {
                  debugPrint(l.toString());
                  _showSnackbar(message: l.message, status: Status.error);
                }, (r) => debugPrint(r.toString()));
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

  Widget _buildRegularProgram() {
    final regularProgram =
        ref.watch(projectProvider.select((value) => value.regularProgram));
    final type = ref.watch(projectProvider.select((value) => value.type));

    return SwitchListTile(
      value: regularProgram ?? false,
      onChanged: type?.value == 1
          ? (bool value) {
              ref.read(projectProvider.notifier).update(regularProgram: value);
            }
          : null,
      title: const Text(AppStrings.regularProgram),
      subtitle: const Text(
          'A regular program refers to a program being implemented by the agencies on a continuing basis.'),
    );
  }

  Widget _buildBases() {
    final bases = ref.watch(projectProvider.select((value) => value.bases));

    return ListTile(
      title: const Text(AppStrings.basisForImplementation),
      subtitle: bases.isNotEmpty
          ? Text(bases.map((e) => e.label).join(', '))
          : const Text(
              AppStrings.selectAsManyAsApplicable,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      trailing:
          bases.isNotEmpty ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectBases,
    );
  }

  Widget _buildTotalProjectCost() {
    final totalCost =
        ref.watch(projectProvider.select((state) => state.totalCost));

    debugPrint(totalCost.toString());

    return ListTile(
      title: const Text('Total Project Cost in absolute PHP'),
      trailing:
          totalCost != null ? const SuccessIndicator() : const EmptyIndicator(),
      subtitle: TextFormField(
        focusNode: _totalCostNode,
        initialValue: totalCost?.toString() ?? '',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration:
            getTextInputDecoration(hintText: AppStrings.totalProjectCost),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          ref
              .read(projectProvider.notifier)
              .update(totalCost: double.tryParse(value));
        },
      ),
      onTap: () {
        _totalCostNode.requestFocus();
      },
    );
  }

  Widget _buildOffice() {
    final office = ref.watch(projectProvider.select((value) => value.office));

    return ListTile(
      title: const Text(AppStrings.office),
      subtitle: office != null
          ? Text(office.acronym)
          : const Text(AppStrings.selectOne),
      trailing:
          office != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectOffice,
    );
  }

  Widget _buildOus() {
    final operatingUnits =
        ref.watch(projectProvider.select((value) => value.operatingUnits));

    return ListTile(
      title: const Text(AppStrings.operatingUnits),
      subtitle: operatingUnits.isNotEmpty
          ? Text(operatingUnits.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: operatingUnits.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectOus,
    );
  }

  Widget _buildSpatialCoverage() {
    final spatialCoverage =
        ref.watch(projectProvider.select((value) => value.spatialCoverage));

    return ListTile(
      title: const Text(AppStrings.spatialCoverage),
      subtitle: spatialCoverage != null
          ? Text(spatialCoverage.label)
          : const Text(AppStrings.selectOne),
      trailing: spatialCoverage != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectSpatialCoverage,
    );
  }

  Future<void> _selectSpatialCoverage() async {
    final spatialCoverage =
        ref.watch(projectProvider.select((value) => value.spatialCoverage));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = spatialCoverage;

          return AlertDialog(
            title: const Text(AppStrings.spatialCoverage),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options.spatialCoverages ?? [],
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

    ref.read(projectProvider.notifier).update(spatialCoverage: response);
  }

  Widget _buildLocations() {
    final locations =
        ref.watch(projectProvider.select((value) => value.locations));

    return ListTile(
      title: const Text(AppStrings.regionsProvinces),
      subtitle: locations.isNotEmpty
          ? Text(locations.map((location) => location.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: locations.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectLocations,
    );
  }

  Future<void> _selectLocations() async {
    final locations =
        ref.watch(projectProvider.select((value) => value.locations));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option>? selected = locations;

          return AlertDialog(
            title: const Text(AppStrings.regionsProvinces),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options.locations ?? [],
              selected: selected,
              multiple: true,
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

    ref.read(projectProvider.notifier).update(locations: response);
  }

  Widget _buildIccable() {
    final cip = ref.watch(projectProvider.select((value) => value.cip));
    final iccable = ref.watch(projectProvider.select((value) => value.iccable));

    return SwitchListTile(
      title: const Text(
          'Will require Investment Coordination Committee/NEDA Board Approval (ICC-able)?'),
      value: iccable ?? false,
      onChanged: cip ?? false
          ? (bool value) {
              ref.read(projectProvider.notifier).update(iccable: value);
            }
          : null,
    );
  }

  Widget _buildApprovalLevel() {
    final iccable = ref.watch(projectProvider.select((value) => value.iccable));
    final approvalLevel =
        ref.watch(projectProvider.select((value) => value.approvalLevel));

    return ListTile(
      enabled: iccable ?? false,
      title: const Text('Level (Status) of Approval'),
      subtitle: approvalLevel != null
          ? Text(approvalLevel.label)
          : const Text(AppStrings.selectOne),
      trailing: approvalLevel != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectApprovalLevel,
    );
  }

  Future<void> _selectApprovalLevel() async {
    final approvalLevel =
        ref.watch(projectProvider.select((value) => value.approvalLevel));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = approvalLevel;

          return AlertDialog(
            title: const Text('Level (Status) of Approval'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options.approvalLevels ?? [],
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

    ref.read(projectProvider.notifier).update(approvalLevel: response);
  }

  Widget _buildTypology() {
    final pip = ref.watch(projectProvider.select((state) => state.pip));
    final typology =
        ref.watch(projectProvider.select((state) => state.typology));

    return ListTile(
      enabled: pip ?? false,
      title: const Text('Typology'),
      subtitle: typology != null
          ? Text(typology.label)
          : const Text(AppStrings.selectOne),
      trailing:
          typology != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectTypology,
    );
  }

  Future<void> _selectTypology() async {
    final typology =
        ref.watch(projectProvider.select((state) => state.typology));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = typology;

          return AlertDialog(
            title: const Text(AppStrings.typologyOfPip),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options.typologies ?? [],
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

    ref.read(projectProvider).copyWith(typology: response);
  }

  Widget _buildCip() {
    // TODO: add a confirmation dialog to check if the PAP meets any of the
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    // CIP criteria
    return SwitchListTile(
        value: cip ?? false,
        title: const Text(AppStrings.coreInvestmentProgramsProjects),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of CIP'),
        onChanged: (bool? value) {
          // if user is trying to change config
          _toggleCip(value);
        });
  }

  Future<void> _toggleCip(bool? value) async {
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    // check if the user is trying to change the data
    if (value != cip) {
      await showDialog(
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

      // set the iccable to be the same as CIP since
      // CIP tagging requires ICCable
      ref.read(projectProvider.notifier).update(
            cip: value ?? false,
            iccable: value,
          );

      if (value ?? false) {
        _showSnackbar(
            message:
                'PAPs tagged as CIP require ICC/NEDA Board approval. Make sure to provide the type and processing status below.');
      }
    }
  }

  Widget _buildCipType() {
    final cip = ref.watch(projectProvider.select((state) => state.cip));
    final cipType = ref.watch(projectProvider.select((state) => state.cipType));

    return ListTile(
      enabled: cip ?? false,
      title: const Text('Type of CIP'),
      subtitle: cipType != null
          ? Text(cipType.label)
          : const Text(AppStrings.typeOfCip),
      trailing:
          cipType != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: cip ?? false ? _selectCipType : null,
    );
  }

  Future<void> _selectCipType() async {
    final cipType = ref.watch(projectProvider.select((state) => state.cipType));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = cipType;

          return AlertDialog(
            title: const Text('Type of CIP'),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: options.cipTypes ?? [],
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

    ref.read(projectProvider.notifier).update(cipType: response);
  }

  Widget _buildTrip() {
    final trip = ref.watch(projectProvider.select((value) => value.trip));

    return SwitchListTile(
        value: trip ?? false,
        title: const Text('Three Year Rolling Infrastructure Program'),
        subtitle:
            const Text('// TODO: Explain the requirements to be part of TRIP'),
        onChanged: (bool? value) {
          ref.read(projectProvider.notifier).update(trip: value);
        });
  }

  Widget _buildRdip() {
    final rdip = ref.watch(projectProvider.select((state) => state.rdip));

    return SwitchListTile(
        value: rdip ?? false,
        title: const Text('Regional Development Investment Program'),
        // TODO: Explain the requirements to be part of RDIP
        subtitle: const Text(
            'To facilitate validation, please make sure to upload the relevant RDC endorsement later.'),
        onChanged: (bool? value) {
          ref.read(projectProvider.notifier).update(rdip: value);
        });
    // TODO: require user to attach RDIP
    // For RDIP, the user should only submit two pages, 1 - RDC endorsement / reso
    // and 2 - the relevant page of the RDIP where the PAP is present
  }

  Widget _buildResearch() {
    final research =
        ref.watch(projectProvider.select((state) => state.research));

    return SwitchListTile(
        value: research ?? false,
        title: const Text('Is it a research and development project?'),
        // TODO: Explain the requirements to be part of RDIP
        onChanged: (bool? value) {
          ref.read(projectProvider.notifier).update(research: value);
        });
  }

  Widget _buildCovid() {
    final covid = ref.watch(projectProvider.select((state) => state.covid));

    return SwitchListTile(
        value: covid ?? false,
        title: const Text('Is it response to COVID-19 pandemic'),
        // TODO: Explain the requirements to be a response of COVID-19
        onChanged: (bool? value) {
          ref.read(projectProvider.notifier).update(covid: value);
        });
  }

  Widget _buildApprovalLevelDate() {
    final iccable = ref.watch(projectProvider.select((state) => state.iccable));
    final approvalLevelDate =
        ref.watch(projectProvider.select((state) => state.approvalLevelDate));

    return ListTile(
      enabled: iccable ?? false,
      title: const Text(AppStrings.asOf),
      subtitle: approvalLevelDate != null
          ? Text(DateFormat.yMMMd().format(approvalLevelDate))
          : const Text(AppStrings.selectDate),
      trailing: approvalLevelDate != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      // TODO: update color on success
      onTap: _selectApprovalLevelDate,
    );
  }

  Future<void> _selectApprovalLevelDate() async {
    DateTime? approvalLevelDate =
        ref.watch(projectProvider.select((state) => state.approvalLevelDate));

    final DateTime? response = await showDatePicker(
      context: context,
      initialDate: approvalLevelDate ?? DateTime.now(),
      firstDate: DateTime.utc(2010),
      lastDate: DateTime.now(),
    );

    ref.read(projectProvider.notifier).update(approvalLevelDate: response);
  }

  Widget _buildPdpChapter() {
    final pdpChapter =
        ref.watch(projectProvider.select((state) => state.pdpChapter));

    //
    return ListTile(
      title: const Text('Main PDP Chapter'),
      subtitle: pdpChapter != null
          ? Text(pdpChapter.label)
          : const Text(AppStrings.selectOne),
      trailing: pdpChapter != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectPdpChapter,
    );
  }

  Widget _buildPdpChapters() {
    final pdpChapters =
        ref.watch(projectProvider.select((state) => state.pdpChapters));
    //
    return ListTile(
      title: const Text('Other PDP Chapters'),
      subtitle: pdpChapters.isNotEmpty
          ? Text(pdpChapters.map((e) => e.label).join(', '))
          : const Text('Select as many as applicable'),
      trailing: pdpChapters.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(), // TODO: update color on success
      onTap: _selectPdpChapters,
    );
  }

  Widget _buildExpectedOutputs() {
    final expectedOutputs =
        ref.watch(projectProvider.select((state) => state.expectedOutputs));

    return ListTile(
      title: const Text('Expected Outputs/Deliverables'),
      subtitle: TextFormField(
        focusNode: _expectedOutputNode,
        initialValue: expectedOutputs,
        decoration:
            getTextInputDecoration(hintText: 'Expected Outputs/Deliverables'),
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 4,
        onChanged: (String value) {
          ref.read(projectProvider.notifier).update(expectedOutputs: value);
        },
      ),
      trailing: expectedOutputs != null && expectedOutputs.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: () {
        _expectedOutputNode.requestFocus();
      },
    );
  }

  Widget _buildPrerequisites() {
    final trip = ref.watch(projectProvider.select((state) => state.trip));
    final prerequisites =
        ref.watch(projectProvider.select((state) => state.prerequisites));

    return ListTile(
      enabled: trip ?? false,
      title: const Text('Status of Implementation Readiness'),
      subtitle: prerequisites.isNotEmpty
          ? Text(prerequisites.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: prerequisites.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectPrerequisites,
    );
  }

  Future<void> _selectPrerequisites() async {
    final prerequisites =
        ref.watch(projectProvider.select((state) => state.prerequisites));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          List<Option> selected = prerequisites;

          return AlertDialog(
            title: const Text('Status of Implementation Readiness'),
            content: SelectDialogContent(
              options: options.prerequisites ?? [],
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

    ref.read(projectProvider.notifier).update(prerequisites: response);
  }

  Widget _buildRisk() {
    final trip = ref.watch(projectProvider.select((value) => value.trip));
    final risk = ref.watch(projectProvider.select((value) => value.risk));

    return ListTile(
      enabled: trip ?? false,
      title: const Text('Implementation Risks and Mitigation Strategies'),
      trailing: risk != null && risk.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      subtitle: TextFormField(
          enabled: trip ?? false,
          focusNode: _riskNode,
          initialValue: risk,
          decoration: getTextInputDecoration(
              hintText: 'Implementation Risks and Mitigation Strategies'),
          // isDense: true,
          style: Theme.of(context).textTheme.bodyMedium,
          minLines: 3,
          maxLines: 4,
          onChanged: (String value) {
            ref.read(projectProvider.notifier).update(risk: value);
          }),
      onTap: () {
        _riskNode.requestFocus();
      },
    );
  }

  Widget _buildSdgs() {
    final sdgs = ref.watch(projectProvider.select((state) => state.sdgs));
    //
    return ListTile(
      title: const Text(AppStrings.sustainableDevelopmentGoals),
      subtitle: sdgs.isNotEmpty
          ? Text(sdgs.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing:
          sdgs.isNotEmpty ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectSdgs,
    );
  }

  Widget _buildAgenda() {
    final agenda = ref.watch(projectProvider.select((state) => state.agenda));
    //
    return ListTile(
      title: const Text(AppStrings.socioeconomicAgenda),
      subtitle: agenda.isNotEmpty
          ? Text(agenda.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing:
          agenda.isNotEmpty ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectAgenda,
    );
  }

  Future<void> _selectAgenda() async {
    final agenda = ref.watch(projectProvider.select((state) => state.agenda));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          List<Option> selected = agenda;
          //
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Socioeconomic Agenda'),
            content: SelectDialogContent(
              options: options.agenda ?? [],
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

    ref.read(projectProvider.notifier).update(agenda: response);
  }

  Widget _buildGad() {
    final cip = ref.watch(projectProvider.select((state) => state.cip));
    final gad = ref.watch(projectProvider.select((state) => state.gad));

    return ListTile(
      enabled: cip ?? false,
      title: const Text('Level of Gender Responsiveness'),
      subtitle:
          gad != null ? Text(gad.label) : const Text(AppStrings.selectOne),
      trailing: gad != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectGad,
    );
  }

  Future<void> _selectGad() async {
    final gad = ref.watch(projectProvider.select((state) => state.gad));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = gad;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Level of Gender Responsiveness'),
          content: SelectDialogContent(
            options: options.gads ?? [],
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

    ref.read(projectProvider.notifier).update(gad: response);
  }

  Widget _buildPreparationDocument() {
    final cip = ref.watch(projectProvider.select((state) => state.cip));
    final preparationDocument =
        ref.watch(projectProvider.select((state) => state.preparationDocument));

    return ListTile(
      enabled: cip ?? false,
      title: const Text('Project Preparation Document'),
      subtitle: preparationDocument != null
          ? Text(preparationDocument.label)
          : const Text(AppStrings.selectOne),
      trailing: preparationDocument != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectPreparationDocument,
    );
  }

  Future<void> _selectPreparationDocument() async {
    final preparationDocument =
        ref.watch(projectProvider.select((state) => state.preparationDocument));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = preparationDocument;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Project Preparation Document'),
          content: SelectDialogContent(
            options: options.preparationDocuments ?? [],
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

    ref.read(projectProvider.notifier).update(preparationDocument: response);
  }

  // CIP only
  Widget _buildNeedFsAssistance() {
    final fsNeedsAssistance =
        ref.watch(projectProvider.select((state) => state.fsNeedsAssistance));
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    return SwitchListTile(
      value: fsNeedsAssistance ?? false,
      title:
          const Text('Requires assistance in the conduct of Feasibility Study'),
      onChanged: cip ?? false
          ? (bool value) {
              ref
                  .read(projectProvider.notifier)
                  .update(fsNeedsAssistance: value);
            }
          : null,
    );
  }

  // CIP only
  Widget _buildFsStatus() {
    final fsStatus =
        ref.watch(projectProvider.select((value) => value.fsStatus));
    final cip = ref.watch(projectProvider.select((value) => value.cip));

    return ListTile(
      title: const Text('Status of Feasibility Study'),
      subtitle: fsStatus != null
          ? Text(fsStatus.label)
          : const Text(AppStrings.selectOne),
      trailing:
          fsStatus != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: cip ?? false ? _selectFsStatus : null,
    );
  }

  Future<void> _selectFsStatus() async {
    final fsStatus =
        ref.watch(projectProvider.select((value) => value.fsStatus));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = fsStatus;

          //
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            title: const Text('Status of Feasibility Study'),
            content: SelectDialogContent(
                options: options.fsStatuses ?? [],
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

    ref.read(projectProvider.notifier).update(fsStatus: response);
  }

  Widget _buildFsCompletionDate() {
    final fsCompletionDate =
        ref.watch(projectProvider.select((value) => value.fsCompletionDate));
    final preparationDocument =
        ref.watch(projectProvider.select((state) => state.preparationDocument));

    return ListTile(
      title: const Text('F/S Target Completion Date'),
      subtitle: fsCompletionDate != null
          ? Text(DateFormat.yMMMd().format(fsCompletionDate))
          : const Text(AppStrings.selectDate),
      trailing: fsCompletionDate != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: preparationDocument != null && preparationDocument.value == 2
          ? _selectFsCompletionDate
          : null,
    );
  }

  Future<void> _selectFsCompletionDate() async {
    final fsCompletionDate =
        ref.watch(projectProvider.select((state) => state.fsCompletionDate));

    final DateTime? response = await showDatePicker(
      context: context,
      initialDate: fsCompletionDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2028),
    );

    ref.read(projectProvider.notifier).update(fsCompletionDate: response);
  }

  // CIP only

  // CIP only
  Widget _buildRow() {
    final hasRow = ref.watch(projectProvider.select((state) => state.hasRow));
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    return SwitchListTile(
      title: const Text('With Right of Way Component?'),
      value: hasRow ?? false,
      onChanged: cip ?? false
          ? (bool value) {
              ref.read(projectProvider.notifier).update(hasRow: value);
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
          dataRowHeight: AppSize.s60,
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
                      decoration: getTextInputDecoration(),
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
    final rowAffectedHouseholds = ref
        .watch(projectProvider.select((value) => value.rowAffectedHouseholds));

    return ListTile(
      title: const Text('Affected Households'),
      subtitle: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        // TODO: initial value and onChanged
        initialValue: rowAffectedHouseholds.toString(),
        decoration: getTextInputDecoration(),
        onChanged: (String value) {
          ref
              .read(projectProvider.notifier)
              .update(rowAffectedHouseholds: int.tryParse(value));
        },
      ),
    );
  }

  // CIP only
  Widget _buildRap() {
    final hasRap = ref.watch(projectProvider.select((state) => state.hasRap));
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    return SwitchListTile(
      title: const Text('With Resettlement Component?'),
      value: hasRap ?? false,
      onChanged: cip ?? false
          ? (bool value) {
              ref.read(projectProvider.notifier).update(hasRap: value);
            }
          : null,
    );
  }

  // CIP only
  Widget _buildRapCost() {
    final windowWidth = Breakpoints().getScreenWidth(context) - 128;
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
                decoration: getTextInputDecoration(),
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
          dataRowHeight: AppSize.s60,
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
        // TODO: initial value and onChanged
        decoration: getTextInputDecoration(),
      ),
    );
  }

  // CIP only
  Widget _buildRowRap() {
    final hasRowRap =
        ref.watch(projectProvider.select((state) => state.hasRowRap));
    final cip = ref.watch(projectProvider.select((state) => state.cip));

    return SwitchListTile(
      title: const Text('With Right and Way and Resettlement Component?'),
      value: hasRowRap ?? false,
      onChanged: cip ?? false
          ? (bool value) {
              ref.read(projectProvider.notifier).update(hasRowRap: value);
            }
          : null,
    );
  }

  Widget _buildEmployment() {
    final trip = ref.watch(projectProvider.select((state) => state.trip));

    return ListTile(
      enabled: trip ?? false,
      title: const Text('No. of persons to be employed'),
      subtitle: Text(_totalEmployment.toString()),
    );
  }

  Widget _buildEmploymentMale() {
    final employedMale =
        ref.watch(projectProvider.select((value) => value.employedMale));

    return ListTile(
      title: const Text('No. of Males'),
      subtitle: TextFormField(
        focusNode: _employedMaleNode,
        // TODO: initial value and onChanged
        initialValue: employedMale?.toString() ?? '',
        keyboardType: TextInputType.number,
        decoration: getTextInputDecoration(hintText: 'No. of Males'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          ref
              .read(projectProvider.notifier)
              .update(employedMale: int.tryParse(value));
        },
      ),
      onTap: () {
        _employedMaleNode.requestFocus();
      },
    );
  }

  Widget _buildEmploymentFemale() {
    final employedFemale =
        ref.watch(projectProvider.select((value) => value.employedFemale));

    return ListTile(
      title: const Text('No. of Females'),
      subtitle: TextFormField(
        focusNode: _employedFemaleNode,
        // TODO: initial value and onChanged
        initialValue: employedFemale?.toString() ?? '',
        keyboardType: TextInputType.number,
        decoration: getTextInputDecoration(hintText: 'No. of Females'),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          ref
              .read(projectProvider.notifier)
              .update(employedFemale: int.tryParse(value));
        },
      ),
      onTap: () {
        _employedFemaleNode.requestFocus();
      },
    );
  }

  Widget _buildFundingSource() {
    final fundingSource =
        ref.watch(projectProvider.select((state) => state.fundingSource));
    final type = ref.watch(projectProvider.select((state) => state.type));

    return ListTile(
      title: const Text('Main Funding Source'),
      subtitle: fundingSource != null
          ? Text(fundingSource.label)
          : const Text(AppStrings.selectOne),
      trailing: fundingSource != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: type?.value != 1 ? _selectFundingSource : null,
    );
  }

  Future<void> _selectFundingSource() async {
    final fundingSource =
        ref.watch(projectProvider.select((value) => value.fundingSource));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = fundingSource;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.mainFundingSource),
          content: SelectDialogContent(
            options: options.fundingSources ?? [],
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

    ref.read(projectProvider.notifier).update(fundingSource: response);
  }

  Widget _buildFundingSources() {
    final fundingSources =
        ref.watch(projectProvider.select((value) => value.fundingSources));
    final type = ref.watch(projectProvider.select((value) => value.type));

    return ListTile(
      enabled: type?.value != 1,
      // enable only if pap type if not a program
      title: const Text(AppStrings.otherFundingSources),
      subtitle: fundingSources.isNotEmpty
          ? Text(fundingSources.map((e) => e.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: fundingSources.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectFundingSources,
    );
  }

  Future<void> _selectFundingSources() async {
    final fundingSources =
        ref.watch(projectProvider.select((value) => value.fundingSources));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Option> selected = fundingSources;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.otherFundingSources),
          content: SelectDialogContent(
            options: options.fundingSources ?? [],
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

    ref.read(projectProvider.notifier).update(fundingSources: response);
  }

  Widget _buildImplementationMode() {
    final implementationMode =
        ref.watch(projectProvider.select((state) => state.implementationMode));
    final type = ref.watch(projectProvider.select((state) => state.type));

    return ListTile(
      title: const Text(AppStrings.modeOfImplementation),
      subtitle: implementationMode != null
          ? Text(implementationMode.label)
          : const Text(AppStrings.selectOne),
      trailing: implementationMode != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: type?.value != 1 ? _selectImplementationMode : null,
    );
  }

  Future<void> _selectImplementationMode() async {
    final implementationMode =
        ref.watch(projectProvider.select((state) => state.implementationMode));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = implementationMode;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text('Mode of Implementation'),
          content: SelectDialogContent(
            options: options.implementationModes ?? [],
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

    ref.read(projectProvider.notifier).update(implementationMode: response);
  }

  Widget _buildFundingInstitutions() {
    final fundingInstitutions =
        ref.watch(projectProvider.select((state) => state.fundingInstitutions));

    return ListTile(
      title: const Text(AppStrings.fundingInstitutions),
      subtitle: fundingInstitutions.isNotEmpty
          ? Text(fundingInstitutions.map((element) => element.label).join(', '))
          : const Text(AppStrings.selectAsManyAsApplicable),
      trailing: fundingInstitutions.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      // TODO: disable if not NG-Grant/NG-Loan
      onTap: _selectFundingInstitutions,
    );
  }

  Future<void> _selectFundingInstitutions() async {
    final fundingInstitutions =
        ref.watch(projectProvider.select((state) => state.fundingInstitutions));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          List<Option> selected = fundingInstitutions;

          return AlertDialog(
            title: const Text(AppStrings.fundingInstitutions),
            content: SelectDialogContent(
              options: options.fundingInstitutions ?? [],
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

    ref.read(projectProvider.notifier).update(fundingInstitutions: response);
  }

  /// TRIP only
  Widget _buildCategory() {
    final trip = ref.watch(projectProvider.select((value) => value.trip));
    final category =
        ref.watch(projectProvider.select((value) => value.category));

    return ListTile(
      enabled: trip ?? false,
      title: const Text(AppStrings.category),
      subtitle: category != null
          ? Text(category.label)
          : const Text(AppStrings.selectOne),
      trailing:
          category != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectCategory,
    );
  }

  ///
  ///
  Future<void> _selectCategory() async {
    final category =
        ref.watch(projectProvider.select((value) => value.category));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = category;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.category),
          content: SelectDialogContent(
            options: options.categories ?? [],
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

    ref.read(projectProvider.notifier).update(category: response);
  }

  Widget _buildReadiness() {
    final trip = ref.watch(projectProvider.select((value) => value.trip));
    final projectStatus =
        ref.watch(projectProvider.select((value) => value.projectStatus));

    return ListTile(
      enabled: trip ?? false,
      title: const Text(AppStrings.statusOfImplementationReadiness),
      subtitle: projectStatus != null
          ? Text(projectStatus.label)
          : const Text(AppStrings.selectOne),
      trailing: projectStatus != null
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: _selectReadiness,
    );
  }

  Future<void> _selectReadiness() async {
    final projectStatus =
        ref.watch(projectProvider.select((value) => value.projectStatus));
    final options = ref.watch(optionsState);

    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        Option? selected = projectStatus;

        //
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
          title: const Text(AppStrings.statusOfImplementationReadiness),
          content: SelectDialogContent(
            options: options.projectStatuses ?? [],
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
    ref.read(projectProvider.notifier).update(projectStatus: response);
  }

  ///
  ///
  Widget _buildUpdates() {
    final updates = ref.watch(projectProvider.select((value) => value.updates));

    return ListTile(
      title: const Text(AppStrings.updates),
      subtitle: TextFormField(
        focusNode: _updateNode,
        // TODO: initial value and onChanged
        initialValue: updates,
        decoration: getTextInputDecoration(
            hintText:
                'For proposed program/project, please indicate the physical status of the program/project in terms of project preparation, approval, funding, etc. If ongoing, please provide information on the delivery of outputs, percentage of completion and financial status/ accomplishment in terms of utilization rate. Indicate the date of reference of the updates provided i.e. as of (month, day, year).'),
        minLines: 3,
        maxLines: 4,
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (String value) {
          ref.read(projectProvider.notifier).update(updates: value);
        },
      ),
      trailing: updates != null && updates.isNotEmpty
          ? const SuccessIndicator()
          : const EmptyIndicator(),
      onTap: () {
        _updateNode.requestFocus();
      },
    );
  }

  ///
  ///
  Widget _buildUpdatesAsOf() {
    final asOf = ref.watch(projectProvider.select((state) => state.asOf));

    return ListTile(
      title: const Text(AppStrings.asOf),
      subtitle: asOf != null
          ? Text(DateFormat.yMMMd().format(asOf))
          : const Text(AppStrings.selectDate),
      trailing:
          asOf != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: _selectUpdatesAsOf,
    );
  }

  ///
  ///
  Future<void> _selectUpdatesAsOf() async {
    final asOf = ref.watch(projectProvider.select((state) => state.asOf));

    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: asOf ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    ref.read(projectProvider.notifier).update(asOf: result);
  }

  ///
  ///
  Widget _buildStart() {
    final startYear =
        ref.watch(projectProvider.select((value) => value.startYear));
    final type = ref.watch(projectProvider.select((state) => state.type));

    return ListTile(
      title: const Text(AppStrings.startOfProjectImplementation),
      subtitle: startYear != null
          ? Text(startYear.label)
          : const Text(AppStrings.selectYear),
      trailing:
          startYear != null ? const SuccessIndicator() : const EmptyIndicator(),
      // _project.type?.value != 1
      onTap: type?.value != 1
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
    final startYear =
        ref.watch(projectProvider.select((state) => state.startYear));
    final endYear = ref.watch(projectProvider.select((state) => state.endYear));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (context) {
          Option? selected = startYear;
          final years = options.years
                  ?.where((element) => (element.value.toInt() <= 2028))
                  .toList() ??
              [];

          return AlertDialog(
            title: const Text(AppStrings.startOfProjectImplementation),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: years,
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
    if (endYear != null &&
        response != null &&
        endYear.value < response!.value) {
      ref.read(projectProvider.notifier).update(endYear: null);

      _showSnackbar(
          message:
              'Year of project completion has been removed because it is before the selected start of project implementation.');
    }

    ref.read(projectProvider.notifier).update(startYear: response);
  }

  Widget _buildEnd() {
    final startYear =
        ref.watch(projectProvider.select((state) => state.startYear));
    final endYear = ref.watch(projectProvider.select((state) => state.endYear));
    final type = ref.watch(projectProvider.select((state) => state.type));

    return ListTile(
      enabled: startYear != null,
      title: const Text('Year of Project Completion'),
      subtitle: endYear != null
          ? Text(endYear.label)
          : (startYear != null
              ? const Text(AppStrings.selectYear)
              : const Text('Select start of project implementation first')),
      trailing:
          endYear != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: type?.value != 1
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
    final endYear = ref.watch(projectProvider.select((state) => state.endYear));
    final options = ref.watch(optionsState);

    final response = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Option? selected = endYear;

          final years = options.years
                  ?.where((element) => (element.value >= 2023))
                  .toList() ??
              [];

          debugPrint(years.toString());

          return AlertDialog(
            title: const Text(AppStrings.yearOfProjectCompletion),
            contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.lg),
            content: SelectDialogContent(
              options: years,
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

    ref.read(projectProvider.notifier).update(endYear: response);
  }

  Widget _buildPapCode() {
    final pureGrant =
        ref.watch(projectProvider.select((state) => state.pureGrant));
    final uacsCode =
        ref.watch(projectProvider.select((state) => state.uacsCode));

    return ListTile(
      enabled: !(pureGrant ?? false),
      title: const Text(AppStrings.papUacsCode),
      trailing:
          uacsCode != null ? const SuccessIndicator() : const EmptyIndicator(),
      onTap: () {
        _papCodeNode.requestFocus();
      },
      subtitle: TextFormField(
        enabled: !(pureGrant ?? false),
        focusNode: _papCodeNode,
        // TODO: initial value and onChanged
        initialValue: uacsCode,
        decoration: getTextInputDecoration(hintText: '15-digit PREXC_FPAP_ID'),
        style: Theme.of(context).textTheme.bodyMedium,
        maxLength: 15,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String value) {
          ref.read(projectProvider.notifier).update(uacsCode: value);
        },
      ),
    );
  }

  Widget _buildPureGrant() {
    final pureGrant =
        ref.watch(projectProvider.select((state) => state.pureGrant));
    final type = ref.watch(projectProvider.select((state) => state.type));

    return SwitchListTile(
      value: pureGrant ?? false,
      title: const Text(AppStrings.thisIsPureGrant),
      //
      onChanged: type?.value != 1
          ? (bool? value) {
              ref.read(projectProvider.notifier).update(pureGrant: value);
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
        // TODO: initial value and onChanged
        initialValue:
            ref.watch(projectProvider.select((state) => state.remarks)),
        decoration: getTextInputDecoration(hintText: AppStrings.remarks),
        style: Theme.of(context).textTheme.bodyMedium,
        minLines: 3,
        maxLines: 5,
        onChanged: (String value) {
          ref.read(projectProvider.notifier).update(remarks: value);
        },
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
        // TODO: initial value and onChanged
        decoration: getTextInputDecoration(hintText: 'Comments'),
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
    ref.read(projectProvider.notifier).update(
          iccable: false,
          cipType: null,
          approvalLevel: null,
          approvalLevelDate: null,
          gad: null,
        );
  }
}

Widget buildCancel(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text(AppStrings.cancel),
  );
}

Widget buildUpdate(BuildContext context, Function onUpdate) {
  return FilledButton(
    onPressed: () {
      onUpdate();
    },
    child: const Text(AppStrings.update),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/office.dart';
import '../../../domain/usecase/office_usecase.dart';
import '../../../domain/usecase/offices_usecase.dart';

class OfficesView extends StatefulWidget {
  const OfficesView({Key? key}) : super(key: key);

  @override
  State<OfficesView> createState() => _OfficesViewState();
}

class _OfficesViewState extends State<OfficesView> {
  final OfficesUseCase _officesUseCase = instance<OfficesUseCase>();
  final OfficeUseCase _officeUseCase = instance<OfficeUseCase>();

  Office? _selectedOffice;

  List<Office>? _offices;

  List<Project>? _projects;

  Future<void> _getOffices() async {
    // remove projects
    _projects = null;

    final officesResponse = await _officesUseCase.execute(GetOfficesRequest());
    if (officesResponse.success) {
      setState(() {
        _offices = officesResponse.data?.data;
      });
    }
  }

  Future<void> _getOffice() async {
    // remove projects
    _projects = null;

    // await office use cases
    debugPrint("_getOffice triggered");

    final officeResponse =
        await _officeUseCase.execute(_selectedOffice?.uuid ?? "");
    if (officeResponse.success) {
      setState(() {
        _projects = officeResponse.data?.data.projects ?? <Project>[];
      });
    } else {
      debugPrint(officeResponse.error);
    }
    // load selected office info
  }

  @override
  void initState() {
    super.initState();

    _getOffices();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: _offices != null
              ? ListView.builder(
                  itemCount: _offices?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final office = _offices![index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: ColorManager.darkGray),
                        ),
                      ),
                      child: ListTile(
                        title: Text(office.acronym),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          setState(() {
                            _selectedOffice = office;
                          });
                          _getOffice();
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No items to show'),
                ),
        ),
        _getProjectsWidget()
      ],
    );
  }

  Widget _getProjectsWidget() {
    return Expanded(
      flex: 3,
      child: _selectedOffice != null
          ? Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.s20),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AssetsManager.svgLogoAsset,
                          height: AppSize.s80,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        SelectableText(
                          _selectedOffice?.name ?? "",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email,
                              color: ColorManager.darkGray,
                            ),
                            Text(_selectedOffice?.email ?? ""),
                            const SizedBox(
                              width: AppSize.s10,
                            ),
                            Icon(
                              Icons.phone,
                              color: ColorManager.darkGray,
                            ),
                            Text(_selectedOffice?.phoneNumber ?? ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  _projects != null
                      ? _getProjectsList()
                      : const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ],
              ),
            )
          : const Center(
              child: Text('No office selected.'),
            ),
    );
  }

  Widget _getProjectsList() {
    final projects = _projects ?? <Project>[];

    return projects.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return ListTile(
                  title: Text(project.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // navigate to project view
                    Navigator.pushNamed(context, Routes.projectRoute,
                        arguments: project.uuid);
                  },
                );
              },
            ),
          )
        : Expanded(
            child: Center(
                child: Lottie.asset(
              AssetsManager.animEmptyJson,
            )),
          );
  }
}

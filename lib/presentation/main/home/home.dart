import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Repository _repository = instance<Repository>();

  List<PovertyIncidence> _data = <PovertyIncidence>[];

  @override
  void initState() {
    super.initState();
    _data = _repository.getPovertyIncidence().toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Expanded(
      child: Center(
        child: SizedBox(
          width: screenSize.width / 2,
          height: screenSize.height / 2,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: 'REGION'),
            ),
            primaryYAxis: CategoryAxis(
              title: AxisTitle(text: 'Poverty Incidence (%)'),
            ),
            title: ChartTitle(
              text: 'Poverty Incidence (%) 2015 and 2018',
            ),
            series: <LineSeries<PovertyIncidence, String>>[
              LineSeries(
                dataSource: _data,
                xValueMapper: (PovertyIncidence sample, _) => sample.region,
                yValueMapper: (PovertyIncidence sample, _) =>
                    sample.incidence2018,
                yAxisName: 'Poverty Incidence (%) 2018',
                xAxisName: 'Region',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries(
                dataSource: _data,
                xValueMapper: (PovertyIncidence sample, _) => sample.region,
                yValueMapper: (PovertyIncidence sample, _) =>
                    sample.incidence2015,
                yAxisName: 'Poverty Incidence (%) 2015',
                xAxisName: 'Region',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
      // child: Text('Item'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Repository _repository = instance<Repository>();

  List<PovertyIncidence> _data = <PovertyIncidence>[];

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _data = _repository.getPovertyIncidence().toList();

    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return _getBarChart();

    return Expanded(
      child: Center(
        child: SizedBox(
          width: screenSize.width / 1,
          height: screenSize.height / 1,
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

  Widget _getBarChart() {
    return Expanded(
      child: Center(
        child: SizedBox(
          height: AppSize.s500,
          width: AppSize.s800,
          child: SfCartesianChart(
            primaryYAxis: NumericAxis(),
            primaryXAxis: CategoryAxis(
              labelRotation: 315,
            ),
            title: ChartTitle(
              text: 'Poverty Incidence (%) 2015 and 2018',
            ),
            tooltipBehavior: _tooltip,
            series: <ColumnSeries<PovertyIncidence, String>>[
              ColumnSeries<PovertyIncidence, String>(
                dataSource: _data,
                xValueMapper: (PovertyIncidence data, _) => data.region,
                yValueMapper: (PovertyIncidence data, _) => data.incidence2015,
                name: '2015',
              ),
              ColumnSeries<PovertyIncidence, String>(
                dataSource: _data,
                xValueMapper: (PovertyIncidence data, _) => data.region,
                yValueMapper: (PovertyIncidence data, _) => data.incidence2018,
                name: '2018',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

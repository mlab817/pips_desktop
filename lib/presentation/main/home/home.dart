import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:realm/realm.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Realm _realm = instance<Realm>();

  Future<RealmResults<PovertyIncidence>> _loadDataFromRealm() async {
    return Future.value(_realm.all<PovertyIncidence>());
  }

  // Future<List<SampleData>> _loadData() async {
  //   final csvString = await rootBundle.loadString('assets/data/home.csv');
  //
  //   final parsedCsv = const CsvToListConverter().convert(
  //     csvString,
  //     fieldDelimiter: ";",
  //     allowInvalid: false,
  //   );
  //
  //   final sampleData = <SampleData>[];
  //
  //   for (var i = 0; i < parsedCsv.length; i++) {
  //     List<dynamic> row = parsedCsv[i];
  //
  //     if (row[0] == 'region') continue;
  //
  //     if (row[0] == 'NCR') continue;
  //
  //     if (row[0] == 'PHILIPPINES') continue;
  //
  //     sampleData.add(SampleData(
  //       region: row[0].toString(),
  //       incidence2015: row[1],
  //       incidence2018: row[2],
  //     ));
  //   }
  //
  //   return Future.value(sampleData);
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadDataFromRealm();
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder<RealmResults<PovertyIncidence>>(
        future: _loadDataFromRealm(),
        builder: (context, snapshot) {
          debugPrint(snapshot.toString());
          if (snapshot.hasData && snapshot.data != null) {
            final List<PovertyIncidence> data =
                snapshot.data?.toList() ?? <PovertyIncidence>[];

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
                        dataSource: data,
                        xValueMapper: (PovertyIncidence sample, _) =>
                            sample.region,
                        yValueMapper: (PovertyIncidence sample, _) =>
                            sample.incidence2018,
                        yAxisName: 'Poverty Incidence (%) 2018',
                        xAxisName: 'Region',
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                      LineSeries(
                        dataSource: data,
                        xValueMapper: (PovertyIncidence sample, _) =>
                            sample.region,
                        yValueMapper: (PovertyIncidence sample, _) =>
                            sample.incidence2015,
                        yAxisName: 'Poverty Incidence (%) 2015',
                        xAxisName: 'Region',
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ),
              // child: Text('Item'),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }
}

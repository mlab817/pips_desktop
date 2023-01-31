import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/schemas/population.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:realm/realm.dart';
import 'package:uuid/uuid.dart' as uuidg;

import '../data/schemas/poverty_incidence.dart';

Future<void> loadDataFromCsv() async {
  final Realm realm = instance<Realm>();
  final Repository repository = instance<Repository>();

  // if database is already loaded, do not run
  // if (await repository.getDatabaseLoaded()) return;

  final csvData = await rootBundle.loadString(
      'assets/data/home.csv'); // File('bin/incidence.csv').readAsString();
  final rows = const CsvToListConverter().convert(csvData, fieldDelimiter: ';');
  final data = rows.map((row) => Map.fromIterables(rows[0], row)).toList();

  const uuidGen = uuidg.Uuid();

  realm.write(() {
    realm.deleteAll<PovertyIncidence>();
  });

  // Iterate through the data and create new instances of the Realm model
  realm.write(() {
    // clear table first
    for (final item in data) {
      if (item['region'] == 'region') continue;

      var uuid = uuidGen.v4();

      try {
        var incidence2015 = item['incidence_2015_est'];
        var incidence2018 = item['incidence_2018_est'];

        var incidence = PovertyIncidence(
          uuid,
          item['region'],
          incidence2015 != '' ? double.parse(incidence2015) : 0.0,
          incidence2018 != '' ? double.parse(incidence2018) : 0.0,
        );

        realm.add(incidence);
      } catch (err) {
        print(err.toString());
      }
    }
  });

  print(realm.all<PovertyIncidence>().length.toString());

  loadPopulationData();
}

void loadPopulationData() async {
  final Realm realm = instance<Realm>();

  final csvData = await rootBundle.loadString(
      'assets/data/population.csv'); // File('bin/incidence.csv').readAsString();
  final rows = const CsvToListConverter().convert(csvData, fieldDelimiter: ';');
  final data = rows.map((row) => Map.fromIterables(rows[0], row)).toList();

  const uuidGen = uuidg.Uuid();

  realm.write(() {
    realm.deleteAll<Population>();
  });

  // Iterate through the data and create new instances of the Realm model
  realm.write(() {
    // clear table first
    for (final item in data) {
      if (item['location'] == 'location') continue;

      var uuid = uuidGen.v4();

      try {
        var incidence = Population(
          uuid,
          item['location'],
          item['scope'],
          item['year'] ?? 0,
          item['value'] ?? 0,
        );

        realm.add(incidence);
      } catch (err) {
        print(err.toString());
      }
    }
  });
}

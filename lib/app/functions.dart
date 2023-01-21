import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:realm/realm.dart';
import 'package:uuid/uuid.dart' as uuidg;

import '../data/schemas/poverty_incidence.dart';

Stream<String> loadDataFromCsv() async* {
  yield 'Loading database...';

  final Realm realm = instance<Realm>();
  final Repository repository = instance<Repository>();

  // if database is already loaded, do not run
  // if (await repository.getDatabaseLoaded()) return;

  final csvData = await rootBundle.loadString(
      'assets/data/home.csv'); // File('bin/incidence.csv').readAsString();
  final rows = const CsvToListConverter().convert(csvData, fieldDelimiter: ';');
  final data = rows.map((row) => Map.fromIterables(rows[0], row)).toList();

  print("${data.length.toString()} items to load");

  const uuidGen = uuidg.Uuid();

  realm.write(() {
    realm.deleteAll<PovertyIncidence>();
  });

  await Future.delayed(const Duration(seconds: 1));

  yield 'Deleted old database';

  // Iterate through the data and create new instances of the Realm model
  realm.write(() {
    // clear table first
    for (final item in data) {
      if (item['region'] == 'region') continue;

      var uuid = uuidGen.v4();

      var incidence = PovertyIncidence(
          uuid,
          item['region'],
          double.parse(item['incidence_2015'] ?? 0),
          double.parse(item['incidence_2018'] ?? 0));

      realm.add(incidence);
    }
  });

  print(realm
      .all<PovertyIncidence>()
      .length
      .toString());

  // await repository.setDatabaseLoaded();

  yield 'Completed database loading';
}

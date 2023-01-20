import 'dart:io';

import 'package:csv/csv.dart';
import 'package:pips/data/schemas/population.dart';
import 'package:realm/realm.dart';

// Open a connection to the Realm database
final Realm realm = Realm(Configuration.local([
  Population.schema,
]));

Future main() async {
  final csvData = await File('path/to/csv/file1.csv').readAsString();
  final rows = const CsvToListConverter().convert(csvData);
  final data = rows.map((row) => Map.fromIterables(rows[0], row)).toList();

  // Iterate through the data and create new instances of the Realm model
  realm.write(() {
    for (final item in data) {
      // realm.create(YourModel.runtimeType, item);
    }
  });
  print("Data is populated successfully!");
}

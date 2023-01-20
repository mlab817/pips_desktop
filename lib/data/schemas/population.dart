import 'package:realm/realm.dart';

part 'population.g.dart';

@RealmModel()
class _Population {
  @PrimaryKey()
  late int year;

  late int value;
}

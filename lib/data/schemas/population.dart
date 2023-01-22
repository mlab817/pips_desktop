import 'package:realm/realm.dart';

part 'population.g.dart';

@RealmModel()
class _Population {
  @PrimaryKey()
  late String uuid;

  late String location;

  late String scope;

  late int year;

  late int value;
}

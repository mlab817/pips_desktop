import 'package:realm/realm.dart';

part 'poverty_incidence.g.dart';

@RealmModel()
class _PovertyIncidence {
  @PrimaryKey()
  late String id;

  late String region;

  late double incidence2015;

  late double incidence2018;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poverty_incidence.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class PovertyIncidence extends _PovertyIncidence
    with RealmEntity, RealmObjectBase, RealmObject {
  PovertyIncidence(
    String id,
    String region,
    double incidence2015,
    double incidence2018,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'region', region);
    RealmObjectBase.set(this, 'incidence2015', incidence2015);
    RealmObjectBase.set(this, 'incidence2018', incidence2018);
  }

  PovertyIncidence._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get region => RealmObjectBase.get<String>(this, 'region') as String;
  @override
  set region(String value) => RealmObjectBase.set(this, 'region', value);

  @override
  double get incidence2015 =>
      RealmObjectBase.get<double>(this, 'incidence2015') as double;
  @override
  set incidence2015(double value) =>
      RealmObjectBase.set(this, 'incidence2015', value);

  @override
  double get incidence2018 =>
      RealmObjectBase.get<double>(this, 'incidence2018') as double;
  @override
  set incidence2018(double value) =>
      RealmObjectBase.set(this, 'incidence2018', value);

  @override
  Stream<RealmObjectChanges<PovertyIncidence>> get changes =>
      RealmObjectBase.getChanges<PovertyIncidence>(this);

  @override
  PovertyIncidence freeze() =>
      RealmObjectBase.freezeObject<PovertyIncidence>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PovertyIncidence._);
    return const SchemaObject(
        ObjectType.realmObject, PovertyIncidence, 'PovertyIncidence', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('region', RealmPropertyType.string),
      SchemaProperty('incidence2015', RealmPropertyType.double),
      SchemaProperty('incidence2018', RealmPropertyType.double),
    ]);
  }
}

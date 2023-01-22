// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'population.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Population extends _Population
    with RealmEntity, RealmObjectBase, RealmObject {
  Population(
    String uuid,
    String location,
    String scope,
    int year,
    int value,
  ) {
    RealmObjectBase.set(this, 'uuid', uuid);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'scope', scope);
    RealmObjectBase.set(this, 'year', year);
    RealmObjectBase.set(this, 'value', value);
  }

  Population._();

  @override
  String get uuid => RealmObjectBase.get<String>(this, 'uuid') as String;
  @override
  set uuid(String value) => RealmObjectBase.set(this, 'uuid', value);

  @override
  String get location =>
      RealmObjectBase.get<String>(this, 'location') as String;
  @override
  set location(String value) => RealmObjectBase.set(this, 'location', value);

  @override
  String get scope => RealmObjectBase.get<String>(this, 'scope') as String;
  @override
  set scope(String value) => RealmObjectBase.set(this, 'scope', value);

  @override
  int get year => RealmObjectBase.get<int>(this, 'year') as int;
  @override
  set year(int value) => RealmObjectBase.set(this, 'year', value);

  @override
  int get value => RealmObjectBase.get<int>(this, 'value') as int;
  @override
  set value(int value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<Population>> get changes =>
      RealmObjectBase.getChanges<Population>(this);

  @override
  Population freeze() => RealmObjectBase.freezeObject<Population>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Population._);
    return const SchemaObject(
        ObjectType.realmObject, Population, 'Population', [
      SchemaProperty('uuid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('location', RealmPropertyType.string),
      SchemaProperty('scope', RealmPropertyType.string),
      SchemaProperty('year', RealmPropertyType.int),
      SchemaProperty('value', RealmPropertyType.int),
    ]);
  }
}

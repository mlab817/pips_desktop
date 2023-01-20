// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'population.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Population extends _Population
    with RealmEntity, RealmObjectBase, RealmObject {
  Population(
    int year,
    int value,
  ) {
    RealmObjectBase.set(this, 'year', year);
    RealmObjectBase.set(this, 'value', value);
  }

  Population._();

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
      SchemaProperty('year', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('value', RealmPropertyType.int),
    ]);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_projects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProjectsRequest _$GetProjectsRequestFromJson(Map<String, dynamic> json) =>
    GetProjectsRequest(
      perPage: json['per_page'] as int? ?? 25,
      page: json['page'] as int? ?? 1,
      q: json['q'] as String?,
      types: (json['types[]'] as List<dynamic>?)?.map((e) => e as int).toList(),
      spatialCoverages: (json['spatial_coverages[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      pip: json['pip'] as bool?,
      cip: json['cip'] as bool?,
      trip: json['trip'] as bool?,
      rdip: json['rdip'] as bool?,
      pdpChapters: (json['pdp_chapters[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      projectStatuses: (json['project_statuses[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      categories: (json['categories[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      pipolStatuses: (json['pipol_statuses[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      pipsStatuses: (json['pips_statuses[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      offices:
          (json['offices[]'] as List<dynamic>?)?.map((e) => e as int).toList(),
      fundingSources: (json['funding_sources[]'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$GetProjectsRequestToJson(GetProjectsRequest instance) {
  final val = <String, dynamic>{
    'per_page': instance.perPage,
    'page': instance.page,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('q', instance.q);
  writeNotNull('types[]', instance.types);
  writeNotNull('spatial_coverages[]', instance.spatialCoverages);
  writeNotNull('pip', instance.pip);
  writeNotNull('cip', instance.cip);
  writeNotNull('trip', instance.trip);
  writeNotNull('rdip', instance.rdip);
  writeNotNull('pdp_chapters[]', instance.pdpChapters);
  writeNotNull('project_statuses[]', instance.projectStatuses);
  writeNotNull('categories[]', instance.categories);
  writeNotNull('pipol_statuses[]', instance.pipolStatuses);
  writeNotNull('pips_statuses[]', instance.pipsStatuses);
  writeNotNull('offices[]', instance.offices);
  writeNotNull('funding_sources[]', instance.fundingSources);
  return val;
}

import 'package:dartz/dartz.dart';
import 'package:pips/common/exceptions/error_handler.dart';
import 'package:pips/data/requests/project/full_project_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/features/project/data/network/api/project_api.dart';

import '../../../../common/exceptions/failure.dart';
import '../../../dashboard/data/network/responses/projects/projects_response.dart';
import '../../create_project/create_project_response.dart';
import '../../domain/models/presets.dart';
import '../../options/options_response.dart';
import '../../project/project_response.dart';

/// CRUD
abstract class ProjectRepository {
  Future<Either<Failure, ProjectsResponse>> getAll(GetProjectsRequest input);

  Future<Either<Failure, ProjectResponse>> get(String uuid);

  Future<Either<Failure, CreateProjectResponse>> create(
      FullProjectRequest input);

// update

// delete
  Future<Either<Failure, StatusResponse>> delete(String uuid);

  Future<Either<Failure, OptionsResponse>> getOptions();

  Future<Either<Failure, PresetsResponse>> presets();
}

class ProjectRepositoryImplementer implements ProjectRepository {
  final ProjectApi _client;

  ProjectRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, ProjectsResponse>> getAll(
      GetProjectsRequest input) async {
    try {
      final ProjectsResponse response = await _client.getProjects(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ProjectResponse>> get(String uuid) async {
    try {
      final ProjectResponse response = await _client.get(uuid);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, CreateProjectResponse>> create(
      FullProjectRequest input) async {
    try {
      final CreateProjectResponse response = await _client.create(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, OptionsResponse>> getOptions() async {
    try {
      final OptionsResponse response = await _client.getOptions();

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> delete(String uuid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PresetsResponse>> presets() async {
    try {
      final PresetsResponse response = await _client.presets();

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}

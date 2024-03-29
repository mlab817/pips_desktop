import 'package:dartz/dartz.dart';
import 'package:pips/common/data/exceptions/error_handler.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/features/project/data/network/api/project_api.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../data/requests/fullproject_request/fullproject_request.dart';
import '../../../dashboard/data/network/responses/projects/projects_response.dart';
import '../../data/network/responses/createproject_response/createproject_response.dart';
import '../../data/network/responses/options_response/options_response.dart';
import '../../data/network/responses/project_response/project_response.dart';
import '../models/presets.dart';

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

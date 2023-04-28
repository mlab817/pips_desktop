import 'package:dartz/dartz.dart';

import '../../../../common/data/exceptions/error_handler.dart';
import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/data/network/app_api.dart';
import '../../../../data/requests/offices/get_offices_request.dart';
import '../../../../data/responses/all_offices/all_offices_response.dart';
import '../../../../data/responses/office_response/office_response.dart';
import '../../../project/data/network/responses/offices_response/offices_response.dart';

// Office Repository
abstract class OfficeRepository {
  // Return all offices
  Future<Either<Failure, AllOfficesResponse>> getAllOffices();

  // Return paginate offices
  Future<Either<Failure, OfficesResponse>> getOffices(GetOfficesRequest input);

  // Return specific office given String uuid
  Future<Either<Failure, OfficeResponse>> getOffice(String input);
}

class OfficeRepositoryImplementer implements OfficeRepository {
  final AppServiceClient _client;

  OfficeRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, AllOfficesResponse>> getAllOffices() async {
    try {
      final AllOfficesResponse response = await _client.getAllOffices();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, OfficesResponse>> getOffices(
      GetOfficesRequest input) async {
    try {
      final OfficesResponse response =
          await _client.getOffices(input.perPage, input.page);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, OfficeResponse>> getOffice(String input) async {
    try {
      final OfficeResponse response = await _client.getOffice(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}

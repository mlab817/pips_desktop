import 'package:pips/data/requests/upload_avatar/upload_avatar_request.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class UploadAvatarUseCase
    extends BaseUseCase<UploadAvatarRequest, Result<UploadAvatarResponse>> {
  final Repository _repository;

  UploadAvatarUseCase(this._repository);

  @override
  Future<Result<UploadAvatarResponse>> execute(
      UploadAvatarRequest input) async {
    return _repository.uploadAvatar(input);
  }
}

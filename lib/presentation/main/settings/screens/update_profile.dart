import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/updateprofile_usecase.dart';
import 'package:pips/domain/usecase/upload_avatar_usecase.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../../app/dep_injection.dart';
import '../../../../data/requests/update_profile/update_profile_request.dart';
import '../../../../domain/models/user.dart';
import '../../../resources/strings_manager.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final Repository _repository = instance<Repository>();

  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();
  final UploadAvatarUseCase _uploadAvatarUseCase =
      instance<UploadAvatarUseCase>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateProfileRequest? _userProfile;

  String? _imageUrl;

  Future<void> _loadUserFromPreferences() async {
    _repository.getLoggedInUser().then((User? value) {
      if (value != null) {
        setState(() {
          _userProfile = UpdateProfileRequest(
              firstName: value.firstName ?? '',
              lastName: value.lastName ?? '',
              position: value.position ?? '',
              contactNumber: value.contactNumber ?? '');
          _imageUrl = value.imageUrl;
        });
      } else {
        setState(() {
          _userProfile = UpdateProfileRequest(
            firstName: '',
            lastName: '',
            position: '',
            contactNumber: '',
          );
        });
      }
    });
  }

  Future<void> _loadImageUrlFromPreferences() async {
    _repository.getImageUrl().then((String? value) {
      if (value != null) {
        setState(() {
          _imageUrl = value;
        });
      } else {
        setState(() {
          _imageUrl = null;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();

    _loadUserFromPreferences();

    _loadImageUrlFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.updateProfile),
      ),
      body: _userProfile != null
          ? SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(AppPadding.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildProfileImage(),
                        const SizedBox(height: AppSize.s10),
                        TextFormField(
                          initialValue: _userProfile?.firstName,
                          decoration: const InputDecoration(
                            labelText: AppStrings.firstName,
                            // prefixIcon: Icon(Icons.abc),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'First name is required.';
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              _userProfile = _userProfile?.copyWith(
                                  firstName: value ?? '');
                            });
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        TextFormField(
                          initialValue: _userProfile?.lastName,
                          decoration: const InputDecoration(
                            labelText: AppStrings.lastName,
                            // prefixIcon: Icon(Icons.abc),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Last name is required.';
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              _userProfile =
                                  _userProfile?.copyWith(lastName: value ?? '');
                            });
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        TextFormField(
                          initialValue: _userProfile?.position,
                          decoration: const InputDecoration(
                            labelText: AppStrings.position,
                            // prefixIcon: Icon(Icons.person_2),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Position is required.';
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              _userProfile =
                                  _userProfile?.copyWith(position: value ?? '');
                            });
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        TextFormField(
                          initialValue: _userProfile?.contactNumber,
                          decoration: const InputDecoration(
                            labelText: AppStrings.contactNo,
                            // prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact number is required.';
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              _userProfile = _userProfile?.copyWith(
                                  contactNumber: value ?? '');
                            });
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        ElevatedButton(
                          onPressed: _submit,
                          child: const Text(AppStrings.submit),
                        ),
                      ],
                    ),
                  )))
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      height: AppSize.s170,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: _imageUrl != null
                  ? Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                      height: AppSize.s150,
                      width: AppSize.s150,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        //
                        if (loadingProgress == null) {
                          return child;
                        }

                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      AssetsManager.defaultAvatar,
                      fit: BoxFit.cover,
                      height: AppSize.s150,
                      width: AppSize.s150,
                    ),
            ),
            Positioned(
              bottom: AppSize.s0,
              right: AppSize.s0,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: _uploadProfile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      return _showSnackbar(AppStrings.pleaseCheckYourInputs);
    }

    final response = await _updateProfileUseCase.execute(_userProfile!);

    if (response.success) {
      User? userModel = await _repository.getLoggedInUser();

      if (userModel != null) {
        userModel = userModel.copyWith(
          firstName: _userProfile!.firstName,
          lastName: _userProfile!.lastName,
          position: _userProfile!.position,
          contactNumber: _userProfile!.contactNumber,
        );

        await _repository.setLoggedInUser(userModel);
      }

      _showSnackbar('Successfully updated user profile.');
    } else {
      _showSnackbar(response.error ?? AppStrings.somethingWentWrong);
    }
  }

  Future<void> _uploadProfile() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });
      }

      // FormData formData = FormData.fromMap({
      //   'avatar': await MultipartFile.fromFile(image.path, filename: fileName)
      // });

      // final response = await _dio.post('/auth/upload-avatar', data: formData);

      final response = await _uploadAvatarUseCase.execute(File(image.path));

      if (response.success) {
        _repository.setImageUrl(response.data?.data ?? '');
        setState(() {
          _imageUrl = response.data?.data;
        });

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        throw Exception(response.error);
      }
    } catch (err) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _popContext() {
    Navigator.pop(context);
  }
}

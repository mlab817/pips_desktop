import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/data/requests/upload_avatar/upload_avatar_request.dart';
import 'package:pips/domain/usecase/updateprofile_usecase.dart';
import 'package:pips/domain/usecase/upload_avatar_usecase.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../app/dep_injection.dart';
import '../../../../domain/models/user.dart';
import '../../../resources/strings_manager.dart';

part 'update_profile.g.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();
  final UploadAvatarUseCase _uploadAvatarUseCase =
      instance<UploadAvatarUseCase>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Image _profilePicture;

  UserProfile? _userProfile;

  String? _imageUrl;

  Future<void> _uploadProfile() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      UploadAvatarRequest input = UploadAvatarRequest(filePath: image.path);

      debugPrint(input.toJson().toString());

      final response = await _uploadAvatarUseCase.execute(input);

      debugPrint(response.data?.request ?? '');
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  Future<void> loadUserFromPreferences() async {
    _appPreferences.getLoggedInUser().then((UserModel? value) {
      if (value != null) {
        setState(() {
          _userProfile = UserProfile(
              firstName: value.firstName ?? '',
              lastName: value.lastName ?? '',
              position: value.position ?? '',
              contactNumber: value.contactNumber ?? '');
          _imageUrl = value.imageUrl;
        });
      } else {
        setState(() {
          _userProfile = UserProfile(
            firstName: '',
            lastName: '',
            position: '',
            contactNumber: '',
          );
        });
      }
    });
  }

  @override
  initState() {
    super.initState();

    loadUserFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
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
                        SizedBox(
                          height: AppSize.s170,
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.md),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  child: _imageUrl != null
                                      ? Image.network(
                                          _imageUrl!,
                                          fit: BoxFit.cover,
                                          height: AppSize.s150,
                                          width: AppSize.s150,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            //
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
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
                                    onPressed: () {
                                      _uploadProfile();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        TextFormField(
                          initialValue: _userProfile?.firstName,
                          decoration: const InputDecoration(
                            labelText: AppStrings.firstName,
                            prefixIcon: Icon(Icons.abc),
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
                            prefixIcon: Icon(Icons.abc),
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
                            prefixIcon: Icon(Icons.person_2),
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
                            prefixIcon: Icon(Icons.phone),
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

  Future<void> _submit() async {
    String message = '';

    if (_formKey.currentState?.validate() ?? false) {
      final response = await _updateProfileUseCase.execute(_userProfile!);

      if (response.success) {
        debugPrint('update successful');
        UserModel? userModel = await _appPreferences.getLoggedInUser();

        if (userModel != null) {
          userModel = userModel.copyWith(
            firstName: _userProfile!.firstName,
            lastName: _userProfile!.lastName,
            position: _userProfile!.position,
            contactNumber: _userProfile!.contactNumber,
          );

          await _appPreferences.setLoggedInUser(userModel);
        }

        message = 'Successfully updated user profile.';
      } else {
        debugPrint('update failed');
      }
    } else {
      message = 'Please review required fields.';
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

@JsonSerializable()
class UserProfile {
  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "position")
  String position;

  @JsonKey(name: "contact_number")
  String contactNumber;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.contactNumber,
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? position,
    String? contactNumber,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

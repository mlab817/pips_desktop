import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/domain/usecase/updateprofile_usecase.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserProfile? _userProfile;

  Future<void> loadUserFromPreferences() async {
    _appPreferences.getLoggedInUser().then((UserModel? value) {
      if (value != null) {
        setState(() {
          _userProfile = UserProfile(
              firstName: value.firstName ?? '',
              lastName: value.lastName ?? '',
              position: value.position ?? '',
              contactNumber: value.contactNumber ?? '');
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
      body: Padding(
          padding: const EdgeInsets.only(top: AppPadding.lg),
          child: _userProfile != null
              ? SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListTile(
                          title: TextFormField(
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
                                _userProfile?.copyWith(firstName: value ?? '');
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        ListTile(
                          title: TextFormField(
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
                                _userProfile?.copyWith(lastName: value ?? '');
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        ListTile(
                          title: TextFormField(
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
                                _userProfile?.copyWith(position: value ?? '');
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        ListTile(
                          title: TextFormField(
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
                                _userProfile?.copyWith(
                                    contactNumber: value ?? '');
                              });
                            },
                          ),
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
                  ),
                )
              : const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(AppStrings.submitted)));
    } else {
      // review inputs
    }
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

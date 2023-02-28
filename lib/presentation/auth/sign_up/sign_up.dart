import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/domain/usecase/signup_usecase.dart';

import '../../resources/sizes_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpUseCase _signUpUseCase = instance<SignUpUseCase>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fileNameController = TextEditingController();

  SignUpRequest _signUpRequest = SignUpRequest(
    officeId: null,
    username: '',
    firstName: '',
    lastName: '',
    position: '',
    email: '',
    contactNumber: '',
    authorizationPath: '',
  );

  PlatformFile? _selectedFile;

  @override
  void dispose() {
    super.dispose();

    _fileNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.s20,
          horizontal: AppSize.s10,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Office is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Office',
                      prefixIcon: Icon(Icons.home_work),
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          autofocus: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First name is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: Icon(Icons.badge),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _signUpRequest = _signUpRequest.copyWith(
                                  firstName: value ?? '');
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s20,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Last name is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                            prefixIcon: Icon(Icons.badge),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _signUpRequest = _signUpRequest.copyWith(
                                  lastName: value ?? '');
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Position is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Position',
                        prefixIcon: Icon(Icons.settings_accessibility)),
                    onChanged: (String? value) {
                      setState(() {
                        _signUpRequest =
                            _signUpRequest.copyWith(position: value ?? '');
                      });
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _signUpRequest =
                            _signUpRequest.copyWith(email: value ?? '');
                      });
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _signUpRequest =
                            _signUpRequest.copyWith(username: value ?? '');
                      });
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact No. is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Contact No.',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _signUpRequest =
                            _signUpRequest.copyWith(lastName: value ?? '');
                      });
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  //
                  Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: _pickFile,
                        child: const Text('Select File'),
                      ),
                      Flexible(
                        child: TextFormField(
                          readOnly: true,
                          controller: _fileNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'File is required.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s40),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signup();
                        }
                      },
                      child: const Text('Sign Up')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    //
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);

    if (result != null) {
      final file = result.files.single;
      // Do something with the selected file

      setState(() {
        _selectedFile = file;
        _fileNameController.text = file.name;
        _signUpRequest =
            _signUpRequest.copyWith(authorizationPath: file.path ?? '');
      });
    }
  }

  void _signup() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sign up!')));

    await _signUpUseCase
        .execute(_signUpRequest)
        .then((value) => debugPrint(value.toString()));
  }
}

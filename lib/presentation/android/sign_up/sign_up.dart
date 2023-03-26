import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/domain/usecase/signup_usecase.dart';
import 'package:pips/presentation/android/sign_up/office_bottomsheet.dart';

import '../../../domain/models/office.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpUseCase _signUpUseCase = instance<SignUpUseCase>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fileNameController = TextEditingController();

  Office? _selectedOffice;

  String? _error;

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
        padding: const EdgeInsets.all(AppPadding.md),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.lg, horizontal: AppPadding.sm),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.home_work),
                      const SizedBox(
                        width: AppSize.s20,
                      ),
                      Text(
                        _selectedOffice != null
                            ? _selectedOffice!.acronym
                            : 'Select Office',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
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
                          _signUpRequest =
                              _signUpRequest.copyWith(firstName: value ?? '');
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
                          _signUpRequest =
                              _signUpRequest.copyWith(lastName: value ?? '');
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
                      decoration:
                          const InputDecoration(hintText: 'Authorization Form'),
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
              SizedBox(
                height: AppSize.s36,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signup();
                      }
                    },
                    child: const Text(AppStrings.signUp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return OfficeBottomSheet(onTap: (Office office) {
            setState(() {
              _signUpRequest = _signUpRequest.copyWith(officeId: office.id);
              _selectedOffice = office;
            });

            Navigator.pop(context);
          });
        });
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
    (await _signUpUseCase.execute(_signUpRequest)).fold((failure) {
      _showSnackbar(failure.message ?? 'Unknown error!');
    }, (response) {
      _showSnackbar('Successfully received your application!');
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

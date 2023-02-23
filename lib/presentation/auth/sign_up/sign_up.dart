import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';

import '../../resources/sizes_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpRequest _signUpRequest = SignUpRequest(
    officeId: null,
    firstName: '',
    lastName: '',
    position: '',
    email: '',
    contactNumber: '',
    endorsement: null,
  );

  PlatformFile? _selectedFile;

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
            child: ListView(
              shrinkWrap: true,
              children: [
                const TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Office',
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'First Name',
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
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
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
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Position',
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _signUpRequest =
                          _signUpRequest.copyWith(position: value ?? '');
                    });
                  },
                ),
                const SizedBox(height: AppSize.s20),
                TextField(
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
                TextField(
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
                GestureDetector(
                  onTap: () {
                    _pickFile();
                  },
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(AppPadding.md),
                    ),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Select File'),
                      ),
                      Text(_selectedFile?.name ?? '')
                    ]),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
              ],
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
        _signUpRequest = _signUpRequest.copyWith(endorsement: file);
      });
    }
  }
}

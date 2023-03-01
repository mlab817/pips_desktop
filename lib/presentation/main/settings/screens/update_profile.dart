import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _contactNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !UniversalPlatform.isDesktopOrWeb
          ? AppBar(
              title: const Text('Update Profile'),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.lg),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('First Name: ')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('Last Name: ')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('Username')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('Position')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    labelText: 'Position',
                    prefixIcon: Icon(Icons.person_2),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('Email: ')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ListTile(
                leading: UniversalPlatform.isDesktopOrWeb
                    ? const Text('Contact No.: ')
                    : null,
                minLeadingWidth: AppSize.s150,
                title: TextFormField(
                  controller: _contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Submitted')));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

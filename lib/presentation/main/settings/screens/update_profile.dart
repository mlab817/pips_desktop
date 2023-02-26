import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

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
    return Column(
      children: [
        AppBar(
          title: const Text('Update Profile'),
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.lg),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Text('First Name: '),
                  minLeadingWidth: AppSize.s150,
                  title: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.abc),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ListTile(
                  leading: const Text('Last Name: '),
                  minLeadingWidth: AppSize.s150,
                  title: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.abc),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ListTile(
                  leading: const Text('Username'),
                  minLeadingWidth: AppSize.s150,
                  title: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ListTile(
                  leading: const Text('Position'),
                  minLeadingWidth: AppSize.s150,
                  title: TextField(
                    controller: _positionController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ListTile(
                  leading: const Text('Email: '),
                  minLeadingWidth: AppSize.s150,
                  title: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ListTile(
                  leading: const Text('Contact No.: '),
                  minLeadingWidth: AppSize.s150,
                  title: TextFormField(
                    controller: _contactNumberController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitted')));
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/color_manager.dart';
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
            padding: const EdgeInsets.all(AppPadding.md),
            child: ListView(
              shrinkWrap: true,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.abc),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.abc),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _positionController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Flexible(
                      child: TextField(
                        controller: _positionController,
                        decoration: const InputDecoration(
                          hintText: 'Position',
                          prefixIcon: Icon(Icons.person_2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Flex(direction: Axis.horizontal, children: [
                  Flexible(
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.s12,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _contactNumberController,
                      decoration: const InputDecoration(
                        hintText: 'Phone No.',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: AppSize.s36,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Submitted')));
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pips/data/responses/all_users/all_users.dart';

import '../../../../../app/dep_injection.dart';
import '../../../../common/resources/sizes_manager.dart';
import '../../../../common/resources/strings_manager.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/routing.dart';
import '../../domain/usecase/allusers_usecase.dart';

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet>
    with AutomaticKeepAliveClientMixin {
  final AllUsersUseCase _allUsersUseCase = instance<AllUsersUseCase>();

  final TextEditingController _filterController = TextEditingController();

  List<UserQuickResource>? _users;

  List<UserQuickResource> _filteredUsers = [];

  String? _error;

  bool? _loading;

  Future<void> _getUsers() async {
    (await _allUsersUseCase.execute(Void())).fold((failure) {
      _error = failure.message;
    }, (response) {
      setState(() {
        _users = response.data;
        _filteredUsers = _users ?? [];
        _loading = false;
      });
    });
  }

  void _filterUsers() {
    final value = _filterController.text;

    if (value.isEmpty) {
      setState(() {
        _filteredUsers = _users ?? [];
      });
    } else {
      setState(() {
        _filteredUsers = _users?.where((element) {
              return element.name.toLowerCase().contains(value.toLowerCase());
            }).toList() ??
            [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getUsers();

    _filterController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    super.dispose();

    _filterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leadingWidth: AppSize.s80,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.cancel),
          ),
          title: Text(
            'New message',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          centerTitle: true,
        ),
        _getSearch(),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(
            'Suggested',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _users != null
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.md),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.chatRoomRoute,
                              arguments: _users![index]);
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://robohash.org/${_filteredUsers[index].name}.png?set=set5"),
                        ),
                        title: Text(_filteredUsers[index].name),
                      );
                    },
                  ),
                ),
              )
            : const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _getSearch() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.md),
      child: TextField(
        autofocus: true,
        controller: _filterController,
        decoration: const InputDecoration(
          prefixText: 'To: ',
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

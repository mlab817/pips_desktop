import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/pagination/pagination_response.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../domain/models/user.dart';
import '../../resources/color_manager.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final UsersUseCase _usersUseCase = instance<UsersUseCase>();

  final TextEditingController _contentController = TextEditingController();

  late ScrollController _scrollController;

  final List<Message> _messages = <Message>[];

  final List<UserModel> _users = <UserModel>[];

  UserModel? _currentUser;

  late PaginationResponse _paginationResponse;

  int _page = 1;

  bool _loading = false;

  Future<void> _getUsers() async {
    final usersReponse =
        await _usersUseCase.execute(GetUsersRequest(perPage: 25, page: _page));

    if (usersReponse.success) {
      setState(() {
        _users.addAll(usersReponse.data?.data as List<UserModel>);
        _paginationResponse = usersReponse.data!.meta.pagination;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getUsers();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();

    _contentController.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      //
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger &&
          _loading == false) {
        // if page is greater than last item in pagination
        // do not request for next page
        if (_page > _paginationResponse.last) return;

        setState(() {
          _loading = true;
        });

        // _viewModel.getNextPage();
        _getNextUsersPage();

        Future<void>.delayed(const Duration(seconds: 1)).then((_) => {
              setState(() {
                _loading = false;
              })
            });
      }
    });

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: ColorManager.darkGray,
                ),
              ),
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
                  child: ListTile(
                    key: Key(index.toString()),
                    hoverColor: ColorManager.lightGray,
                    leading: Icon(
                      Icons.person,
                      color: ColorManager.darkGray,
                    ),
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(user.email),
                    trailing: Icon(
                      Icons.circle_rounded,
                      size: AppSize.s10,
                      color: ColorManager.primary,
                    ),
                    onTap: () {
                      // tapped user handler
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Container(
                height: AppSize.s60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                ),
                child: const Text('User Info'),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      // change alignment if user is sender or not
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: AppSize.s10, top: AppSize.s10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(AppSize.s50),
                            ),
                            // width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: AppSize.s400,
                              // minWidth: AppSize.s100,
                            ),
                            padding: const EdgeInsets.all(AppSize.s10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _messages[index].content,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            hintText: 'Type your message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSize.s10),
                      TextButton(
                        onPressed: () {
                          if (_contentController.text.isEmpty) return;
                          // send message code
                          setState(() {
                            _messages.add(Message(
                                senderId: 'randomId',
                                content: _contentController.text));
                          });

                          _contentController.clear();
                        },
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _getNextUsersPage() async {
    _page++;

    _getUsers();
  }

  void _setUser(UserModel user) {
    setState(() {
      _currentUser = user;
    });
  }
}

class Message {
  String senderId;

  String content;

  Message({
    required this.senderId,
    required this.content,
  });
}

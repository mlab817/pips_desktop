import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/pagination/pagination_response.dart';
import 'package:pips/domain/models/chat_room.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';
import 'package:pips/domain/usecase/createchatroom_usecase.dart';
import 'package:pips/domain/usecase/createmessage_usecase.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../domain/models/message.dart';
import '../../../domain/models/user.dart';
import '../../resources/color_manager.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final UsersUseCase _usersUseCase = instance<UsersUseCase>();
  final ChatRoomsUseCase _chatRoomsUseCase = instance<ChatRoomsUseCase>();
  final CreateChatRoomUseCase _createChatRoomUseCase =
      instance<CreateChatRoomUseCase>();

  final CreateMessageUseCase _createMessageUseCase =
      instance<CreateMessageUseCase>();

  final TextEditingController _contentController = TextEditingController();

  late ScrollController _scrollController;

  final List<Message> _messages = <Message>[];

  final List<UserModel> _users = <UserModel>[];

  final List<ChatRoom> _chatRooms = <ChatRoom>[];

  UserModel? _currentUser;

  ChatRoom? _chatRoom; // selected chatRoom

  late PaginationResponse _paginationResponse;

  int _page = 1;

  bool _loading = false;

  Future<void> _getUsers() async {
    final usersResponse =
        await _usersUseCase.execute(GetUsersRequest(perPage: 25, page: _page));

    if (usersResponse.success) {
      setState(() {
        _users.addAll(usersResponse.data?.data as List<UserModel>);
        _paginationResponse = usersResponse.data!.meta.pagination;
      });
    }
  }

  Future<void> _getChatRooms() async {
    final chatRoomsResponse = await _chatRoomsUseCase.execute(Void());

    if (chatRoomsResponse.success) {
      setState(() {
        _chatRooms.addAll(chatRoomsResponse.data?.data as List<ChatRoom>);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getUsers();

    _getChatRooms();

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
            child: Column(
              children: [
                AppBar(
                  title: const Text('Chats'),
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        _setChatRoom(null);
                      },
                      icon: const Icon(
                        Icons.add_comment_outlined,
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s4,
                    )
                  ],
                  elevation: AppSize.s4,
                ),
                Expanded(
                  child: _chatRooms.isNotEmpty
                      ? ListView.builder(
                          itemCount: _chatRooms.length,
                          itemBuilder: (context, index) {
                            //
                            final chatRoom = _chatRooms[index];

                            String chatName = chatRoom.users
                                    ?.map((item) => item.firstName)
                                    .toList()
                                    .join(', ') ??
                                "No name.";

                            return ListTile(
                              title: Text(chatName),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                _setChatRoom(chatRoom);
                              },
                              dense: false,
                            );
                          },
                        )
                      : const Center(
                          child: Text('No rooms.'),
                        ),
                ),
              ],
            ),
          ),
        ),
        _getMessagePanel(),
      ],
    );
  }

  // create left panel for messages
  Widget _getMessagePanel() {
    return Expanded(
      flex: 3,
      child: _chatRoom == null
          ? _getNewChatRoom()
          : Column(
              children: <Widget>[
                _getChatBar(),
                _getChatMessages(),
                _getChatBox(),
              ],
            ),
    );
  }

  // get chat bar
  Widget _getChatBar() {
    String chatName =
        _chatRoom?.users?.map((item) => item.firstName).toList().join(', ') ??
            "No name.";

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(chatName),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () {
              // do nothing
              debugPrint('do nothing');
            },
            icon: const Icon(Icons.info))
      ],
    );
  }

  Widget _getChatMessages() {
    List<Message> messages = _chatRoom?.messages ?? [];

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            // TODO: change alignment if user is sender or not
            return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: AppSize.s0, top: AppSize.s0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s50),
                  ),
                  // width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: AppSize.s200,
                    // minWidth: AppSize.s100,
                    maxHeight: AppSize.s200,
                  ),
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSize.s8),
                        child: Text(
                          _messages[index].content,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        messages[index].createdAt.toIso8601String(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getNewChatRoom() {
    return Column(
      children: [
        Container(
          height: AppSize.s60,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: AppSize.s0_5,
                color: ColorManager.darkGray,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: AppSize.s20,
                ),
                const Text('To: '),
                const SizedBox(
                  width: AppSize.s20,
                ),
                Expanded(
                  child: Autocomplete<UserModel>(
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isCollapsed: true,
                        ),
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<UserModel>.empty();
                      }
                      return _users.where((UserModel userModel) {
                        return userModel.firstName?.toLowerCase().startsWith(
                                textEditingValue.text.toLowerCase()) ??
                            false;
                      });
                    },
                    optionsViewBuilder: (
                      BuildContext context,
                      AutocompleteOnSelected<UserModel> onSelected,
                      Iterable<UserModel> options,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.only(top: AppSize.s8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: ColorManager.darkGray,
                                ),
                                borderRadius: BorderRadius.circular(AppSize.s8),
                              ),
                              width: 300,
                              height: 400,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(AppSize.s0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final UserModel userModel =
                                      options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      _setUser(userModel);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        "${userModel.firstName} ${userModel.lastName}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    onSelected: (UserModel userModel) {
                      _setUser(userModel);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getChatBox() {
    return Container(
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
                  hintText: 'Type your message and enter to send',
                  border: InputBorder.none,
                ),
                onSubmitted: _sendMessage,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            TextButton(
              onPressed: () {
                if (_contentController.text.isEmpty) return;

                _sendMessage(_contentController.text);

                _contentController.clear();
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getNextUsersPage() async {
    _page++;

    _getUsers();
  }

  Future<void> _setUser(UserModel user) async {
    setState(() {
      _currentUser = user;
    });

    setState(() {
      _loading = true;
    });

    final createChatRoomResponse =
        await _createChatRoomUseCase.execute(user.id);

    if (createChatRoomResponse.success) {
      debugPrint(createChatRoomResponse.data?.name.toString());
      _setChatRoom(createChatRoomResponse.data as ChatRoom);
      setState(() {
        _chatRooms.add(createChatRoomResponse.data as ChatRoom);
      });
    }

    setState(() {
      _loading = false;
    });
  }

  void _setChatRoom(chatRoom) {
    setState(() {
      _chatRoom = chatRoom;
    });
  }

  Future<void> _sendMessage(value) async {
    if (value.isEmpty) {
      debugPrint('no message');
    }

    final createMessageResponse = await _createMessageUseCase
        .execute(CreateMessageUseCaseInput(id: _chatRoom!.id, content: value));

    if (createMessageResponse.success) {
      debugPrint('Successfully sent message');
    }

    _contentController.clear();
  }
}

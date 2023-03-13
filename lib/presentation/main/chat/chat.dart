import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/pagination/pagination_response.dart';
import 'package:pips/domain/models/chat_room.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';
import 'package:pips/domain/usecase/createchatroom_usecase.dart';
import 'package:pips/domain/usecase/users_usecase.dart';
import 'package:pips/presentation/main/chat/conversation/conversation.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../../data/responses/chat_rooms/chat_rooms.dart';
import '../../../domain/models/user.dart';
import '../../../domain/usecase/base_usecase.dart';
import '../../resources/color_manager.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final UsersUseCase _usersUseCase = instance<UsersUseCase>();
  final ChatRoomsUseCase _chatRoomsUseCase = instance<ChatRoomsUseCase>();
  final CreateChatRoomUseCase _createChatRoomUseCase =
      instance<CreateChatRoomUseCase>();

  final Repository _repository = instance<Repository>();

  final PusherChannelsClient _client = instance<PusherChannelsClient>();

  late ScrollController _scrollController;

  final List<UserModel> _users = <UserModel>[];

  final List<ChatRoom> _chatRooms = <ChatRoom>[];

  ChatRoom? _chatRoom; // selected chatRoom

  late PaginationResponse _paginationResponse;

  int _page = 1;

  bool _loading = false;

  Future<void> _getUsers() async {
    final usersResponse =
        await _usersUseCase.execute(GetUsersRequest(perPage: 25, page: _page));

    if (!mounted) return;

    if (usersResponse.success) {
      setState(() {
        _users.addAll(usersResponse.data?.data as List<UserModel>);
        _paginationResponse = usersResponse.data!.meta.pagination;
      });
    }
  }

  Future<void> _getChatRooms() async {
    final Result<ChatRoomsResponse> chatRoomsResponse =
        await _chatRoomsUseCase.execute(Void());

    if (!mounted) return;

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

        if (!mounted) return;

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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.chat),
        actions: [
          IconButton(
            onPressed: () {
              // open bottom sheet
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _buildBottomSheet(context);
                  });
            },
            icon: const Icon(Icons.add_comment),
          ),
        ],
      ),
      body: const Center(
        child: Text('Coming Soon!'),
      ),
    );
  }

  // create left panel for messages
  Widget _getMessagePanel() {
    return Expanded(
      flex: 3,
      child: _chatRoom == null
          ? _getNewChatRoom()
          : ConversationView(
              chatRoomId: _chatRoom!.id,
            ),
    );
  }

  // get chat bar

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
            padding: const EdgeInsets.all(AppSize.s20),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'To: ',
                  style: TextStyle(fontSize: AppSize.s14),
                ),
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
                        ),
                      );
                    },
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == AppStrings.empty) {
                        return const Iterable<UserModel>.empty();
                      }
                      return _users.where((UserModel userModel) {
                        return userModel.firstName
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
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
                                // color: Colors.white,
                                border: Border.all(
                                  color: ColorManager.darkGray,
                                ),
                                borderRadius: BorderRadius.circular(AppSize.s8),
                              ),
                              width: AppSize.s300,
                              height: AppSize.s400,
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

  Future<void> _getNextUsersPage() async {
    _page++;

    _getUsers();
  }

  Future<void> _setUser(UserModel user) async {
    _createChatRoomUseCase.execute(user.id).then((createChatRoomResponse) => {
          if (createChatRoomResponse.success)
            {
              debugPrint(createChatRoomResponse.data?.name.toString()),
              _setChatRoom(createChatRoomResponse.data as ChatRoom),
              setState(() {
                _chatRooms.add(createChatRoomResponse.data as ChatRoom);
                _loading = false;
              }),
            }
        });
  }

  Widget _buildBottomSheet(BuildContext context) {
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
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              prefixText: 'To: ',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.md),
          child: Text(
            'Suggested',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    // TODO: new chat
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://robohash.org/${_users[index].email}.png?set=set5"),
                  ),
                  title: Text(
                      "${_users[index].firstName} ${_users[index].lastName}"),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _setChatRoom(chatRoom) {
    setState(() {
      _chatRoom = chatRoom;
    });
  }
}

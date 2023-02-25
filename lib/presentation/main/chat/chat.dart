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
                    CircleAvatar(
                      backgroundColor: ColorManager.darkWhite,
                      child: IconButton(
                        onPressed: () {
                          _setChatRoom(null);
                        },
                        icon: const Icon(
                          Icons.mode,
                          size: AppSize.s20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s4,
                    )
                  ],
                ),
                Expanded(
                  child: _chatRooms.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(AppSize.s8),
                          child: ListView.builder(
                              itemCount: _chatRooms.length,
                              itemBuilder: (context, index) {
                                //
                                final chatRoom = _chatRooms[index];

                                String chatName = chatRoom.users
                                        ?.map((item) => item.firstName)
                                        .toList()
                                        .join(', ') ??
                                    "No name.";

                                return InkWell(
                                  onTap: () {
                                    _setChatRoom(chatRoom);
                                  },
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  child: Container(
                                    padding: const EdgeInsets.all(AppSize.s8),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8),
                                      // add background color if the item is selected
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            ColorManager.white,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        ColorManager.blue,
                                                    radius: 18.0,
                                                    child: const Text(
                                                      '2',
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: ColorManager.white,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    radius: 18.0,
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: AppSize.s10),
                                        Expanded(child: Text(chatName)),
                                        const Icon(Icons.chevron_right),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
                                // color: Colors.white,
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

  void _setChatRoom(chatRoom) {
    setState(() {
      _chatRoom = chatRoom;
    });
  }
}

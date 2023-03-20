import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/data/network/ws.dart';
import 'package:pips/domain/models/chat_room.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/usecase/chatroom_usecase.dart';

import '../../app/dep_injection.dart';
import '../../domain/models/message.dart';
import '../../domain/repository/repository.dart';
import '../../domain/usecase/createmessage_usecase.dart';
import '../resources/color_manager.dart';
import '../resources/sizes_manager.dart';
import '../resources/strings_manager.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({Key? key, required this.user}) : super(key: key);

  final dynamic user;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final ChatRoomUseCase _chatRoomUseCase = instance<ChatRoomUseCase>();
  final CreateMessageUseCase _createMessageUseCase =
      instance<CreateMessageUseCase>();
  final PusherChannelsClient _client = instance<PusherChannelsClient>();
  final Repository _repository = instance<Repository>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  StreamSubscription<ChannelReadEvent>? _streamSubscription;

  ChatRoom? _chatRoom;
  List<Message>? _messages = [];
  String? _error;

  UserModel? _currentUser;

  Future<void> _loadChatRoom() async {
    final chatRoomId = widget.user.id;

    final response = await _chatRoomUseCase.execute(chatRoomId);

    if (response.success) {
      setState(() {
        _chatRoom = response.data?.data;
        _messages = response.data?.data.messages;
      });

      await _connectToClient();
    } else {
      setState(() {
        _error = response.error;
      });
    }
  }

  Future<void> _connectToClient() async {
    debugPrint("connecting to client");

    final bearerToken = await _repository.getBearerToken();

    if (_chatRoom != null) {
      final privateChannel = 'private-chat-room.${_chatRoom?.id}';

      PrivateChannel channel = _client.privateChannel(
        privateChannel,
        authorizationDelegate:
            EndpointAuthorizableChannelTokenAuthorizationDelegate
                .forPrivateChannel(
          authorizationEndpoint: PusherWebsocketClient.authEndPoint,
          headers: {
            "Authorization": "Bearer $bearerToken",
          },
        ),
      );

      channel.subscribeIfNotUnsubscribed();

      _streamSubscription = channel.bindToAll().listen((event) {
        debugPrint(event.toString());
      });

      _streamSubscription?.onData((data) {
        print(data.data.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _appPreferences.getLoggedInUser().then((value) => _currentUser = value);

    _loadChatRoom();

    _connectToClient();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _scrollController.dispose();
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: (user != null && user is UserModel)
            ? Text("${user.firstName} ${user.lastName}")
            : Text(user.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          _getChatMessages(),
          _getChatBox(),
        ],
      ),
    );
  }

  Widget _getChatMessages() {
    final currentUserId = _currentUser != null ? _currentUser!.id : null;

    if (_messages != null) {
      if (_messages?.isEmpty ?? false) {
        return const Expanded(
          child: Center(
            child: Text('Send a message to start the chat'),
          ),
        );
      }

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount:
                  _messages?.length, // snapshot.data?.data?.data.length ?? 0,
              itemBuilder: (context, index) {
                final message =
                    _messages![index]; // snapshot.data?.data?.data[index];

                return message.senderId == currentUserId
                    ? _buildRight(message)
                    : _buildLeft(message);
              },
            ),
          ),
        ),
      );
    }
    return const Expanded(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }

  // sent by others
  Widget _buildLeft(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.sm,
          vertical: AppSize.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage("https://robohash.org/${message.senderId}.png"),
            ),
            const SizedBox(
              width: AppSize.sm,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.gray,
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              // width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: AppSize.s600,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.s8,
                horizontal: AppSize.s10,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.s0),
                child: Text(
                  message.content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // sent by user
  Widget _buildRight(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.sm,
          vertical: AppSize.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.blue,
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              // width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: AppSize.s600,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: AppSize.s8, horizontal: AppSize.s10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.s0),
                child: Text(
                  message.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.sm,
            ),
            (message.sent ?? false)
                ? Icon(
                    Icons.check_circle_rounded,
                    size: AppSize.s14,
                    color: ColorManager.gray,
                  )
                : Icon(
                    Icons.circle_outlined,
                    size: AppSize.s14,
                    color: ColorManager.gray,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _getChatBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _contentController,
                onSubmitted: _sendMessage,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: AppStrings.typeMessageAndPressEnter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String message) async {
    if (message.isEmpty) {
      return;
    }

    // generate a localId
    final localId = DateTime.now().millisecondsSinceEpoch;

    final localMessage = Message(
      id: localId,
      content: _contentController.text,
      chatRoomId: _chatRoom!.id,
      senderId: _currentUser!.id,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      localId: localId,
      sent: false,
    );

    // add a temporary record
    setState(() {
      _messages?.add(localMessage);
    });

    final createMessageResponse = await _createMessageUseCase.execute(
        CreateMessageUseCaseInput(id: _chatRoom!.id, content: message));

    // replace the local message
    if (createMessageResponse.success) {
      // get index
      final index =
          _messages?.indexWhere((element) => element.localId == localId);

      if (index != null) {
        setState(() {
          // _messages?.add(createMessageResponse.data as Message);
          _messages![index] = localMessage.copyWith(sent: true);
        });
      } else {}
    }

    _contentController.clear();
    _focusNode.requestFocus();
  }
}

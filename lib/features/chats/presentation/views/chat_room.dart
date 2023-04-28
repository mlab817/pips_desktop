import 'dart:async';
import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:pips/common/data/network/ws.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:pips/features/authentication/domain/models/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/dep_injection.dart';
import '../../../../common/domain/repository/repository.dart';
import '../../../../common/resources/color_manager.dart';
import '../../domain/models/chat_room/chat_room.dart';
import '../../domain/models/message/message.dart';
import '../../domain/usecase/chatroom_usecase.dart';
import '../../domain/usecase/createmessage_usecase.dart';

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

  final TextEditingController _contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  StreamSubscription<ChannelReadEvent>? _streamSubscription;

  ChatRoom? _chatRoom;
  List<Message>? _messages = [];
  String? _error;
  bool _loading = true;

  bool _isTyping = false;

  PrivateChannel? _privateChannel;

  User? _currentUser;

  Timer? _typingTimer;

  void _setIsTyping(bool value) {
    setState(() {
      _isTyping = value;
    });

    if (_typingTimer != null) {
      _typingTimer!.cancel();
    }

    if (_isTyping) {
      _typingTimer = Timer(const Duration(seconds: 1), () {
        _setIsTyping(false);
      });
    }
  }

  Future<void> _loadChatRoom() async {
    final chatRoomId = widget.user.id;

    (await _chatRoomUseCase.execute(chatRoomId)).fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _chatRoom = response.data;
        _messages = response.data.messages?.cast<Message>();
        _loading = false;
      });

      _scrollToBottom();

      //
      _connectToClient();
    });
  }

  Future<void> _connectToClient() async {
    final bearerToken = await _repository.getBearerToken();

    if (_chatRoom != null) {
      final privateChannel = 'private-chat-room.${_chatRoom?.id}';

      _privateChannel = _client.privateChannel(
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

      _privateChannel?.subscribeIfNotUnsubscribed();

      _streamSubscription = _privateChannel?.bindToAll().listen((event) {
        //
      });

      _streamSubscription?.onData((ChannelReadEvent event) {
        if (event.name == 'message.created') {
          var decodedMessage = jsonDecode(event.data);
          final message = Message.fromJson(decodedMessage['message']);

          // if the message has been sent by the same user, then do not add
          if (message.senderId == _currentUser?.id) {
            return;
          }

          setState(() {
            _messages?.add(message);
          });
        }

        if (event.name == 'client-chat') {
          _setIsTyping(true);
        }
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _repository.getLoggedInUser().then((value) => _currentUser = value);

    _loadChatRoom();

    _connectToClient();

    _contentController.addListener(() {
      // listener for trigger
      _privateChannel
          ?.trigger(eventName: 'client-chat', data: {'typing': true});
    });

    if (_scrollController.positions.isNotEmpty) {
      // jump to end
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
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
        title: (user != null && user is User)
            ? Text("${user.firstName} ${user.lastName}")
            : Text(user.name),
        actions: [
          IconButton(
            onPressed: () {
              _showUserProfile(user);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          _loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : _getChatMessages(),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(AppPadding.md),
              child: Text(
                'User is typing...',
              ),
            ),
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
              // reverse: true,
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
                color: Theme.of(context).primaryColor,
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

    _contentController.clear();
    _focusNode.requestFocus();

    (await _createMessageUseCase.execute(
            CreateMessageUseCaseInput(id: _chatRoom!.id, content: message)))
        .fold((l) => null, (r) {
      final index =
          _messages?.indexWhere((element) => element.localId == localId);

      if (index != null) {
        setState(() {
          // _messages?.add(createMessageResponse.data as Message);
          _messages![index] = localMessage.copyWith(sent: true);
        });
      }
    });
  }

  void _showUserProfile(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.account_circle,
            size: AppSize.s36,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.fullname ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(user.office?.acronym ?? ''),
              Text(user.position ?? ''),
              ListTile(
                dense: true,
                leading: const Icon(Icons.email),
                title: Text(user.email),
                onTap: () async {
                  await _launchUrl(Uri.parse("mailto:${user.email}"));
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(Icons.phone),
                title: Text(user.contactNumber ?? ''),
                onTap: () async {
                  await _launchUrl(Uri.parse("tel:${user.contactNumber}"));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

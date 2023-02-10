import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/messages_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../../app/config.dart';
import '../../../../app/dep_injection.dart';
import '../../../../domain/models/chat_room.dart';
import '../../../../domain/models/message.dart';
import '../../../../domain/usecase/createmessage_usecase.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({Key? key, required this.chatRoomId})
      : super(key: key);

  final int chatRoomId;

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  final MessagesUseCase _messagesUseCase = instance<MessagesUseCase>();
  final CreateMessageUseCase _createMessageUseCase =
      instance<CreateMessageUseCase>();
  final Repository _repository = instance<Repository>();
  final PusherChannelsClient _client = instance<PusherChannelsClient>();
  final ScrollController _scrollController = ScrollController();

  late Channel _channel;

  ChatRoom? _chatRoom;

  final List<Message> _messages = [];

  final TextEditingController _contentController = TextEditingController();

  Future<Result<MessagesResponse>> _loadMessages() async {
    return _messagesUseCase.execute(widget.chatRoomId);
  }

  void _loadMessagesToState() async {
    debugPrint("did i get triggered?");

    _messages.clear();

    final Result<MessagesResponse> response = await _loadMessages();

    if (response.success) {
      debugPrint("messagesResponse: ${response.data.toString()}");
      setState(() {
        _messages.addAll(response.data?.data ?? [] as List<Message>);
      });
    }
  }

  Future<void> _subscribeToChatroomChannel() async {
    String token = await _repository.getBearerToken();

    debugPrint("token $token");

    String channelName = 'private-chat-room.${widget.chatRoomId.toString()}';

    // define a new channel
    _channel = _client.privateChannel(
      channelName,
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPrivateChannel(
        authorizationEndpoint: Uri.parse(Config.authEndpoint),
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    _channel.subscribeIfNotUnsubscribed();

    _channel.bindToAll().listen((ChannelReadEvent event) {
      //
      if (event.data != null) {
        var messageResponse = MessageResponse.fromJson(jsonDecode(event.data));

        setState(() {
          _messages.add(messageResponse.message);
        });

        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void didUpdateWidget(ConversationView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.chatRoomId != oldWidget.chatRoomId) {
      _loadMessagesToState();
      _subscribeToChatroomChannel();
    }
  }

  @override
  void initState() {
    super.initState();

    _loadMessagesToState();

    _subscribeToChatroomChannel();
  }

  @override
  void dispose() {
    super.dispose();

    _contentController.dispose();

    _messages.clear();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _getChatBar(),
        _getChatMessages(),
        _getChatBox(),
      ],
    );
  }

  Widget _getChatBar() {
    // String chatName =
    //     _chatRoom?.users?.map((item) => item.firstName).toList().join(', ') ??
    //         "No name.";

    String chatName = "Chat Room ${widget.chatRoomId}";

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
          icon: const Icon(Icons.info),
        ),
      ],
    );
  }

  Widget _getChatMessages() {
    debugPrint(_messages.length.toString());

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: _messages
                      .length, // snapshot.data?.data?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final message =
                        _messages[index]; // snapshot.data?.data?.data[index];

                    return Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSize.s4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColorManager.blue,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20),
                              ),
                              // width: double.infinity,
                              constraints: const BoxConstraints(
                                maxWidth: AppSize.s600,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSize.s8,
                                  horizontal: AppSize.s10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppSize.s0),
                                child: Text(
                                  message.content,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSize.s2),
                            Text(
                              message.createdAt,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: AppSize.s10),
                          ],
                        ),
                      ),
                    );
                  },
                ))));
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
        padding: const EdgeInsets.all(AppPadding.md),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _contentController,
                onSubmitted: _sendMessage,
                decoration: InputDecoration(
                  hintText: AppStrings.typeMessageAndPressEnter,
                  fillColor: ColorManager.lightGray,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
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

  Future<void> _sendMessage(value) async {
    if (value.isEmpty || value.length < 4) {
      debugPrint('no message');
      // TODO: inform user that message is too short
      return;
    }

    final createMessageResponse = await _createMessageUseCase.execute(
        CreateMessageUseCaseInput(id: widget.chatRoomId, content: value));

    if (createMessageResponse.success && createMessageResponse.data != null) {
      debugPrint('Successfully sent message');
      setState(() {
        // _chatRoom?.messages?.add(createMessageResponse.data as Message);
      });
    }

    _contentController.clear();
  }
}

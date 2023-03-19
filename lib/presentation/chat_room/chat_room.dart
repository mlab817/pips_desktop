import 'package:flutter/material.dart';
import 'package:pips/domain/models/chat_room.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/usecase/chatroom_usecase.dart';

import '../../app/dep_injection.dart';
import '../../domain/models/message.dart';
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

  final TextEditingController _contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  ChatRoom? _chatRoom;
  List<Message>? _messages = [];
  String? _error;

  Future<void> _loadChatRoom() async {
    final chatRoomId = widget.user.id;

    final response = await _chatRoomUseCase.execute(chatRoomId);

    if (response.success) {
      setState(() {
        _chatRoom = response.data?.data;
        _messages = response.data?.data.messages;
      });
    } else {
      setState(() {
        _error = response.error;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadChatRoom();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _scrollController.dispose();

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
                    itemCount: _messages
                        ?.length, // snapshot.data?.data?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = _messages![
                          index]; // snapshot.data?.data?.data[index];

                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.sm,
                            vertical: AppSize.sm,
                          ),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ))));
    }
    return const Expanded(
        child: Center(
      child: CircularProgressIndicator(),
    ));
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
                decoration: const InputDecoration(
                  hintText: AppStrings.typeMessageAndPressEnter,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s10),
            IconButton(
              onPressed: () {
                if (_contentController.text.isEmpty) return;

                _sendMessage(_contentController.text);

                _contentController.clear();
              },
              icon: const Icon(Icons.send),
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

    final createMessageResponse = await _createMessageUseCase.execute(
        CreateMessageUseCaseInput(id: _chatRoom!.id, content: message));

    if (createMessageResponse.success && createMessageResponse.data != null) {
      debugPrint('Successfully sent message');
      setState(() {
        // _chatRoom?.messages?.add(createMessageResponse.data as Message);
      });
    }

    _contentController.clear();
  }
}

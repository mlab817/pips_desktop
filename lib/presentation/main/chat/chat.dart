import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/models/chat_room.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:skeletons/skeletons.dart';

import '../../../app/routes.dart';
import '../../../data/responses/chat_rooms/chat_rooms.dart';
import '../../../domain/models/user.dart';
import '../../../domain/usecase/base_usecase.dart';
import 'chat_bottom_sheet.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatRoomsUseCase _chatRoomsUseCase = instance<ChatRoomsUseCase>();
  final Repository _repository = instance<Repository>();

  late ScrollController _scrollController;

  User? _currentUser;

  Future<Result<ChatRoomsResponse>> _getChatRooms() async {
    return _chatRoomsUseCase.execute(Void());
  }

  @override
  void initState() {
    super.initState();

    _getChatRooms();

    _scrollController = ScrollController();

    _repository.getLoggedInUser().then((value) {
      _currentUser = value;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.chat),
        actions: [
          IconButton(
            onPressed: () {
              // open bottom sheet
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const ChatBottomSheet();
                  });
            },
            icon: const Icon(Icons.add_comment),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _getChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                  itemCount: snapshot.data?.data?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final chatRooms = snapshot.data?.data?.data ?? [];
                    final chatRoom = chatRooms[index];

                    return _buildItem(chatRoom);
                  });
            }
            return Container();
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.md),
                  child: SkeletonListTile(
                    hasLeading: true,
                    hasSubtitle: true,
                  ),
                );
              });
        });
  }

  // get chat bar
  Widget _buildItem(ChatRoom chatRoom) {
    final User? user = chatRoom.users
        ?.where((element) => element.id != _currentUser?.id)
        .first;

    return ListTile(
      leading: CircleAvatar(
        child: Text(user?.firstName?[0].toUpperCase() ?? 'NA'),
      ),
      onTap: user != null
          ? () {
              //
              Navigator.pushNamed(context, Routes.chatRoomRoute,
                  arguments: user);
            }
          : null,
      title: Text(user?.firstName ?? 'NA'),
      subtitle: Text(
        chatRoom.lastMessage?.content ?? 'No message',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: chatRoom.lastMessage != null
          ? Text(DateFormat.MMMd()
              .format(DateTime.parse(chatRoom.lastMessage!.createdAt)))
          : null,
    );
  }
}

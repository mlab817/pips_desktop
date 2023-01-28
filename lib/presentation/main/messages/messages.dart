import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final TextEditingController _contentController = TextEditingController();

  final List<Message> _messages = <Message>[];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
    );
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

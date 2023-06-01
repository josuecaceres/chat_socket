import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/provider/chat_provider.dart';
import 'package:chat_socket/widgets/widgets.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => chatProvider.messages[index],
            itemCount: chatProvider.messages.length,
            reverse: true,
          ),
        ),
        const Divider(height: 1),
        Container(
          color: Colors.white,
          height: 60,
          child: const ChatInput(),
        )
      ],
    );
  }
}

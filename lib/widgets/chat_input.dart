import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/provider/chat_provider.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: chatProvider.textController,
                onChanged: (String value) {
                  if (value.trim().isNotEmpty) {
                    chatProvider.escribiendo = true;
                  } else {
                    chatProvider.escribiendo = false;
                  }
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: chatProvider.focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: const _SendButton(),
            )
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: IconTheme(
        data: IconThemeData(color: Colors.blue.shade400),
        child: IconButton(
          onPressed: chatProvider.escribiendo ? chatProvider.newMessage : null,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/widgets/widgets.dart';
import 'package:chat_socket/provider/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
              child: Text(
                chatProvider.usuarioPara.nombre.substring(0, 2),
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              chatProvider.usuarioPara.nombre,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
      body: const ChatBody(),
    );
  }
}

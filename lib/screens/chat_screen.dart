import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/widgets/widgets.dart';
import 'package:chat_socket/provider/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                maxRadius: 14,
                child: const Text(
                  'Te',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Melissa Flores',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        body: const ChatBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:chat_socket/widgets/widgets.dart';

class ChatProvider extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> messages = [];

  bool get escribiendo => _escribiendo;
  set escribiendo(bool value) {
    _escribiendo = value;
    notifyListeners();
  }

  newMessage() {
    var message = textController.text;

    if (message.isEmpty) return;

    final newMessage = ChatMessage(
      texto: message.trim(),
      uid: '123',
    );

    textController.clear();
    focusNode.requestFocus();
    messages.insert(0, newMessage);
    escribiendo = false;
    notifyListeners();
  }
}

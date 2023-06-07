import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_socket/widgets/widgets.dart';
import 'package:chat_socket/models/usuario.dart';
import 'package:chat_socket/models/mensajes_respnse.dart';
import 'package:chat_socket/services/auth_service.dart';

class ChatProvider with ChangeNotifier {
  late Usuario usuarioPara;

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  set messages(List<ChatMessage> value) {
    _messages = value;
    notifyListeners();
  }

  bool get escribiendo => _escribiendo;
  set escribiendo(bool value) {
    _escribiendo = value;
    notifyListeners();
  }

  sendMessage(String uid) {
    final message = textController.text;
    if (message.isEmpty) return;

    final newMessage = ChatMessage(
      texto: message.trim(),
      uid: uid,
    );

    textController.clear();
    focusNode.requestFocus();
    messages.insert(0, newMessage);
    escribiendo = false;
    notifyListeners();
  }

  resiveMessage(String message, String uid) {
    if (message.isEmpty) return;

    final newMessage = ChatMessage(
      texto: message.trim(),
      uid: uid,
    );

    messages.insert(0, newMessage);
    notifyListeners();
  }

  Future<List<Mensaje>> getChat(String usuarioId) async {
    final Uri url = Uri.parse('https://chatsocket.up.railway.app/api/mensajes/$usuarioId');

    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final mensajesResp = MensajesResponse.fromRawJson(resp.body);

    return mensajesResp.mensajes;
  }
}

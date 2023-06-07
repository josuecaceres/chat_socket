import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/models/mensajes_respnse.dart';
import 'package:chat_socket/widgets/widgets.dart';
import 'package:chat_socket/provider/chat_provider.dart';
import 'package:chat_socket/services/socket_service.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late SocketService socketService;
  late ChatProvider chatProvider;

  @override
  void initState() {
    socketService = Provider.of<SocketService>(context, listen: false);
    chatProvider = Provider.of<ChatProvider>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarMensajes(chatProvider.usuarioPara.uid);

    super.initState();
  }

  _escucharMensaje(dynamic payload) {
    if (payload['de'] != chatProvider.usuarioPara.uid) return;
    chatProvider.resiveMessage(payload['mensaje'], payload['de']);
  }

  _cargarMensajes(String usuarioId) async {
    List<Mensaje> chat = await chatProvider.getChat(usuarioId);

    final history = chat.map((m) => ChatMessage(
          texto: m.mensaje,
          uid: m.de,
        ));

    chatProvider.messages = history.toList();
  }

  @override
  void dispose() {
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

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

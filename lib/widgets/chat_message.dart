import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;

  const ChatMessage({
    super.key,
    required this.texto,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 200),
      child: Container(
        child: uid == '123' ? _myMessage() : _noMyMessage(),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          texto,
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _noMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          texto,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

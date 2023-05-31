import 'package:flutter/material.dart';
import 'package:chat_socket/screens/screens.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => const UsuariosScreen(),
  'chat': (_) => const ChatScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'loading': (_) => const LoadingScreen(),
};

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_socket/models/usuario.dart';
import 'package:chat_socket/models/usuarios_response.dart';
import 'package:chat_socket/services/auth_service.dart';

class UsuarioService with ChangeNotifier {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => _usuarios;

  set usuarios(List<Usuario> value) {
    _usuarios = value;
    notifyListeners();
  }

  getUsuarios() async {
    try {
      final Uri url = Uri.parse('https://chatsocket.up.railway.app/api/usuarios?desde=0');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final usuariosResponse = UsuariosResponse.fromRawJson(resp.body);
      usuarios = usuariosResponse.usuarios;

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

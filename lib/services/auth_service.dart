import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_socket/global/enviroment.dart';
import 'package:chat_socket/models/login_response.dart';
import 'package:chat_socket/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  //Getter del token
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    final Uri url = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResp = LoginResponse.fromRawJson(resp.body);
      usuario = loginResp.usuario;
      await _saveToken(loginResp.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');
    final resp = await http.post(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromRawJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token') ?? '';

    final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token,
    });

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromRawJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_socket/models/usuario.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/services/socket_service.dart';
import 'package:chat_socket/services/usuarios_service.dart';
import 'package:chat_socket/provider/chat_provider.dart';

class UsuariosScreen extends StatelessWidget {
  const UsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    usuarioService.getUsuarios();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        title: Text(
          authService.usuario.nombre,
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: usuarioService.refreshController,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400),
          waterDropColor: Colors.blue,
        ),
        onRefresh: () async {
          final usuarioService = Provider.of<UsuarioService>(context, listen: false);
          usuarioService.getUsuarios();
          usuarioService.refreshController.refreshCompleted();
        },
        child: _ListviewUsuarios(usuarios: usuarioService.usuarios),
      ),
    );
  }
}

class _ListviewUsuarios extends StatelessWidget {
  final List<Usuario> usuarios;

  const _ListviewUsuarios({
    required this.usuarios,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, int i) => _UsuarioListTile(usuario: usuarios[i]),
      separatorBuilder: (_, int i) => const Divider(),
      itemCount: usuarios.length,
    );
  }
}

class _UsuarioListTile extends StatelessWidget {
  final Usuario usuario;

  const _UsuarioListTile({
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        chatProvider.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

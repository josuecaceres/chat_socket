import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_socket/models/usuario.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'test01@test.com', nombre: 'Maria', uid: '1'),
    Usuario(online: true, email: 'test02@test.com', nombre: 'Melissa', uid: '2'),
    Usuario(online: false, email: 'test03@test.com', nombre: 'Fernando', uid: '3'),
    Usuario(online: true, email: 'test04@test.com', nombre: 'Paco', uid: '4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {},
        ),
        title: const Text('Mi nombre'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
/*               icon: const Icon(
                Icons.check_circle,
                color: Colors.blue,
              ), */
              icon: const Icon(
                Icons.offline_bolt,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400),
          waterDropColor: Colors.blue,
        ),
        onRefresh: _cargarUsuarios,
        child: _ListviewUsuarios(usuarios: usuarios),
      ),
    );
  }

  void _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
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

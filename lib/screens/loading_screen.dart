import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/screens/screens.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ckeckLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future ckeckLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = authService.isLoggedIn();

    if (await autenticado) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosScreen(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginScreen(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    }
  }
}

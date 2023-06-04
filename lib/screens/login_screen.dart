import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_socket/widgets/widgets.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/helpers/show_alert.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'Messanger',
                ),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora!',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BtnAzul(
            text: 'Ingresar',
            onPressd: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      showAlert(context, 'Login incorrecto', 'Verifique sus credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}

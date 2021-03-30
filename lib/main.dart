import 'package:app_anuncio/tela/cadastroAnuncio_tela.dart';
import 'package:app_anuncio/tela/cadastroUsuario_tela.dart';
import 'package:app_anuncio/tela/inicio_tela.dart';
import 'package:app_anuncio/tela/login_tela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Anuncio',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        cursorColor: Colors.blueAccent,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(10)),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),

      home: UsuarioTela(),
    );
  }
}

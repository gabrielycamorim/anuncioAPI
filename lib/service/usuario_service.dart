import 'dart:convert';
import 'package:app_anuncio/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class UsuarioService {
  Future<Usuario> login(Usuario usuario) async {

    final response = await http.post('http://anuncios.marcelmelo.com.br/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      Usuario tToken =  Usuario.fromJson(jsonDecode(response.body));
      print("login");
      print(response.body);
      print(response.statusCode);
      return tToken;

    } else {
      Exception("Falha na conexão com o servidor!");
    }

}
  Future<Usuario> newUsuario(Usuario usuarioCad) async {

    final response = await http.post(
      'http://anuncios.marcelmelo.com.br/usuario/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(usuarioCad.toJson()),
    );
    if (response.statusCode == 201) {
      Usuario resUsuario = Usuario.fromJson(jsonDecode(response.body));
      return resUsuario;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }
}
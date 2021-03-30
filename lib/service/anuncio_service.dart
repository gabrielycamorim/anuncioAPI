import 'dart:convert';
import 'package:app_anuncio/model/anuncio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AnuncioService {
  Future<List<Anuncio>> fetchPosts({int usuarioId}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("token");

    final url = usuarioId != null
        ? await 'http://anuncios.marcelmelo.com.br/anuncios?usuarioId=$usuarioId'
        : await 'http://anuncios.marcelmelo.com.br/anuncios/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List resList = jsonDecode(response.body);
      List<Anuncio> anuncios = [];
      resList.forEach((mAnuncio) {
        anuncios.add(Anuncio.fromJson(mAnuncio));
      });
      return anuncios;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }

  Future<Anuncio> newAnuncio(Anuncio anuncio) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("token");

    final response = await http.post(
      'http://anuncios.marcelmelo.com.br/anuncios/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(anuncio.toJson()),
    );

    if (response.statusCode == 201) {
      Anuncio resAnuncio = Anuncio.fromJson(jsonDecode(response.body));
      return resAnuncio;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }

  Future<Anuncio> editAnuncio(Anuncio anuncio) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("token");
    
    String url = await 'http://anuncios.marcelmelo.com.br/anuncios/${anuncio.id}';
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(anuncio.toJson()),
    );
    if (response.statusCode == 200) {
      Anuncio resAnuncio = Anuncio.fromJson(jsonDecode(response.body));
      return resAnuncio;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }

  Future<Anuncio> removeAnuncio(int id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("token");

    String url = await 'http://anuncios.marcelmelo.com.br/anuncios/$id';
    final response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      Anuncio resAnuncio = Anuncio.fromJson(jsonDecode(response.body));
      return resAnuncio;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }
}

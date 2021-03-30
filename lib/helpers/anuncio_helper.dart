import 'dart:io';

import 'package:app_anuncio/model/anuncio.dart';
import 'package:app_anuncio/service/anuncio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnuncioHelperUsuario {
  Future<List<Anuncio>> getPostsByUser() async {
    AnuncioService _service = AnuncioService();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged")) {
      return _service.fetchPosts(usuarioId: prefs.getInt("usuarioId"));
    }
    }
}


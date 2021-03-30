import 'dart:io';

import 'package:app_anuncio/model/anuncio.dart';
import 'package:app_anuncio/service/anuncio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnuncioHelper {
  Future<Anuncio> cadastrarAnuncio(String titulo, String descricao,
      double preco, File image) async {
    var anuncioCad = Anuncio(
        titulo: titulo, descricao: descricao, preco: preco, image: image);
    AnuncioService _service = AnuncioService();
    Anuncio anuncio = await _service.newAnuncio(anuncioCad);
    return anuncio;
  }
}
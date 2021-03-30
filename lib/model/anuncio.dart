import 'dart:convert';

import 'dart:io';

Anuncio postFromJson(String str) => Anuncio.fromJson(json.decode(str));

String postToJson(Anuncio data) => json.encode(data.toJson());

class Anuncio {
  Anuncio({this.usuarioId, this.id, this.titulo, this.descricao, this.preco, this.image, this.body});

  int usuarioId;
  int id;
  String titulo;
  String descricao;
  double preco;
  File image;
  String body;

  factory Anuncio.fromJson(Map<String, dynamic> json) => Anuncio(
    usuarioId: json["usuarioId"],
    id: json["id"],
    titulo: json["titulo"],
    descricao: json["desricao"],
    preco: json["preco"],
    image: json["image"],
    body: json["body"],

  );

  Map<String, dynamic> toJson() => {
    "usuarioId": usuarioId,
    "id": id,
    "titulo": titulo,
    "descricao": descricao,
    "preco": preco,
    "image": image,
    "body": body,
  };
}

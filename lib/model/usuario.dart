import 'dart:convert';

Usuario userFromJson(String str) => Usuario.fromJson(json.decode(str));

String userToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.usuarioId,
    this.nome,
    this.telefone,
    this.senha,
    this.token,
  });

  int usuarioId;
  String nome;
  String telefone;
  String senha;
  String token;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    usuarioId: json["usuarioId"],
    nome: json["nome"],
    telefone: json["telefone"],
    senha: json["senha"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "usuarioId": usuarioId,
    "nome": nome,
    "telefone": telefone,
    "senha": senha,
    "token": token,
  };
}

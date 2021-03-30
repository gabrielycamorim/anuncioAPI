import 'package:app_anuncio/model/usuario.dart';
import 'package:app_anuncio/service/usuario_service.dart';


class UsuarioHelper {
  Future<Usuario> cadastrar(String nome, String telefone, String senha) async {
    var usuarioCad = Usuario(nome: nome, telefone: telefone, senha: senha);
    UsuarioService _service = UsuarioService();
    Usuario usuario = await _service.newUsuario(usuarioCad);
    return usuario;
  }
}

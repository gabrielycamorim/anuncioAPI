import 'package:app_anuncio/model/usuario.dart';
import 'package:app_anuncio/service/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHelper {
  Future<Usuario> login(String telefone, String senha) async {
    var user = Usuario(telefone: telefone, senha: senha);
    UsuarioService _service = UsuarioService();
    Usuario usuario = await _service.login(user);
    if (usuario != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("logged", true);
      prefs.setInt("usuarioId", usuario.usuarioId);
      prefs.setString("token", usuario.token);
      print(usuario.token);
      return usuario;
    } else {
      await logout();
      return null;
    }
  }

  Future<bool> isUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged", false);
    prefs.remove("usuarioId");
    prefs.remove("token");
  }
}

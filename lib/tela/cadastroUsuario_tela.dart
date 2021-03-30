
import 'package:app_anuncio/helpers/UsuarioHelper.dart';
import 'package:app_anuncio/model/anuncio.dart';
import 'package:app_anuncio/model/usuario.dart';
import 'package:app_anuncio/tela/cadastroAnuncio_tela.dart';
import 'package:app_anuncio/tela/login_tela.dart';
import 'package:flutter/material.dart';
import 'inicio_tela.dart';

class UsuarioTela extends StatefulWidget {
  Usuario usuario;
  UsuarioTela({Key key}) : super(key: key);

  @override
  _UsuarioTelaState createState() => _UsuarioTelaState();
}

class _UsuarioTelaState extends State<UsuarioTela> {
  UsuarioHelper _helper = UsuarioHelper();




  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _textControllerNom = TextEditingController();
    final TextEditingController _textControllerTel = TextEditingController();
    final TextEditingController _textControllerSen = TextEditingController();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('API REST'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _textControllerNom,
                    decoration: InputDecoration(
                        labelText: "Nome:",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[900],
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preenchimento obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _textControllerTel,
                    decoration: InputDecoration(
                        labelText: "Telefone:",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[900],
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preenchimento obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _textControllerSen,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Senha:",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[900],
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preenchimento obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      color: Colors.blue[900],
                      child: Text(
                        "Cadastrar Usuario",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),

    onPressed: () async {
      if (_formKey.currentState.validate()) {
        Usuario usuario = await _helper.cadastrar(
            _textControllerNom.text,
            _textControllerTel.text,
            _textControllerSen.text);

        if (usuario != null) {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginTela()));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Sistema erro!"),
          ));
        }
      }



                 })
                      )
            ]),
          ),
        ),
    ),
    );

  }
}




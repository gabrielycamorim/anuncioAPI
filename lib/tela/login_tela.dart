
import 'package:app_anuncio/helpers/login_helper.dart';
import 'package:app_anuncio/model/usuario.dart';
import 'package:app_anuncio/tela/cadastroAnuncio_tela.dart';
import 'package:flutter/material.dart';

import 'inicio_tela.dart';

class LoginTela extends StatefulWidget {
  LoginTela({Key key}) : super(key: key);
  int usuarioId;

  @override
  _LoginTelaState createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  LoginHelper _helper = LoginHelper();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (await _helper.isUserLogged()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TelaInicio()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
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
                        "Logar",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Usuario usuario = await _helper.login(

                              _textControllerTel.text,
                              _textControllerSen.text);
                          if (usuario != null) {

                            int id;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroAnuncioTela(id)));
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Usuário não encontrado!"),
                            ));
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

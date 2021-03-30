import 'dart:io';
import 'dart:ui';
import 'package:app_anuncio/helpers/anuncio_helper.dart';
import 'package:app_anuncio/helpers/login_helper.dart';
import 'package:app_anuncio/model/anuncio.dart';
import 'package:app_anuncio/tela/cadastroAnuncio_tela.dart';
import 'package:app_anuncio/tela/login_tela.dart';

import 'package:flutter/material.dart';

class TelaInicio extends StatefulWidget {
  Anuncio anuncio;
  TelaInicio({Key key}) : super(key: key);

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  Future<List<Anuncio>> _anuncios;
  final AnuncioHelperUsuario _helper = AnuncioHelperUsuario();


  @override
  void initState() {
    super.initState();
    _anuncios = _helper.getPostsByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API REST"),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                final loginHelper = LoginHelper();
                await loginHelper.logout();
                if (await loginHelper.isUserLogged() == false) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginTela()));
                }
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _anuncios,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Anuncio> anuncios = snapshot.data;
              return ListView.separated(
                itemCount: anuncios.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CadastroAnuncioTela(anuncios[index].id)));
                    },
                    child: ListTile(
                      title: Text(
                        anuncios[index].titulo,
                        style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                      ),
                      subtitle: Text(
                        anuncios[index].body.replaceAll('\n', ' '),
                        textAlign: TextAlign.justify,
                      ),
                      isThreeLine: true,
                      trailing: Icon(Icons.chevron_right),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

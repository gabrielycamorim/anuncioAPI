import 'dart:io';
import 'package:app_anuncio/helpers/AnuncioHelper.dart';
import 'package:app_anuncio/helpers/anuncio_helper.dart';
import 'package:app_anuncio/model/anuncio.dart';
import 'package:app_anuncio/tela/inicio_tela.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CadastroAnuncioTela extends StatefulWidget {
  Anuncio anuncio;

  CadastroAnuncioTela(int id, {this.anuncio});

  @override
  _CadastroAnuncioState createState() => _CadastroAnuncioState();
}

class _CadastroAnuncioState extends State<CadastroAnuncioTela> {


  AnuncioHelper _helper = AnuncioHelper();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textControllerTit = TextEditingController();
  final TextEditingController _textControllerDes = TextEditingController();
  final TextEditingController _textControllerPre = TextEditingController();
  File _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();


    if (widget.anuncio != null) {
      setState(() {
        _textControllerTit.text = widget.anuncio.titulo;
        _textControllerDes.text = widget.anuncio.descricao;
        _textControllerPre.text = widget.anuncio.preco.toString();
        _image = widget.anuncio.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de livros"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
                width: 120,
                height: 100,
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(color: Colors.grey[200],
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    shape: BoxShape.circle),

                child: _image == null ? Icon(
                  Icons.add_a_photo,
                  size: 30,

                ) : ClipOval(
                  child: Image.file(_image),
                )
            ),
            onTap: () async {
              final escImg = ImagePicker();
              final imgCam = await escImg.getImage(source: ImageSource.camera);
              if (imgCam != null) {
                setState(() {
                  _image = File(imgCam.path);
                });
              }
            },
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: TextFormField(
                    controller: _textControllerTit,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 3.0),
                      ),
                      labelText: "Titulo do livro",
                      labelStyle: TextStyle(fontSize: 18),

                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Obrigatório";
                      }
                    },

                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: TextFormField(
                    controller: _textControllerDes,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 3.0),
                      ),
                      labelText: "Descrição do livro",
                      labelStyle: TextStyle(fontSize: 18),

                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Obrigatório";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: TextFormField(
                    controller: _textControllerPre,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.greenAccent, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 3.0),
                        ),
                        labelText: "Preço do livro",
                        prefix: Text('R\$ '),
                        labelStyle: TextStyle(fontSize: 18)),
                    keyboardType: TextInputType.number,


                    validator: (value) {
                      if (value.isEmpty) {
                        return "Obrigatório";
                      }
                    },
                  ),
                ),
                Row(
                  children: [

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        height: 40,
                        width: 60,
                        child: RaisedButton(
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.lightGreen,

                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Anuncio anuncio = await _helper.cadastrarAnuncio(
                                    _textControllerTit.text,
                                    _textControllerDes.text,
                                    (double.parse(_textControllerPre.text)),
                                    _image);

                                if (anuncio != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TelaInicio()));
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Sistema erro!"),
                                      ));
                                }
                              }
                            }
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),);
  }
}

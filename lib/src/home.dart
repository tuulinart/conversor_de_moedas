import 'package:conversor_de_moedas/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  double dolar;
  double euro;

  void _realchanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (euro / dolar).toStringAsFixed(2);
  }

  void _dolarchanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _eurochanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//Widget para colocar a bar no topo da tela.
        appBar: AppBar(
          title: Text("\$ Conversor de valores =) \$ "),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            //Está retornado um MAP, pq nosso json retorna MAP.
            future: getData(),
            //Solicita os dados passado no "getData" e retorna os dados futuro.
            builder: (context, snapshot) {
              //Snapchot é uma copia dos dados que ele obter do servidor.
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Stack(
                    children: [
                      new Image.asset(
                        "images/eu.jpg",
                        fit: BoxFit.cover,
                        height: 1000.0,
                      ),
                      Center(
                          child: Text(
                        "Carregando Dados",
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados =(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          new Image.asset(
                            "images/eu.jpg",
                            fit: BoxFit.cover,
                            height: 600.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Icon(Icons.monetization_on,
                                    size: 150.0, color: Colors.amber),
                                buildTextField("Reais", "R\$", realController,
                                    _realchanged),
                                Divider(),
                                buildTextField("Dólares", "US\$",
                                    dolarController, _dolarchanged),
                                Divider(),
                                buildTextField(
                                    "Euros", "€", euroController, _eurochanged)
                              ]),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(String labeltext, String prefix,
    TextEditingController controller, Function text) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: TextStyle(color: Colors.amberAccent, fontSize: 40.0),
        border: OutlineInputBorder(),
        prefixText: prefix),
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.amber, fontSize: 30.0, fontStyle: FontStyle.italic),
    onChanged: text,
  );
}

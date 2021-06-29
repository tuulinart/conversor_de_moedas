import 'package:conversor_de_moedas/src/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//Essa bibilioteca nos permite fazer requisições e não tenha que ficar
//esperando receber os dados, a hora que recebe já tem uma função.

const request = "https://api.hgbrasil.com/finance";

void main() async {
  http.Response response = await http.get(request);
  //Comando para obter a resposta do servidor.
  // o await e para esperar os dados chegarem e assim colocar n variavel reponse.

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  //Essa função retorna um mapa no futuro.
  http.Response response = await http.get(request);
  //os dados são futuros, por isso o await, por que está esperando o dado chegar.
  //os dados chegam e vão para o response.
  return json.decode(response.body);
  // pegamos o corpo da "response" (body), e transformamos em um Map, atraves do
  //json.
}

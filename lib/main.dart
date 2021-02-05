import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 50.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/bitcoin.png"),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "R\$ " + _preco,
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.orange,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  onPressed: _recuperarPreco,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

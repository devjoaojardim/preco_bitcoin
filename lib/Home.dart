import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  String _preco = "0";

  _recuperarBitcoin() async {

    String url = "https://blockchain.info/ticker";

    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = jsonDecode(response.body);

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 32),
                child: Text(
                  "R\$ " + _preco,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange)),
                      onPressed: _recuperarBitcoin,
                      child: Text("Atualizar", style: TextStyle(fontSize: 24))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

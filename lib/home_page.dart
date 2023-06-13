// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, unnecessary_null_comparison, prefer_if_null_operators, sized_box_for_whitespace

import 'package:finance_app/tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'homepage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> list = [];

  Future<dynamic> connect() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/coins/list'),
        headers: {"Content-type": "application/json"},
      );
      var responseList = json.decode(response.body);
      // print(responseList);
      // print(responseList[0]['name']);
      list = [];
      String forPrice = '';
      for (int i = 0; i < 1000; i++) {
        if (responseList[i]['name'].split(' ').length == 1) {
          forPrice = forPrice + responseList[i]['name'].toString() + "%2C";
        }
      }
      forPrice = forPrice.substring(0, forPrice.length - 3);

      final response1 = await http.get(
        Uri.parse(
            'https://api.coingecko.com/api/v3/simple/price?ids=${forPrice}&vs_currencies=usd'),
        headers: {"Content-type": "application/json"},
      );
      var price = json.decode(response1.body);
      for (int i = 0; i < responseList.length; i++) {
        if (responseList[i]['name'].split(' ').length == 1) {
          list.add(
            Tile(
              name: responseList[i]['name'].toString(),
              price: price[responseList[i]['name'].toString().toLowerCase()] !=
                      null
                  ? price[responseList[i]['name'].toString().toLowerCase()]
                          ['usd']
                      .toString()
                  : '\$0',
            ),
          );
        }
      }
      return list;
    } catch (e) {
      print(e);
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Finance App",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: connect(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: list,
                  );
                } else {
                  return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 10,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

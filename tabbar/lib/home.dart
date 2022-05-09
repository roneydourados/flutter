import 'package:flutter/material.dart';
import 'package:tabbar/paginas/bichos.dart';
import 'package:tabbar/paginas/numeros.dart';
import 'package:tabbar/paginas/vogais.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xfff5e9b9),
        appBar: AppBar(
          // backgroundColor: Colors.brown,
          title: const Text('Aprenda inglês'),
          bottom: const TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'Bichos',
                //icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Números',
                //icon: Icon(Icons.email),
              ),
              Tab(
                text: 'Vogais',
                //icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Bichos(),
            Numeros(),
            Vogais(),
          ],
        ),
      ),
    );
  }
}

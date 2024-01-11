import 'package:flutter/material.dart';
import 'package:tasca_3/pages/pantalla_afegeix_grup.dart';
import 'package:tasca_3/pages/pantalla_edita_recepta.dart';
import 'package:tasca_3/pages/pantalla_grup.dart';
import 'package:tasca_3/pages/pantalla_llista_receptes.dart';
import 'package:tasca_3/pages/pantalla_grups.dart';
import 'package:tasca_3/pages/pantalla_mostra_recepta.dart';
import 'package:tasca_3/pages/pantalla_usuari.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "App de receptes",
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        // home: MyHomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/pantalla_grups': (context) => const PantallaGrups(),
          '/pantalla_grup': (context) => const PantallaGrup(),
          '/pantalla_afegir_grup': (context) => const PantallaAfegeixGrup(),
          '/pantalla_edita_recepta': (context) => const PantallaEditaRecepta(),
          '/pantalla_mostra_recepta': (context) =>
              const PantallaMostraRecepta(),
          /* PantallaLlistaReceptes.route: (context) =>
              const PantallaLlistaReceptes(),
          PantallaMostraRecepta.route: (context) =>
              const PantallaMostraRecepta(),
          PantallaEditaRecepta.route: (context) => const PantallaEditaRecepta(),*/
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var pagActual = 0;

  @override
  Widget build(BuildContext context) {
    final pags = [
      const PantallaGrups(),
      const PantallaLlistaReceptes(),
      const pantallausuari(),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CuinaCompartida',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: pagActual,
          children: pags,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: pagActual,
            onTap: (index) {
              setState(() {
                pagActual = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: 'Grups',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.table_rows),
                label: 'Receptes',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: 'Usuari',
                backgroundColor: Colors.grey,
              ),
            ]));
  }
}

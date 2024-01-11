import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:tasca_3/models/usuari.dart';
import 'package:tasca_3/models/grup.dart';
import 'dart:convert';

class PantallaGrups extends StatefulWidget {
  const PantallaGrups({super.key});

  @override
  State<PantallaGrups> createState() => _PantallaGrupsState();
}

class _PantallaGrupsState extends State<PantallaGrups> {
  List<Grup>? grups;

  Future<List<Grup>> getLlistaGrupsFuture() async {
    final jsondata = await rootBundle.loadString('assets/grups.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list
        .map((e) => Grup(
              e['nom'],
              e['descripcio'],
              e['foto'],
              (e['membres'] as List<dynamic>?)?.cast<String>() ?? [],
            ))
        .toList();
  }

  List<Grup>? getLlistaGrups() {
    List<Grup> G = [];
    getLlistaGrupsFuture().then((llistaGrups) {
      setState(() {
        for (var grup in llistaGrups) {
          G.add(grup);
        }
      });
    });
    return G;
  }

  @override
  void initState() {
    super.initState();
    grups = getLlistaGrups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: llistaGrups(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/pantalla_afegir_grup')
                .then((value) => setState(() {
                      if (value is String) {
                        grups!.add(Grup(
                            value,
                            'descricpció default',
                            'https://static.vecteezy.com/system/resources/thumbnails/000/551/048/small/user_icon_009.jpg',
                            []));
                      }
                    }));
          },
          backgroundColor: Colors.orange[900],
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }

  GridView llistaGrups() {
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: 80, //perquè el floatingbutton no tapi la última recepta
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: itemBuilder,
      itemCount: grups!.length,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(grups![index].foto),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      grups![index].nom,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    grups![index].descripcio,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )),
                  Column(
                    children: List<Widget>.generate(
                      grups![index].membres.length,
                      (i) {
                        return Text(
                          grups![index].membres[i],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          "/pantalla_grup",
          arguments: grups![index],
        ).then((value) => setState(() {
              if (value is Grup) {
                grups![index] = value;
              } else if (value is bool) {
                grups!.removeAt(index);
              }
            }));
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final String userName;

  GridItem({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(
          userName,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

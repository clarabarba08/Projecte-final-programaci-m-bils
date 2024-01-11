import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasca_3/models/grup.dart';
import 'package:tasca_3/models/recepta.dart';
import 'dart:convert';

class PantallaGrup extends StatefulWidget {
  const PantallaGrup({super.key});

  @override
  State<PantallaGrup> createState() => _PantallaGrupState();
}

class _PantallaGrupState extends State<PantallaGrup> {
  List<Recepta>? receptes;

  Future<List<Recepta>> getLlistaReceptesFuture() async {
    final jsondata = await rootBundle.loadString('assets/receptes.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Recepta(e)).toList();
  }

  List<Recepta>? getLlistaReceptes() {
    List<Recepta> L = [];
    getLlistaReceptesFuture().then((llistaReceptes) {
      setState(() {
        for (var recepta in llistaReceptes) {
          L.add(recepta);
        }
      });
    });
    return L;
  }

  @override
  void initState() {
    super.initState();
    receptes = getLlistaReceptes();
  }

  void valorarRecepta(int index, int valoracio) {
    setState(() {
      receptes![index].valoracio = valoracio;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Grup elgrup = ModalRoute.of(context)!.settings.arguments as Grup;
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            portada(elgrup),
            Expanded(
              child: llistaReceptes(),
            ),
          ],
        ));
  }

  Row navegacioSuperior(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(
          color: Colors.white,
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    Text('Eliminar grup'),
                  ],
                ),
                value: 'opcio1',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    Text('Editar el grup'),
                  ],
                ),
                value: 'opcio2',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.door_back_door_outlined,
                      color: Colors.black,
                    ),
                    Text('Sortir del grup'),
                  ],
                ),
                value: 'opcio3',
              ),
            ];
          },
          onSelected: (result) {
            // Manejar la opción seleccionada aquí
            switch (result) {
              case 'opcio1':
                // Mostrar confirmación al eliminar grupo
                ConfirmacioEliminarGrup(context);
                break;
              case 'opcion2':
                // ConfirmacioSortir(context);
                break;
              case 'opcion3':
              //anar a pantalla edita grup
              // Otros casos
            }
          },
        ),
      ],
    );
  }

  void ConfirmacioEliminarGrup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Estàs segur que vols eliminar aquest grup?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Agregar lógica para eliminar el grupo aquí
                // ...

                Navigator.of(context).pop();
                Navigator.pop(context, true); // Cerrar el diálogo
              },
              child: Text('Acceptar'),
            ),
          ],
        );
      },
    );
  }

  Widget portada(Grup elgrup) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Card(
        child: Container(
          height: 200,
          width: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(elgrup.foto),
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
                  navegacioSuperior(context),
                  ListTile(
                    title: Text(
                      elgrup.nom,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      elgrup.descripcio,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: List<Widget>.generate(
                        elgrup.membres.length,
                        (i) {
                          return Text(
                            elgrup.membres[i],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GridView llistaReceptes() {
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: 80, //perquè el floatingbutton no tapi la última recepta
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: itemBuilder,
      itemCount: receptes!.length,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(receptes![index].imatge),
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
                      receptes![index].nom,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Rating(
                          valoracio: receptes![index].valoracio,
                        ),
                        onTap: () {
                          ratingDialog(context,
                              (valoracio) => valorarRecepta(index, valoracio));
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            receptes![index].liked = !receptes![index].liked;
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: receptes![index].liked
                              ? Colors.red
                              : Colors.white,
                          size: 30,
                        ),
                      )
                    ],
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
          "/pantalla_mostra_recepta",
          arguments: receptes![index],
        ).then((value) => setState(() {
              if (value is Recepta) {
                receptes![index] = value;
              } else if (value is bool) {
                receptes!.removeAt(index);
              }
            }));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                receptes![index].nom,
                style: const TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Què vols fer amb la recepta?',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel·lar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      receptes!.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/edita_recepta",
                            arguments: receptes![index])
                        .then((value) {
                      if (value is Recepta) {
                        setState(() {
                          receptes![index] = value;
                        });
                      }
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    'Editar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class Rating extends StatelessWidget {
  final int valoracio;

  const Rating({
    super.key,
    required this.valoracio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < valoracio; i++)
          const Icon(Icons.star, color: Colors.orange, size: 17),
        for (int i = 0; i < 5 - valoracio; i++)
          const Icon(Icons.star, color: Colors.white, size: 17)
      ],
    );
  }
}

Future<void> ratingDialog(
  BuildContext context,
  Function valoraRecepta,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Valorar recepta',
          style: TextStyle(color: Colors.white),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                child: const Icon(Icons.star, color: Colors.white, size: 40),
                onTap: () {
                  valoraRecepta(i + 1);
                  Navigator.of(context).pop(i + 1);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel·lar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

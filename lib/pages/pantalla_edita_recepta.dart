import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tasca_3/models/recepta.dart';

class PantallaEditaRecepta extends StatefulWidget {
  static const String route = '/edita_recepta';
  const PantallaEditaRecepta({super.key});
  @override
  State<PantallaEditaRecepta> createState() => _PantallaEditaReceptaState();
}

class _PantallaEditaReceptaState extends State<PantallaEditaRecepta> {
  List<TextEditingController> controllers = [
    for (var i = 0; i < 7; i++) TextEditingController()
  ];
  String pageName = "Nova recepta";
  Recepta? receptaInicial;

  void saveRecepta() {
    Recepta recepta = Recepta({
      "nom": controllers[0].text,
      "tempsPreparacio": int.tryParse(controllers[1].text) ?? 0,
      "persones": int.tryParse(controllers[2].text) ?? 0,
      "calories": int.tryParse(controllers[3].text) ?? 0,
      "valoracio": 0,
      "ingredients": controllers[4].text.split('\n'),
      "pasAPas": controllers[5].text.split('\n'),
      "imatge": controllers[6].text == ""
          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkRKA2d4bynFWUL1-K4cCg4GYUNeBC7R9RtycIkKGf6jL8zhrUj9yROdOUH53yhNTjEgw&usqp=CAU"
          : controllers[6].text,
    });
    Navigator.pop(context, recepta);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Recepta) {
      final Recepta recepta = args;
      controllers[0].text = recepta.nom;
      controllers[1].text = recepta.tempsPreparacio.toString();
      controllers[2].text = recepta.persones.toString();
      controllers[3].text = recepta.calories.toString();
      controllers[4].text = recepta.ingredients.join('\n');
      controllers[5].text = recepta.pasAPas.join('\n');
      controllers[6].text = recepta.imatge;
      pageName = "Edita recepta";
    }
    receptaInicial = Recepta({
      "nom": controllers[0].text,
      "tempsPreparacio": int.tryParse(controllers[1].text) ?? 0,
      "persones": int.tryParse(controllers[2].text) ?? 0,
      "calories": int.tryParse(controllers[3].text) ?? 0,
      "valoracio": 0,
      "ingredients": controllers[4].text.split('\n'),
      "pasAPas": controllers[5].text.split('\n'),
      "imatge": controllers[6].text,
    });
  }

  @override
  Widget build(BuildContext context) {
    Completer<bool> discardChangesCompleter = Completer<bool>();
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            pageName,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                saveRecepta();
              },
            ),
          ],
        ),
        backgroundColor: Colors.grey[800],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 8),
              editTextField("Nom de la recepta", 0, 1),
              const SizedBox(height: 16),
              editTextField("Temps de preparació (min)", 1, 1),
              const SizedBox(height: 16),
              editTextField("Racions", 2, 1),
              const SizedBox(height: 16),
              editTextField("Calories totals", 3, 1),
              const SizedBox(height: 16),
              editTextField("Ingredients", 4, 5),
              const SizedBox(height: 16),
              editTextField("Preparació", 5, 5),
              const SizedBox(height: 16),
              editTextField("Link imatge", 6, 1),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: saveRecepta,
                  child: const Text("Desa"),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Recepta receptaNova = Recepta({
          "nom": controllers[0].text,
          "tempsPreparacio": int.tryParse(controllers[1].text) ?? 0,
          "persones": int.tryParse(controllers[2].text) ?? 0,
          "calories": int.tryParse(controllers[3].text) ?? 0,
          "valoracio": 0,
          "ingredients": controllers[4].text.split('\n'),
          "pasAPas": controllers[5].text.split('\n'),
          "imatge": controllers[6].text,
        });
        if (receptaNova.hasSameContent(receptaInicial!)) {
          return true;
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Descartar canvis?'),
                content: const Text(
                    'Si surts ara, els canvis que has fet no es guardaran.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel·la'),
                    onPressed: () {
                      discardChangesCompleter.complete(false);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Surt'),
                    onPressed: () {
                      discardChangesCompleter.complete(true);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          bool retorn = await discardChangesCompleter.future;
          discardChangesCompleter = Completer<bool>();
          return retorn;
        }
      },
    );
  }

  TextField editTextField(String label, int controllerid, int minLines) {
    return TextField(
      controller: controllers[controllerid],
      keyboardType: TextInputType.multiline,
      minLines: minLines,
      maxLines: 40,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

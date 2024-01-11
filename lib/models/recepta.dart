import 'package:flutter/foundation.dart';

class Recepta {
  String nom, imatge;
  int tempsPreparacio, persones, calories, valoracio;
  List<String> ingredients, pasAPas;
  bool liked = false;
  String? autor = 'clarabarba08';

  // Constructor de la classe Recepta que rep un map amb les dades de la recepta
  Recepta(Map<String, dynamic> json)
      : nom = json['nom'],
        tempsPreparacio = json['tempsPreparacio'],
        persones = json['persones'],
        calories = json['calories'],
        valoracio = json['valoracio'],
        ingredients = List<String>.from(json['ingredients']),
        pasAPas = List<String>.from(json['pasAPas']),
        imatge = json['imatge'],
        autor = json['autor'];

  // Funció per convertir les dades de la recepta en format JSON
  Map<String, dynamic> toJson() => {
        'nom': nom,
        'tempsPreparacio': tempsPreparacio,
        'persones': persones,
        'calories': calories,
        'valoracio': valoracio,
        'ingredients': ingredients,
        'pasAPas': pasAPas,
        'imatge': imatge,
        'autor': autor,
      };

  bool hasSameContent(Recepta other) {
    return nom == other.nom &&
        tempsPreparacio == other.tempsPreparacio &&
        persones == other.persones &&
        calories == other.calories &&
        valoracio == other.valoracio &&
        listEquals(ingredients, other.ingredients) &&
        listEquals(pasAPas, other.pasAPas) &&
        imatge == other.imatge &&
        autor == other.autor;
  }
}

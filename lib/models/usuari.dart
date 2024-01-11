class Usuari {
  String nom;
  String foto;
  List<String> grups;

  Usuari(this.nom, this.foto, this.grups);

  // Constructor de la classe Recepta que rep un map amb les dades de la recepta
  Usuari.fromJson(Map<String, dynamic> json)
      : nom = json['nom'],
        foto = json['foto'],
        grups = json['grups'];

  // Funció per convertir les dades de la recepta en format JSON
  Map<String, dynamic> toJson() => {
        'nom': nom,
        'foto': foto,
        'grups': grups,
      };

  bool hasSameContent(Usuari other) {
    return nom == other.nom && foto == other.foto;
  }
}

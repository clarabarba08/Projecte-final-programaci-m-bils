class Grup {
  String nom;
  String descripcio;
  String foto;
  List<String> membres;

  Grup(this.nom, this.descripcio, this.foto, this.membres);

  // Constructor de la classe Recepta que rep un map amb les dades de la recepta
  Grup.fromJson(Map<String, dynamic> json)
      : nom = json['nom'],
        descripcio = json['descripcio'],
        foto = json['foto'],
        membres = json['membres'];

  // Funció per convertir les dades de la recepta en format JSON
  Map<String, dynamic> toJson() => {
        'nom': nom,
        'decricpio': descripcio,
        'foto': foto,
        'membres': membres,
      };

  bool hasSameContent(Grup other) {
    return nom == other.nom && foto == other.foto;
  }
}

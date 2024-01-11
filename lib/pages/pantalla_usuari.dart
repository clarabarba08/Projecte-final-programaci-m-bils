import 'package:flutter/material.dart';
import 'package:tasca_3/models/usuari.dart';

class pantallausuari extends StatefulWidget {
  const pantallausuari({super.key});

  @override
  State<pantallausuari> createState() => _pantallausuariState();
}

class _pantallausuariState extends State<pantallausuari> {
  @override
  Widget build(BuildContext context) {
    return UserProfile(
      usuari: Usuari(
          'Nom Usuari',
          'https://cdn-icons-png.flaticon.com/512/4792/4792929.png',
          ['Família 1', 'Família 2', 'Amics uni', 'Amics cole']),
    );
  }
}

class UserProfile extends StatelessWidget {
  final Usuari usuari;

  UserProfile({required this.usuari});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            backgroundImage: NetworkImage(usuari.foto),
          ),
          SizedBox(height: 16),
          Text(
            usuari.nom,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Grups dels que formes part: ',
            style: TextStyle(fontSize: 15),
          ),
          for (int i = 0; i < usuari.grups.length; i++) Text(usuari.grups[i])
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PantallaAfegeixGrup extends StatefulWidget {
  const PantallaAfegeixGrup({super.key});
  @override
  State<PantallaAfegeixGrup> createState() => _PantallaAfegeixGrupState();
}

class _PantallaAfegeixGrupState extends State<PantallaAfegeixGrup> {
  List<TextEditingController> controllers = [
    for (var i = 0; i < 7; i++) TextEditingController()
  ];
  String pageName = "Nou grup";

  void saveGrup() {
    String grupnou = controllers[0].text;
    Navigator.pop(context, grupnou);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              saveGrup();
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
            editTextField("Nom del grup", 0, 1),
            editTextField("Descripció del grup", 0, 2),
            Center(
              child: ElevatedButton(
                onPressed: saveGrup,
                child: const Text("Desa"),
              ),
            ),
          ],
        ),
      ),
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

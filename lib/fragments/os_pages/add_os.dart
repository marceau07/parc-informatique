import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOS extends StatefulWidget {
  const AddOS({super.key});

  @override
  AddAnOS createState(){
    return AddAnOS();
  }
}

class AddAnOS extends State<AddOS>{
  final _formKey = GlobalKey<FormState>();
  String message = '';
  TextEditingController osNameController = TextEditingController();

  Future uploadOS() async {
    final Uri uri = ('http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=AddOSJSON&nomOs=${osNameController.text}') as Uri ;
    var response = await http.get(uri);

    if(response.statusCode == 200){
      final item = json.decode(response.body);

      message = item['message'];
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Icon(Icons.check), backgroundColor: Colors.green, duration: Duration(seconds: 3),));
    }
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Icon(Icons.clear), backgroundColor: Colors.red, duration: Duration(seconds: 3),));
  }

  @override
  void dispose() {
    osNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            "Ajouter un système d'exploitation",
            style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Nom du système d'exploitation ?",
              hintText: "Nom du système d'exploitation ?",
            ),
            validator: (value){
              if(value!.isEmpty){
                return 'Veuillez entrer une valeur valide.';
              }
              return null;
            },
            controller: osNameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Téléversement des données pour ${osNameController.text}"), duration: const Duration(seconds: 3),));
                }
                uploadOS();
              },
              child: const Text('Envoyer'),
            ),
          ),
        ],
      ),
    );
  }
}
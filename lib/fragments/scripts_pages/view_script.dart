import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScriptPage extends StatelessWidget{
  final String fileContents;
  const ScriptPage({super.key, required this.fileContents});

  Future<String> fetchScripts() async {
    String theScript = fileContents;
    String uri = 'https://parc-informatique.marceau-rodrigues.fr/scripts/$theScript';

    var response = await http.get(Uri.parse(uri));

    if(response.statusCode == 200) {
      String listScripts = response.body;

      if (kDebugMode) {
        print(listScripts);
      }
      return listScripts;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Script: $fileContents"),),
      body: Container(
        color: Colors.black,
        child: Center(
          child: FutureBuilder(
            future: fetchScripts(),
            builder: (context, snapshot){
              if(!snapshot.hasData) {
                return const Center(
                child: CircularProgressIndicator(),
              );
              }

              return ListView(
                children: <Widget>[
                  Card(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          snapshot.data ?? 'Fichier introuvable',
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
            /* Méthodes qui lit les fichiers présents dans le sous-dossier 'scripts'
            future: DefaultAssetBundle.of(context).loadString("assets/scripts/$fileContents"),
            builder: (context, snapshot){
              return new Text(
                snapshot.data ?? 'Fichier introuvable',
                softWrap: true,
                style: TextStyle(
                    color: Colors.red
                ),
              );
            },
            */
          ),
        ),
      ),
    );
  }
}
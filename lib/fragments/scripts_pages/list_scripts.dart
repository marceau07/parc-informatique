import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parc_informatique/fragments/scripts_pages/view_script.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/Script.dart';

class ScriptListPage extends StatefulWidget{
  const ScriptListPage({super.key});

  @override
  ScriptList createState() => ScriptList();
}

class ScriptList extends State<ScriptListPage> {

  final Uri uri = 'http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=scriptsJSON' as Uri;

  Future<List<Script>> fetchScripts() async {
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Script> listOfScripts = items.map<Script>((json){
        return Script.fromJson(json);
      }).toList();

      return listOfScripts;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Script>>(
            future: fetchScripts(),
            builder: (context, snapshot){

              /// Affiche un squelette tant que les données ne sont pas récuperées
              if(!snapshot.hasData) {
                return ListView(
                children: <Widget>[
                  Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: <int>[0, 1, 2, 3, 4, 5, 6, 7]
                            .map((_) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0, right: 10.0, left: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                  )
                ],
              );
              }

              /// Si table vide dans la BDD
              if(snapshot.data!.isEmpty){
                return const Center(
                  child: Text(
                      "Aucun script à afficher"
                  ),
                );
              }
              return ListView(
                children: snapshot.data!.map((data) => Card(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Nom du script: ${data.nomScript}\n(${data.fichierScript})",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24
                          ),
                        ),
                        Text(
                          "Version du script: ${data.version}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Text(
                          "Utilité du script: ${data.descScript}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Text(
                          "Script destiné à la plateforme: ${data.nomOS}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScriptPage(fileContents: data.fichierScript,)));
                                },
                                child: const Text("En savoir plus")
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )).toList(),
              );
              /*
              * Ancienne méthode qui lisait le contenu d'un fichier JSON
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  var script = scripts[index];
                  return Center(
                    child: Card(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Text(
                            "Nom du script: " + script['nomScript'] + "\n(" + script['fichierScript'] + ")",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24
                            ),
                          ),
                          new Text(
                            "Version du script: " + script['version'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          new Text(
                            "Utilité du script: " + script['descScript'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          new Text(
                            "Script destiné à la plateforme: " + script['nomOs'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScriptPage(fileContents: script['fichierScript'],)));
                                  },
                                  child: const Text("En savoir plus")
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: scripts == null ? 0 : scripts.length,
              );
              */
            }
        ),
      ),
    );
  }
}
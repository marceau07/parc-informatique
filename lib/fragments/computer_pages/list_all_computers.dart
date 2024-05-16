import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../models/Computer.dart';

class AllComputersPage extends StatefulWidget{
  const AllComputersPage({super.key});

  @override
  ComputersAllList createState() => ComputersAllList();
}

class ComputersAllList extends State<AllComputersPage> {
  final String uri = 'https://parc-informatique.marceau-rodrigues.fr/index.php?page=computersJSON';

  Future<List<Computer>> fetchComputers() async {
    var response = await http.get(Uri.parse(uri));

    if(response.statusCode == 200){
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Computer> listOfComputers = items.map<Computer>((json){
        return Computer.fromJson(json);
      }).toList();

      return listOfComputers;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  void main(){
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      if(kReleaseMode) exit(1);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Computer>>(
            future: fetchComputers(),
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
                      "Aucun PC à afficher"
                  ),
                );
              }

              return ListView(
                children: snapshot.data!.map((data) => Card(
                  color: data.nomStatut == "Hors ligne" ? Colors.deepOrangeAccent : Colors.lightGreen,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Adresse IP: ${data.ip}\nAdresse MAC: ${data.mac}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20
                          ),
                        ),
                        Text(
                          "\tRéseau: ${data.reseau}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Text(
                          "\tS'installe sur: ${data.nomOs}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Text(
                          "\tStatut de la machine: ${data.nomStatut}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Text(
                          "\tPC rattaché à: ${data.unEmploye}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16
                          ),
                        ),
                        Container(
                          child: const Text(""),
                        )
                      ],
                    ),
                  ),
                )).toList(),
              );
              /*
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  var computer = computers[index];
                  return Center(
                    child: Card(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Text(
                            "Adresse IP: " + computer['ip'] + "\nAdresse MAC: " + computer['mac'] + "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20
                            ),
                          ),
                          new Text(
                            "\tRéseau: " + computer['reseau'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          new Text(
                            "\tS'installe sur: " + computer['nomOs'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          new Text(
                            "\tStatut de la machine: " + computer['nomStatut'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          new Text(
                            "\tPC rattaché à: " + computer['unEmploye'],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16
                            ),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    print("Card $index cliquée");
                                  },
                                  child: const Text("En savoir plus", style: TextStyle(color: Colors.blueAccent),)
                              ),
                            ],
                          )
                        ],
                      ),
                      color: computer['nomStatut'] == "Hors ligne" ? Colors.deepOrangeAccent : Colors.lightGreen,
                    ),
                  );
                },
                itemCount: computers == null ? 0 : computers.length,
              );
              */
            }
        ),
      ),
    );
  }
}


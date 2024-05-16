import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parc_informatique/fragments/computer_pages/pdf_all_computers.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/Network.dart';
import 'list_computers.dart';

class NetworkListPage extends StatefulWidget{
  const NetworkListPage({super.key});

  @override
  NetworksList createState() => NetworksList();
}

class NetworksList extends State<NetworkListPage> {
  final Uri uri = 'http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=networksJSON' as Uri;

  Future<List<Network>> fetchNetworks() async {
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Network> listOfNetworks = items.map<Network>((json){
        return Network.fromJson(json);
      }).toList();

      return listOfNetworks;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Network>>(
            future: fetchNetworks(),
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
                      "Aucun réseau à afficher"
                  ),
                );
              }

              return ListView(
                children: snapshot.data!.map((data) => Card(
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          CupertinoButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ComputerListPage(aNetwork: data.reseau)));
                            },
                            child: Text("Afficher les PC du réseau ${data.reseau}"),
                          ),
                          ElevatedButton(child: const Text("PDF"), onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllComputersPdf()));
                          }),
                        ],
                      )
                  ),
                )).toList(),
              );
            }
        ),
      ),
    );
  }
}
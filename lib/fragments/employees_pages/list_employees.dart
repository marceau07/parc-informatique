import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../models/Employee.dart';

class EmployeeListPage extends StatefulWidget{
  const EmployeeListPage({super.key});

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {

  final String uri = 'https://parc-informatique.marceau-rodrigues.fr/index.php?page=employeesJSON';

  Future<List<Employee>> fetchEmployees() async {
    var response = await http.get(Uri.parse(uri));

    if(response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Employee> listOfEmployees = items.map<Employee>((json){
        return Employee.fromJson(json);
      }).toList();

      return listOfEmployees;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Employee>>(
            future: fetchEmployees(),
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
                      "Aucun employé"
                  ),
                );
              }
              return ListView(
                children: snapshot.data!.map((data) => Card(
                  color: Colors.orangeAccent,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.person_pin, size: 50.0,),
                          title: Text("${data.prenomEmploye} ${data.nomEmploye}", style: const TextStyle(color: Colors.blue),),
                          subtitle: Text(data.email),
                        ),
                        Text(data.descriptionRole, style: const TextStyle(color: Colors.black54),)
                      ],
                    ),
                  ),
                )).toList(),
              );
            }
        ),
      ),
    );
  }
}
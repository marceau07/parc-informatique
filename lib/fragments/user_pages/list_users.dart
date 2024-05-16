import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../models/User.dart';

class UsersListPage extends StatefulWidget{
  const UsersListPage({super.key});

  @override
  UsersList createState() => UsersList();
}

class UsersList extends State<UsersListPage>{
  final Uri url = 'http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=usersJSON' as Uri;

  Future<List<User>> fetchUsers() async {
    var response = await http.get(url);

    if(response.statusCode == 200){
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<User> listOfUsers = items.map<User>((json){
        return User.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<User>>(
          future: fetchUsers(),
          builder: (context, snapshot) {
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
                    "Aucun utilisateur à afficher"
                ),
              );
            }
            return ListView(
              children: snapshot.data!.map((data) => Card(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.person_outline, size: 50.0,),
                        title: Text(data.pseudo),
                        subtitle: Text("Titre: ${data.titre}"),
                      ),
                      Text("Password: ${data.mdpUtilisateur}"),
                    ],
                  ),
                ),
              )).toList(),
            );
          },
        ),
      ),
    );
  }
}
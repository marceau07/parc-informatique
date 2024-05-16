import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../pages/sign_in_page.dart';
import '../other_pages/goodbye_page.dart';

class AccountViewPage extends StatefulWidget {
  const AccountViewPage({super.key});

  @override
  _AccountViewPage createState() => _AccountViewPage();
}

class _AccountViewPage extends State<AccountViewPage> {
  bool _isButtonRetrievePressed = false;
  bool _dispCircBarRetrieve = false;
  bool _isButtonDeletePressed = false;
  bool _dispCircBarDelete = false;
  late String message;
  late bool isOk;
  var goodBye = const GoodBye();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isButtonRetrievePressed ? null : () {
                    setState(() {
                      _isButtonRetrievePressed = !_isButtonRetrievePressed;
                      _dispCircBarRetrieve = !_dispCircBarRetrieve;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Récupération de vos données..."), duration: Duration(seconds: 1),));
                      retrieveAccountData();
                    });
                  },
                  child: const Text("Récupérer mes informations"),
                ),
                _dispCircBarRetrieve ? const CircularProgressIndicator():Container(),
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: _isButtonDeletePressed ? null : (){
                    setState(() {
                      _isButtonDeletePressed = !_isButtonDeletePressed;
                      _dispCircBarDelete = !_dispCircBarDelete;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Suppression de vos informations..."), duration: Duration(seconds: 1), backgroundColor: Colors.redAccent));
                      deleteAccount();
                    });
                  },
                  child: const Text("Supprimer mon compte"),
                ),
                _dispCircBarDelete ? const CircularProgressIndicator() : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future retrieveAccountData() async {
    final Uri uri = ('http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=retrieveAccountData&email=${getEmail()}') as Uri;
    var response = await http.get(uri);

    if(response.statusCode == 200){
      final item = json.decode(response.body);

      message = item['message'];
      isOk = item['isOk'];
      setState(() {
        _dispCircBarRetrieve = false;
      });
      if(isOk){
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[const Icon(Icons.check), Text(message)],), backgroundColor: Colors.green, duration: const Duration(seconds: 3),));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[const Icon(Icons.clear), Text(message)],), backgroundColor: Colors.red, duration: const Duration(seconds: 2),));
      }
    }
    setState(() {
      _dispCircBarRetrieve = false;
    });
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[const Icon(Icons.clear), Text(message)],), backgroundColor: Colors.red, duration: const Duration(seconds: 3),));
  }

  Future deleteAccount() async {
    addUserToDb();
    final Uri uri = ('http://serveur1.arras-sio.com/symfony4-4017/parcinformatique/web/index.php?page=deleteAccount&email=${getEmail()}') as Uri;
    var response = await http.get(uri);

    if(response.statusCode == 200){
      final item = json.decode(response.body);

      message = item['message'];
      isOk = item['isOk'];
      setState(() {
        _dispCircBarDelete = false;
      });
      if(isOk){
        setState(() {
          _isButtonRetrievePressed = true;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context){return const GoodBye();}));
      } else {
        setState(() {
          _isButtonRetrievePressed = false;
        });
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[const Icon(Icons.clear), Text(message)],), backgroundColor: Colors.red, duration: const Duration(seconds: 3),));
      }
    }
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[const Icon(Icons.clear), Text(message)],), backgroundColor: Colors.red, duration: const Duration(seconds: 3),));
  }
}
import 'package:flutter/material.dart';
import 'package:parc_informatique/fragments/user_pages/list_users.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State {
  late IconData icon;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return const UsersListPage();
      default:
        return const Text("");
    }
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getDrawerItemWidget(0),
    );
  }
}

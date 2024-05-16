import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parc_informatique/pages/sign_in_page.dart';

import '../fragments/index_fragment.dart';
import 'login_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final drawerItems = [
    DrawerItem("Accueil", Icons.home),
    /*DrawerItem("Scripts", Icons.insert_drive_file),
    DrawerItem("Utilisateurs", Icons.people),
    DrawerItem("Employés", Icons.people),
    DrawerItem("Ordinateurs", Icons.laptop),
    DrawerItem("Systèmes d\'exploitations", Icons.language),
    DrawerItem("Mon compte", Icons.account_circle),*/
    DrawerItem("Se déconnecter", Icons.clear),
  ];


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const IndexScreen();
      /*case 1:
        return ScriptScreen();
      case 2:
        return UserScreen();
      case 3:
        return EployeeScreen();
      case 4:
        return ComputerScreen();
      case 5:
        return OSScreen();
      case 6:
        return AccountScreen();
       */
      case 2:
        signOutGoogle();
        FlutterError.onError = (FlutterErrorDetails details) {
          FlutterError.dumpErrorToConsole(details);
          if (kReleaseMode) {
            exit(1);
          }
        };
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {return LoginPage(); }
        )
        );
        break;
      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          ListTile(
            leading: Icon(d.icon),
            title: Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () {
              Navigator.pop(context);
              _onSelectItem(i);
            },
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                      getFullName()!
                  ),
                  accountEmail: Text(
                      getEmail()!
                  ),
                  currentAccountPicture: Image.network(
                      getImageUrl()!
                  ),
                ),
                Column(children: drawerOptions)
              ],
            ),
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
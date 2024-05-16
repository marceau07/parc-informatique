import 'package:flutter/material.dart';

import 'os_pages/add_os.dart';
import 'os_pages/list_os.dart';

class OsScreen extends StatefulWidget {
  const OsScreen({super.key});

  @override
  _OsScreenState createState() => _OsScreenState();
}

class _OsScreenState extends State {
  int _selectedDrawerIndex = 0;
  late IconData icon;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return const OSListPage();
      case 1:
        return const AddOS();
      default:
        return const Text("");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedDrawerIndex,
        onTap: (int index) {
          setState(() {
            _selectedDrawerIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Liste des OS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: "Ajouter un OS",
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
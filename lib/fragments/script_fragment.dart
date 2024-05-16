import 'package:flutter/material.dart';
import 'scripts_pages/list_scripts.dart';
import 'scripts_pages/add_script.dart';

class ScriptScreen extends StatefulWidget{
  const ScriptScreen({super.key});

  @override
  _ScriptScreenState createState() => _ScriptScreenState();
}

class _ScriptScreenState extends State {
  int _selectedDrawerIndex = 0;
  late IconData icon;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return const ScriptListPage();
      case 1:
        return const AddScript();
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedDrawerIndex,
        onTap: (int index){
          setState(() {
            _selectedDrawerIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Liste des scripts'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Ajouter un script'
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
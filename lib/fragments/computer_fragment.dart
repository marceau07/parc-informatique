import 'package:flutter/material.dart';

import 'computer_pages/list_all_computers.dart';
import 'computer_pages/list_networksComputers.dart';
import 'computer_pages/pdf_all_computers.dart';

class ComputerScreen extends StatefulWidget{
  const ComputerScreen({super.key});

  @override
  _ComputerScreenState createState() => _ComputerScreenState();
}

class _ComputerScreenState extends State {
  int _selectedDrawerIndex = 0;
  late IconData icon;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return const AllComputersPage();
      case 1:
        return const NetworkListPage();
      case 2:
        return AllComputersPdf();
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
              label: 'Tous les PC'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.network_cell),
              label: 'Réseaux disponibles'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'PDF',
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
import 'package:flutter/material.dart';

import '../pages/sign_in_page.dart';
import 'account_pages/settings_account.dart';
import 'account_pages/view_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State {
  int _selectedDrawerIndex = 0;
  late IconData icon;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0:
        return const AccountViewPage();
      case 1:
        return const AccountSettingsPage();
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.contacts),
            label: getFullName(),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
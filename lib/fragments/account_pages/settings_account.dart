import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  _AccountSettingsPage createState() => _AccountSettingsPage();
}

class _AccountSettingsPage extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Langue "),
                Text("Francais"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
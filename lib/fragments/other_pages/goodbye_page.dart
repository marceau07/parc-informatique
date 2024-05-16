import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../pages/login_page.dart';

class GoodBye extends StatefulWidget {
  const GoodBye({super.key});

  @override
  _GoodByeState createState() => _GoodByeState();
}

class _GoodByeState extends State<GoodBye> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              ElevatedButton(
                  child: const Text("Retourner sur l'écran de connexion"),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  }),
              ElevatedButton(
                child: const Text("Fermer l'application"),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    Exit();
                    throw '';
                  }));
                },
              ),
            ],
          ),
          Flushbar(
            title: 'A bientôt...',
            message: 'Votre désinscription a bien été prise en compte.',
            icon: Icon(
              Icons.info_outline,
              size: 28,
              color: Colors.orange.shade300,
            ),
            leftBarIndicatorColor: Colors.orange.shade300,
            duration: const Duration(seconds: 3),
          )..show(context),
        ],
      ),
    ));
  }

  void Exit() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

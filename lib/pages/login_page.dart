import 'package:flutter/material.dart';
import 'package:parc_informatique/pages/sign_in_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset('assets/logo.png', width: 150, height: 150,),
            const SizedBox(height: 50),
            _signInButtonGoogle(),
          ],
        ),
      ),
    );
  }

  Widget _signInButtonGoogle(){
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        elevation: WidgetStateProperty.all(0.0),
        side: WidgetStateProperty.all(const BorderSide(color: Colors.blue))
      ),
      onPressed: () {
        signInWithGoogle().whenComplete((){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context){
                return HomePage();
              },
            ),
          );
        });
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Continuer avec Google",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
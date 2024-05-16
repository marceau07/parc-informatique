// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'index_pages/canvas_computers.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  IndexFragment createState() => IndexFragment();
}

class IndexFragment extends State<IndexScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController textEditingController = TextEditingController();
  final List<String> _networks = <String>['', '19', '20'];
  String _network = '';

  void main() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      if (kReleaseMode) exit(1);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.network_cell),
                          labelText: 'Choisir l\'identifiant du réseau',
                        ),
                        isEmpty: _network == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _network,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                _network = value!;
                                state.didChange(value);
                              });
                            },
                            items: _networks.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (value){
                      if(value == null || value == ''){
                        return 'Veuillez entrer une valeur valide.';
                      }
                      return null;
                    },
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            backgroundColor: Colors.grey[300],
                            minimumSize: const Size(88, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                        ),
                        child: const Text('Afficher le réseau'),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CanvasPage(theNetwork: _network,)
                            ));
                          }
                        },
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}
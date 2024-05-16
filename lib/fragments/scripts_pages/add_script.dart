import 'package:flutter/material.dart';

class AddScript extends StatefulWidget {
  const AddScript({super.key});

  @override
  AddAScript createState(){
    return AddAScript();
  }
}

class AddAScript extends State<AddScript>{
  final _formKey = GlobalKey<FormState>();
  final scriptNameController = TextEditingController();
  final scriptDescController = TextEditingController();
  final scriptVersionController = TextEditingController();
  List<DropdownMenuItem<int>> osList = [];

  late int _selectedOS;

  void loadOSList(){
    osList = [];
    osList.add(const DropdownMenuItem(
      value: 1,
      child: Text("Windows"),
    ));
    osList.add(const DropdownMenuItem(
      value: 2,
      child: Text("Linux"),
    ));
    osList.add(const DropdownMenuItem(
      value: 3,
      child: Text("Mac OS"),
    ));
  }

  @override
  void dispose() {
    scriptNameController.dispose();
    scriptDescController.dispose();
    scriptVersionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadOSList();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text(
            "Ajouter un script",
            style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nom du script',
              hintText: 'Nom du script',
            ),
            validator: (value) {
              if(value!.isEmpty){
                return 'Veuillez entrer une valeur valide.';
              }
              return null;
            },
            controller: scriptNameController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description du script',
              hintText: 'Description du script',
            ),
            validator: (value) {
              if(value!.isEmpty){
                return 'Veuillez entrer une valeur valide.';
              }
              return null;
            },
            controller: scriptDescController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Version du script',
              hintText: 'Version du script',
            ),
            validator: (value) {
              if(value!.isEmpty){
                return 'Veuillez entrer une valeur valide.';
              }
              return null;
            },
            controller: scriptVersionController,
          ),
          DropdownButton(
            hint: const Text("Quel OS ?"),
            items: osList.toList(),
            value: _selectedOS,
            onChanged: (value){
              setState(() {
                _selectedOS = value!;
              });
            },
            isExpanded: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Téléversement des données pour ${scriptNameController.text}")));
                }
              },
              child: const Text('Envoyer'),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
User? _user;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken, accessToken: googleSignInAuthentication?.accessToken);

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User? user = authResult.user;
  _user = user;

  assert(!user!.isAnonymous);
  assert(await user?.getIdToken() != null);

  final User currentUser = _auth.currentUser!;
  assert(user?.uid == currentUser.uid);

  print('$user'.toString());
  addUserToDb();
  return "signInWithGoogle succeeded: $user";

}

String? getEmail(){
  if(_user != null){
    return _user!.email;
  }
  else{
    return "Utilisateur non connecté";
  }
}

String? getFullName(){
  if(_user != null){
    String? name = _user!.displayName;

    return name;
  }
  else {
    return "Utilisateur non connecté";
  }
}

Future getFirstName() async {
  final Uri uri = ('http://portfolio.marceau-rodrigues.fr/parcinformatique/web/index.php?page=myFirstName&fullName=${getFullName()}') as Uri;

  var response = await http.get(uri);

  if(response.statusCode == 200) {
    final item = json.decode(response.body);

    var message = item['message'];
  }
}

Future getLastName() async {
  final Uri uri = ('http://portfolio.marceau-rodrigues.fr/parcinformatique/web/index.php?page=myLastName&fullName=${getFullName()}') as Uri;

  var response = await http.get(uri);

  if(response.statusCode == 200) {
    final item = json.decode(response.body);

    var message = item['message'];
  }
}

String? getImageUrl(){
  if(_user != null) {
    return _user!.photoURL;
  } else {
    return "Erreur lors de la récupération de l\'image";
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

Future addUserToDb() async {
  final Uri uri = 'http://portfolio.marceau-rodrigues.fr/parcinformatique/web/index.php?page=signIn&email=${getEmail()}&fullName=${getFullName()}' as Uri;
  var response = await http.get(uri);

  if(response.statusCode == 200) {
    final item = json.decode(response.body);
  }
}
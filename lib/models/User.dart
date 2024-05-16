class User {
  String id;
  String pseudo;
  String fonction;
  String mdpUtilisateur;
  String titre;

  User({required this.id, required this.pseudo, required this.fonction, required this.mdpUtilisateur, required this.titre});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        pseudo: json['pseudo'],
        fonction: json['fonction'],
        mdpUtilisateur: json['mdpUtilisateur'],
        titre: json['titre']
    );
  }
}
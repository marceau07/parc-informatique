class Employee{
  String idEmploye;
  String email;
  String nomEmploye;
  String prenomEmploye;
  String descriptionRole;

  Employee({required this.idEmploye, required this.email, required this.nomEmploye, required this.prenomEmploye, required this.descriptionRole});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      idEmploye: json['idEmploye'],
      email: json['email'],
      nomEmploye: json['nomEmploye'],
      prenomEmploye: json['prenomEmploye'],
      descriptionRole: json['descriptionRole'],
    );
  }
}
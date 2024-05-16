class Computer{
  String idOrdinateur;
  String ip;
  String mac;
  String reseau;
  String nomOs;
  String nomStatut;
  String unEmploye;

  Computer({required this.idOrdinateur, required this.ip, required this.mac, required this.reseau, required this.nomOs, required this.nomStatut, required this.unEmploye});

  factory Computer.fromJson(Map<String, dynamic> json) {
    return Computer(
        idOrdinateur: json['idOrdinateur'],
        ip: json['ip'],
        mac: json['mac'],
        reseau: json['reseau'],
        nomOs: json['nomOs'],
        nomStatut: json['nomStatut'],
        unEmploye: json['unEmploye']
    );
  }
}
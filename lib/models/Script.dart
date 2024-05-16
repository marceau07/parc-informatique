class Script {

  String  idScript;
  String  nomScript;
  String  version;
  String  descScript;
  String  idOS;
  String  nomOS;
  String  fichierScript;

  Script({required this.idScript, required this.nomScript, required this.version, required this.descScript, required this.idOS, required this.nomOS, required this.fichierScript});

  factory Script.fromJson(Map<String, dynamic> json){
    return Script(
        idScript: json['idScript'],
        nomScript: json['nomScript'],
        version: json['version'],
        descScript: json['descScript'],
        idOS: json['idOs'],
        nomOS: json['nomOs'],
        fichierScript: json['fichierScript']
    );
  }
}
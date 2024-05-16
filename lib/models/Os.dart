class OS{
  String idOs;
  String nomOs;

  OS({required this.idOs, required this.nomOs});

  factory OS.fromJson(Map<String, dynamic> json) {
    return OS(
        idOs: json['idOs'],
        nomOs: json['nomOs']
    );
  }
}
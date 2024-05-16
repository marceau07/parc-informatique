class Network {
  String reseau;

  Network({required this.reseau});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
        reseau: json['reseau']
    );
  }
}
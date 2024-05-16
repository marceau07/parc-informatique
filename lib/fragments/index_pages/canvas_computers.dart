import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/Computer.dart';

class CanvasPage extends StatefulWidget{
  final String theNetwork;
  const CanvasPage({super.key, required this.theNetwork});

  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage>{
  static int sizeComputersList = 0;

  Future<List<Computer>> fetchComputers() async {
    String chosenNetwork = widget.theNetwork;
    final Uri url = ('http://serveur1.arras-sio.com/symfony4-4017/public/parcinformatique/web/index.php?page=computersJSON&networkId=$chosenNetwork') as Uri;
    var response = await http.get(url);

    if(response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Computer> listOfComputers = items.map<Computer>((json){
        return Computer.fromJson(json);
      }).toList();

      sizeComputersList = listOfComputers.length;
      return listOfComputers;
    } else {
      throw Exception('Une erreur s\'est produite.');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void main() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      if(kReleaseMode) exit(1);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Réseau 192.168.${widget.theNetwork}.0"),),
      body: FutureBuilder<List<Computer>>(
        future: fetchComputers(),
        builder: (context, snapshot){

          /// Affiche un squelette tant que les données ne sont pas récuperées
          if(!snapshot.hasData) {
            return ListView(
            children: <Widget>[
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: <int>[0, 1, 2, 3, 4, 5, 6, 7]
                        .map((_) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0, right: 10.0, left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48.0,
                            height: 48.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              )
            ],
          );
          }

          /// Si table vide dans la BDD
          if(snapshot.data!.isEmpty){
            return const Center(
              child: Text(
                  "Aucun PC à afficher"
              ),
            );
          }

          return Row(
            children: <Widget>[
              const VerticalDivider(
                color: Colors.black,
                thickness: 3,
                width: 20,
                indent: 15,
                endIndent: 15,
              ),
              CustomPaint(painter: DrawHorizontalLine(widget.theNetwork, sizeComputersList),),
            ],
          );
        },
      ),
    );
  }
}

class DrawHorizontalLine extends CustomPainter{
  Paint _paint = Paint();
  String theNetwork = "0";
  int sizeComputersList = 0;
  DrawHorizontalLine(String theNetwork, int sizeList){
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    this.theNetwork = theNetwork;
    this.sizeComputersList = sizeList;
  }

  @override
  void paint(Canvas canvas, Size size){
    switch(sizeComputersList){
      case 1:              //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, 0.0), const Offset(200.0, 0.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 2:              //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -142.5), const Offset(200.0, -142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 142.5), const Offset(200.0, 142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 3:              //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -190.0), const Offset(200.0, -190.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 0.0), const Offset(200.0, 0.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 190.0), const Offset(200.0, 190.0), _paint);
        fillTexts("slt", canvas, sizeComputersList);
        break;
      case 4:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -200.5), const Offset(200.0, -200.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -71.25), const Offset(200.0, -71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 71.25), const Offset(200.0, 71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 200.5), const Offset(200.0, 200.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 5:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, 114.0), const Offset(200.0, -114.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -57.0), const Offset(200.0, -57.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 0.0), const Offset(200.0, 0.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 57.0), const Offset(200.0, 57.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 114.0), const Offset(200.0, 114.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 6:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -95.0), const Offset(200.0, -95.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -47.5), const Offset(200.0, -47.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -23.75), const Offset(200.0, -23.75), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 23.75), const Offset(200.0, 23.75), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 47.5), const Offset(200.0, 47.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 95.0), const Offset(200.0, 95.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 7:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -95.0), const Offset(200.0, -95.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -47.5), const Offset(200.0, -47.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -23.75), const Offset(200.0, -23.75), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 0.0), const Offset(200.0, 0.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 23.75), const Offset(200.0, 23.75), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 47.5), const Offset(200.0, 47.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 95.0), const Offset(200.0, 95.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 8:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -142.5), const Offset(200.0, -142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -71.25), const Offset(200.0, -71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -35.625), const Offset(200.0, -35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -17.8125), const Offset(200.0, -17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 17.8125), const Offset(200.0, 17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 35.625), const Offset(200.0, 35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 71.25), const Offset(200.0, 71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 142.5), const Offset(200.0, 142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 9:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -142.5), const Offset(200.0, -142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -71.25), const Offset(200.0, -71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -35.625), const Offset(200.0, -35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -17.8125), const Offset(200.0, -17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 0.0), const Offset(200.0, 0.0), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 17.8125), const Offset(200.0, 17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 35.625), const Offset(200.0, 35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 71.25), const Offset(200.0, 71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 142.5), const Offset(200.0, 142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
      case 10:                //width, height start || width, height end
        canvas.drawLine(const Offset(-10.0, -142.5), const Offset(200.0, -142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -71.25), const Offset(200.0, -71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -35.625), const Offset(200.0, -35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -17.8125), const Offset(200.0, -17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, -8.90625), const Offset(200.0, -8.90625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 8.90625), const Offset(200.0, 8.90625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 17.8125), const Offset(200.0, 17.8125), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 35.625), const Offset(200.0, 35.625), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 71.25), const Offset(200.0, 71.25), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        canvas.drawLine(const Offset(-10.0, 142.5), const Offset(200.0, 142.5), _paint);
        fillTexts("essai", canvas, sizeComputersList);
        break;
    }
  }

  void fillTexts(String ip, Canvas canvas, int pos){
    final textStyle = ui.TextStyle(color: Colors.black, fontSize: 25,);
    final paragraphStyle = ui.ParagraphStyle(textDirection: TextDirection.ltr,);
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)..pushStyle(textStyle)..addText(ip);
    const constraints = ui.ParagraphConstraints(width: 300);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    const offset = Offset(285, 50);
    canvas.drawParagraph(paragraph, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
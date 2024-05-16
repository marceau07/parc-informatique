import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AllComputersPdf extends StatefulWidget {
  @override
  _AllComputersPdfState createState() => _AllComputersPdfState();
}

class _AllComputersPdfState extends State<AllComputersPdf>{
  String urlPDFPath = "";

  @override
  void initState() {
    super.initState();
    getFileFromUrl("https://parc-informatique.marceau-rodrigues.fr/index.php?page=listeOrdinateurPdf" as Uri).then((f){
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);
      });
    });
  }

  Future<File> getFileFromUrl(Uri url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ComputersPdfViewPage(path: urlPDFPath,);
  }
}

class ComputersPdfViewPage extends StatefulWidget {
  final String path;

  const ComputersPdfViewPage({super.key, required this.path});

  @override
  _ComputersPdfViewPageState createState() => _ComputersPdfViewPageState();
}

class _ComputersPdfViewPageState extends State<ComputersPdfViewPage> {
  bool pdfReady = false;
  int _totalPages = 0;
  int _currentPage = 0;
  late PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            onError: (e){
              if (kDebugMode) {
                print(e);
              }
            },
            onRender: (pages){
              setState(() {
                _totalPages = pages!;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc){
              _pdfViewController = vc;
            },
            onPageChanged: (int? page, int? total){
              setState(() {

              });
            },
            onPageError: (page, e){

            },
          ),
          !pdfReady ? const Center(child: CircularProgressIndicator()) : const Offstage(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0 ? FloatingActionButton.extended(
              onPressed: (){
                _currentPage -= 1;
                _pdfViewController.setPage(_currentPage);
              },
              label: Text("Go to ${_currentPage-1}")
          ) : const Offstage(),
          _currentPage < _totalPages ? FloatingActionButton.extended(
              onPressed: (){
                _currentPage += 1;
                _pdfViewController.setPage(_currentPage);
              },
              label: Text("Go to ${_currentPage+1}")
          ) : const Offstage(),
        ],
      ),
    );
  }
}

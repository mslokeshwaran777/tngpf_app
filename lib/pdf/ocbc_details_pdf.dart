import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;


Future<File> createOCBCPdf(List response, String directoryPath,year) async {


  final directory = Directory(directoryPath);
  if (!(await directory.exists())) {
    directory.createSync(recursive: true);
  }

  final pdf=pw.Document();
  pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          header: (context){
            return pw.Container(
                alignment: pw.Alignment.center,
                margin: pw.EdgeInsets.only(bottom: 20.0),
                padding: pw.EdgeInsets.only(bottom: 15.0),
                child: pw.Column(
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.only(bottom: 5.0),
                        width: PdfPageFormat.a4.width,
                        child: pw.Center(
                          child: pw.Text(
                            'OFFICE OF THE ACCOUNTANT GENERAL (A&E), TAMILNADU',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.0
                            ),
                            softWrap: true,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: PdfPageFormat.a4.width,
                        child: pw.Center(
                          child: pw.Text(
                            'STATEMENT OF OPENING AND CLOSING BALANCE FOR YEAR $year',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.0
                            ),
                            softWrap: true,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                    ]
                )
            );
          },
          build: (context)=>[
            pw.Padding(
            child:pw.Container(
              width: 0.65*PdfPageFormat.a4.width,
            child : pw.Center(child:pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.center,
              cellHeight: 40.0,
              columnWidths: {
                0: pw.FixedColumnWidth(130.0),
                1: pw.FixedColumnWidth(130.0),
                2: pw.FixedColumnWidth(130.0),
              },
              context: context,
              headers: ['Category', 'Opening Balance', 'Closing Balance'],
              data: [
                ['GPF','${response[0]['GPF']}','${response[1]['GPF']}'],
                ['PCA',response[0]['PCA']==null?'0':'${response[0]['PCA']}',response[1]['PCA']==null?'0':'${response[1]['PCA']}'],
                ['PCA2',response[0]['PCA2']==null?'0':'${response[0]['PCA2']}',response[1]['PCA2']==null?'0':'${response[1]['PCA2']}'],
                ['UGC',response[0]['UGC']==null?'0':'${response[0]['UGC']}',response[1]['UGC']==null?'0':'${response[1]['UGC']}'],
                ['UGC2',response[0]['UGC2']==null?'0':'${response[0]['UGC2']}',response[1]['UGC2']==null?'0':'${response[1]['UGC2']}'],
                ['IDA3',response[0]['IDA3']==null?'0':'${response[0]['IDA3']}',response[1]['IDA3']==null?'0':'${response[1]['IDA3']}'],
                ['UG2',response[0]['UG2']==null?'0':'${response[0]['UG2']}',response[1]['UG2']==null?'0':'${response[1]['UG2']}'],
              ]
            ),),), padding: pw.EdgeInsets.only(left: 45.0)),
          ]
      )
  );

  final Uint8List data = await pdf.save();
  final buffer = data.buffer.asUint8List();
  final filename='OpeningClosing ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}(${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().microsecond})';
  final filePath = path.join(directory.path, '$filename.pdf');
  final file = File(filePath);
  await file.writeAsBytes(buffer);

  print("PDF created successfully at: $filePath");
  return file;
}


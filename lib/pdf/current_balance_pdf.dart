import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;



Future<File> createcurPdf(List response, String directoryPath) async {


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
                            'CURRENT BALANCE STATEMENT',
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
            pw.Table.fromTextArray(
              cellAlignment: pw.Alignment.center,
              cellHeight: 40.0,
              columnWidths: {
                0: pw.FixedColumnWidth(200.0),
                1: pw.FixedColumnWidth(150.0),
                2: pw.FixedColumnWidth(60.0),
                3: pw.FixedColumnWidth(60.0),
                4: pw.FixedColumnWidth(60.0),
                5: pw.FixedColumnWidth(60.0),
                6: pw.FixedColumnWidth(60.0),
                7: pw.FixedColumnWidth(60.0),
              },
              context: context,
              headers: ['Category', 'GPF', 'PCA', 'PCA2', 'UGC', 'UGC2', 'IDA3','UG2'],
              data: List<List<String>>.generate(
                response.length,
                    (index) => [
                  '${response[index]['Category']}',
                  '${response[index]['GPF'].toInt()}',
                  response[index]['PCA']==null?'0':
                  '${response[index]['PCA']}0',
                  response[index]['PCA2']==null?'0':
                  '${response[index]['PCA2']}0',
                  response[index]['UGC']==null?'0':
                  '${response[index]['UGC']}0',
                  response[index]['UGC2']==null?'0':
                  '${response[index]['UGC2']}0',
                  response[index]['IDA3']==null?'0':
                  '${response[index]['IDA3']}0',
                  response[index]['UG2']==null?'0':
                  '${response[index]['UGC']}0',
                ],
              ),
            ),
          ]
      )
  );

  final Uint8List data = await pdf.save();
  final buffer = data.buffer.asUint8List();
  final filename='CurrentBalance ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}(${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().microsecond})';
  final filePath = path.join(directory.path, '$filename.pdf');
  final file = File(filePath);
  await file.writeAsBytes(buffer);

  print("PDF created successfully at: $filePath");
  return file;
}


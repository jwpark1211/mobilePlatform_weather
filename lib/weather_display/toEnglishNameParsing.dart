import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Excel Reader'),
        ),
        body: const ExcelReaderWidget(),
      ),
    );
  }
}

class ExcelReaderWidget extends StatefulWidget {
  const ExcelReaderWidget({super.key});

  @override
  _ExcelReaderWidgetState createState() => _ExcelReaderWidgetState();
}

class _ExcelReaderWidgetState extends State<ExcelReaderWidget> {
  List<String> names = [];
  List<String> englishs = [];

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  Future<void> _loadExcelData() async {
    // assets/regions.xlsx 파일 읽기
    ByteData data = await rootBundle.load('assets/regions.xlsx');
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    // 'Sheet1' 시트에서 'name' 컬럼의 'english' 값을 추출
    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]?.maxCols); //2
      print(excel.tables[table]?.maxRows); //173
      for (var row in excel.tables[table]!.rows) {
        var nameCell = row[0]; // name
        var englishCell = row[1]; // english
        if (nameCell != null && englishCell != null) {
          names.add(nameCell.value.toString());
          englishs.add(englishCell.value.toString());
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: englishs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(names[index]), // name
          subtitle: Text(englishs[index]), // english
        );
      },
    );
  }
}

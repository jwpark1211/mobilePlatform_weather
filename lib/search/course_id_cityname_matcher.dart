import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CourseIdAndSpotAreaNameMatcher {
  //final String txtFilePath = "assets/기상청27_관광코스별_관광지_지점정보memo.txt";
  final String csvFilePath = "assets/기상청27_관광코스별_관광지_지점정보_courseId_정렬.csv";
  Map<String, String> mapper = {};

  CourseIdAndSpotAreaNameMatcher() {
    loadMapper();
  }

  // 전체 매핑 불러오기
  // 전체 매핑 불러오기
  Future<void> loadMapper() async {
    print("loadMapper 실행----------");
    try {
      // CSV 파일 읽기
      final csvBytes = await rootBundle.load(csvFilePath);
      final csvString = utf8.decode(csvBytes.buffer.asUint8List());

      // CSV 데이터 파싱
      List<List<dynamic>> fields =
          const CsvToListConverter(eol: '\n').convert(csvString);

      // CSV 데이터 읽기 (첫 번째 행은 헤더로 가정)
      var spotAreaNames = <String>{};
      for (var row in fields) {
        var courseId = row[1]; // 코스 아이디 (2번째 열)
        var spotAreaName = filterRawSpotName(row[4]); // spotAreaName (5번째 열)

        // 중복되지 않은 경우에만 저장
        if (spotAreaNames.add(spotAreaName)) {
          // 지역 명을 key로, 코스 아이디를 조회할 수 있도록.
          mapper[spotAreaName.toString()] = courseId.toString();
          // print("$spotAreaName: ${mapper[spotAreaName]}");
        }
      }
      // 결과 출력
      mapper.forEach((key, value) {
        print('spotAreaName: $key, 코스 아이디: $value\n');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  // 지역 이름으로 course_id 값 받아오기
  String getCourseId(String spotAreaName) {
    if (mapper[spotAreaName] == null) {
      return "null";
    }
    return mapper[spotAreaName]!;
  }

  String filterRawSpotName(String rawData) {
    // 정규 표현식 패턴: 괄호 안의 내용을 캡처하는 그룹
    RegExp regExp = RegExp(r'\(([^)]+)\)');
    RegExpMatch? match = regExp.firstMatch(rawData);

    if (match != null) {
      // 캡처된 그룹 (괄호 안의 내용) 추출
      String extracted = match.group(1)!;
      return extracted;
    } else {
      return "Error";
    }
  }
}

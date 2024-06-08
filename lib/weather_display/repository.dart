import 'package:final_project/search/course_id_cityname_matcher.dart';
import 'package:final_project/weather_display/weather_model.dart';
import 'package:xml/xml.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class WeatherStaticsRepository {
  late var _dio;
  String course_id = "1"; // default 값이 1
  CourseIdAndSpotAreaNameMatcher matcher = CourseIdAndSpotAreaNameMatcher();

  WeatherStaticsRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://apis.data.go.kr',
    ));
  }

  Future<List<Weather_Model>> fetchWeatherStatices(String courseId) async {
    List<Weather_Model> weatherStatics = [];
    DateTime now = DateTime.now();
    print("CourseId_fetchWeatherStatices  : $courseId");
    for (int i = 0; i < 5; i++) {
      DateTime targetTime = now.add(Duration(hours: i * 3));
      String formattedDate = DateFormat('yyyyMMdd').format(targetTime);
      String formattedHour = DateFormat('HH').format(targetTime);
      var response = await _dio.get(
          '/1360000/TourStnInfoService1/getTourStnVilageFcst1?ServiceKey=EL4nXNg4uPw0MvmMFz5T9mbWclizyQGVH8kn4cR4Q1a06fw8gHnwU%2BcpFI1uW%2Bt27XKrYOm%2F0RIQUm3UbY2Gfg%3D%3D&pageNo=1&numOfRows=1&dataType=XML&CURRENT_DATE=$formattedDate&HOUR=$formattedHour&COURSE_ID=$courseId');
      final document = XmlDocument.parse(response.data);
      final items = document.findAllElements('item');
      print("\n items \n $items\n");
      for (var element in items) {
        weatherStatics.add(Weather_Model.fromXml(element));
      }
    }

    return weatherStatics;
  }

  // 32211034 김종빈
  // 특정 지역 데이터 불러오기
  Future<List<Weather_Model>> fetchSpecificAreaWeatherData(
      String spotAreaName) async {
    String courseId = matcher.getCourseId(spotAreaName);
    print('courseId: $courseId');
    List<Weather_Model> weatherStatics = [];
    DateTime now = DateTime.now();

    for (int i = 1; i < 5; i++) {
      DateTime targetTime = now.add(Duration(hours: i * 3));
      String formattedDate = DateFormat('yyyyMMdd').format(targetTime);
      String formattedHour = DateFormat('HH').format(targetTime);

      var response = await _dio.get(
          '/1360000/TourStnInfoService1/getTourStnVilageFcst1?ServiceKey=EL4nXNg4uPw0MvmMFz5T9mbWclizyQGVH8kn4cR4Q1a06fw8gHnwU%2BcpFI1uW%2Bt27XKrYOm%2F0RIQUm3UbY2Gfg%3D%3D&pageNo=1&numOfRows=1&dataType=XML&CURRENT_DATE=$formattedDate&HOUR=$formattedHour&COURSE_ID=$courseId');

      final document = XmlDocument.parse(response.data);
      final items = document.findAllElements('item');

      for (var element in items) {
        weatherStatics.add(Weather_Model.fromXml(element));
      }
    }

    return weatherStatics;
  }
}

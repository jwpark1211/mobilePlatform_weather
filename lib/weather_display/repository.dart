import 'package:final_project/weather_display/weather_model.dart';
import 'package:xml/xml.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class WeatherStaticsRepository {
  late var _dio;

  WeatherStaticsRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://apis.data.go.kr',

    ));
  }

  Future<List<Weather_Model>> fetchWeatherStatices() async {
    List<Weather_Model> weatherStatics = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      DateTime targetTime = now.add(Duration(hours: i * 3));
      String formattedDate = DateFormat('yyyyMMdd').format(targetTime);
      String formattedHour = DateFormat('HH').format(targetTime);
      var response = await _dio.get('/1360000/TourStnInfoService1/getTourStnVilageFcst1?ServiceKey=EL4nXNg4uPw0MvmMFz5T9mbWclizyQGVH8kn4cR4Q1a06fw8gHnwU%2BcpFI1uW%2Bt27XKrYOm%2F0RIQUm3UbY2Gfg%3D%3D&pageNo=1&numOfRows=1&dataType=XML&CURRENT_DATE=${formattedDate}&HOUR=${formattedHour}&COURSE_ID=110');
      final document = XmlDocument.parse(response.data);
      final items = document.findAllElements('item');
      print("\n items \n $items\n");
      for (var element in items) {
        weatherStatics.add(Weather_Model.fromXml(element));
      }
    }

    return weatherStatics;
  }
}

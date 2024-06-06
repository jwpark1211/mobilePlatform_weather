import 'package:final_project/weather_display/weather_model.dart';
import 'package:xml/xml.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class WeatherStaticsRepository {
  late var _dio;

  WeatherStaticsRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://apis.data.go.kr',
      queryParameters: {
        'serviceKey':
            'xRutx4QcOkh7i5R%2B9sbhEvws16VP3ca786c%2BO%2Bmv4rRF1BzlN4P0W76aP49RDKx2xs7mrhq%2BuogGox6q%2Bll2gw%3D%3D',
        'pageNo': '1',
        'numOfRows': '2',
        'dataType': 'XML',
        'COURSE_ID': '3',
      },
    ));
  }

  Future<List<Weather_Model>> fetchWeatherStatices() async {
    List<Weather_Model> weatherStatics = [];
    DateTime now = DateTime.now();

    for (int i = 1; i < 5; i++) {
      DateTime targetTime = now.add(Duration(hours: i * 3));
      String formattedDate = DateFormat('yyyyMMdd').format(targetTime);
      String formattedHour = DateFormat('HH').format(targetTime);
      print("\nformattedHour : $formattedHour\n");
      var response = await _dio.get(
          '/1360000/TourStnInfoService1/getTourStnVilageFcst1',
          queryParameters: {
            'CURRENT_DATE': formattedDate,
            'HOUR': formattedHour,
          });

      final document = XmlDocument.parse(response.data);
      final items = document.findAllElements('item');

      for (var element in items) {
        weatherStatics.add(Weather_Model.fromXml(element));
      }
    }

    return weatherStatics;
  }
}

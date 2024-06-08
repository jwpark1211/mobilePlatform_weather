import 'package:final_project/weather_display/repository.dart';
import 'package:final_project/weather_display/weather_model.dart';
import 'package:get/get.dart';

class WeatherStaticsController extends GetxController {
  late WeatherStaticsRepository _weatherRepository;
  RxList<Weather_Model> weatherStatics = <Weather_Model>[].obs;
  RxBool isLoadingComplete = false.obs; // 데이터 로드 완료 추적

  WeatherStaticsController(String courseId) {
    print("CourseId_WeatherStaticsRepository  : $courseId");
    _weatherRepository = WeatherStaticsRepository();
    fetchWeatherState(courseId);
    print("Controller Init complete");
  }

  @override
  void onInit() {
    super.onInit();
    _weatherRepository = WeatherStaticsRepository();
    //fetchWeatherState();
    print("Controller Init complete");
  }

  void fetchWeatherState(String courseId) async {
    List<Weather_Model> result =
        await _weatherRepository.fetchWeatherStatices(courseId);
    if (result.isNotEmpty) {
      print("result: ${result[1].wd}");
      weatherStatics.assignAll(result); // result 전체를 설정
      print("length: ${weatherStatics.length}");
      isLoadingComplete.value = true;
    }
  }
}

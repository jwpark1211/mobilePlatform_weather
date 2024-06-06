import 'package:final_project/weather_display/repository.dart';
import 'package:final_project/weather_display/weather_model.dart';
import 'package:get/get.dart';

class WeatherStaticsController extends GetxController {
  late weatherStaticsRepository _weatherRepository;
  RxList<wheather_Model> weatherStatics = <wheather_Model>[].obs;
  RxBool isLoadingComplete = false.obs; // 데이터 로드 완료 추적

  @override
  void onInit() {
    super.onInit();
    _weatherRepository = weatherStaticsRepository();
    fetchWeatherState();
    print("Controller Init complete");
  }

  void fetchWeatherState() async {
    List<wheather_Model> result = await _weatherRepository.fetchWeatherStatices();
    if (result.isNotEmpty) {
      print("result: ${result[0].spotName}");
      weatherStatics.assignAll(result);// result 전체를 설정
      isLoadingComplete.value = true;
    }
  }
}

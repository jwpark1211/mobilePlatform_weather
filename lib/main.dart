import 'package:get/get.dart';
import 'package:final_project/appbar.dart';
import 'package:final_project/search/search_page.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'weather_service.dart';
import 'weather_model.dart';
import 'weather_card.dart';
import 'tour_list.dart';
import 'dart:math';

/* 홈화면입니다.
*  크게 세 분류로 분리됩니다.
*  1) 검색창 TextField + 메뉴 Icon(북마크로 이동)
*  2) 지금 __의 날씨는? : 랜덤으로 관광지(서울/제주/부산/대전/인천/광주/강릉) 날씨 정보를 얻어옴
*    -> weather_service.dart(openweathermap api 연동)
*    -> weather_model.dart(얻어온 데이터에 대한 weather model)
*    -> weather_card.dart(받아온 데이터를 어느 위치에 넣을 것인지 결정하는 카드)
* ----> 날씨 화면은 따로 기상청 api 연동하셔도 되고 openweathermap 그대로 사용하셔도 될 것 같습니다.
*       (주간 날씨 및 날씨 아이콘 정보도 제공)
*       다만 도시 이름을 영어 param으로 보내야 해서 도시명 한->영 변환이 필요할 것 같습니다!
*  3) 추천 관광지
*    -> tour_list.dart(관광지 데이터 들어간 GridView -> 데이터는 하드코딩)
* */

/*openweathermap api response field
   weather -> id(날씨 상태 ID), main(날씨 상태 그룹),description(날씨 상태 설명),icon(날씨 아이콘 id)
   main ->  temp(현재기온, 섭씨), feels_like(체감 기온), temp_min(최저 기온), temp_max(최대 기온),
            pressure(기압, 단위: hPa), humidity(습도)
   wind -> speed(풍속, m/s), deg(바람 방향, 각도)
   clouds -> all(구름량 %)
   sys -> country(국가 코드, ex.kr), sunrise(일출 시간), sunset(일몰 시간)
   cod -> 응답코드(200,400,...)
* */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WeatherToday',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final WeatherService weatherService = WeatherService();
  final Map<String, String> cities = {
    'Seoul': '서울',
    'Jeju': '제주',
    'Daejeon': '대전',
    'Busan': '부산',
    'Gangneung': '강릉',
    'Incheon': '인천',
    'Gwangju': '광주',
  };

  late Future<Weather> futureWeather;
  late String selectedCity;
  late String selectedCityKorean;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchRandomWeather();
  }

  Future<Weather> fetchRandomWeather() async {
    final cityKeys = cities.keys.toList();
    // 시간에 따라 난수가 결정되도록 시드를 정의
    final seed = DateTime.now().millisecondsSinceEpoch;
    final random = Random(seed);
    selectedCity = cityKeys[random.nextInt(cityKeys.length)];
    selectedCityKorean = cities[selectedCity]!;
    return weatherService.fetchWeather(selectedCity);
  }

  void _searchCityWeather(String cityName) {
    setState(() {
      selectedCity = cityName;
      selectedCityKorean = cities[cityName]!;
      futureWeather = weatherService.fetchWeather(cityName);
    });
  }

  void _navigateToBookmark() {
    // Implement navigation to bookmark page
  }

  void _navigateToSearchPage(BuildContext context) async {
    Get.off(() => const SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바를 분리시킴.
      appBar: const WeatherAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                child: TextField(
                  onTap: () => _navigateToSearchPage(context),
                  decoration: InputDecoration(
                    hintText: '지역 검색',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFFADAEAF),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF012677),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color(0xFFEEF0F2),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                  ),
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(23.0, 0, 16.0, 0),
              child: Text(
                '지금 $selectedCityKorean의 날씨는?',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 16.0, 0),
              child: FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final weather = snapshot.data!;
                    return WeatherCard(weather: weather);
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 16.0, 0),
              child: Text(
                '추천 관광지',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TourList(),
            ),
          ],
        ),
      ),
    );
  }
}

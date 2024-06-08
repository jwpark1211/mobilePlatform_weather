import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../appbar.dart';
import '../main.dart';
import '../search/search_page.dart';
import 'controller.dart';

class WeatherDisplay extends StatelessWidget {
  String courseId;
  WeatherDisplay(this.courseId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder(
        future: () async {
          Get.put(WeatherStaticsController(courseId));
        }(),
        builder: (context, snapshot) {
          return const MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends GetView<WeatherStaticsController> {
  const MyHomePage({super.key});

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity, // 부모 위젯의 너비와 같게 설정
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            if (title == "코스 이름")
              Padding(
                padding: const EdgeInsets.only(top: 10.0), // 원하는 패딩 추가
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (title != "코스 이름")
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget hourlyForecastWidget(String time, String sky, String temperature,
      {Color textColor = Colors.black}) {
    return Column(
      children: [
        Text(
          time,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
        const SizedBox(height: 4),
        if (sky == "1") // info_now 값이 1인 경우 태양 이미지를 표시
          Image.asset(
            'assets/wheather_display_images/sun.png',
            width: 35,
            height: 35,
          ),
        if (sky == "2") // info_now 값이 2인 경우 흐린 이미지를 표시
          Image.asset(
            'assets/wheather_display_images/cloud.png',
            width: 35,
            height: 35,
          ),
        if (sky == "3") // info_now 값이 2인 경우 흐린 이미지를 표시
          Image.asset(
            'assets/wheather_display_images/clouds.png',
            width: 35,
            height: 35,
          ),
        if (sky == "4") // info_now 값이 2인 경우 흐린 이미지를 표시
          Image.asset(
            'assets/wheather_display_images/fog.png',
            width: 35,
            height: 35,
          ),
        if (sky == "5") // info_now 값이 2인 경우 흐린 이미지를 표시
          Image.asset(
            'assets/wheather_display_images/raining.png',
            width: 35,
            height: 35,
          ), // Placeholder for weather icon
        const SizedBox(height: 4),
        Text(
          temperature,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ],
    );
  }

  /*void _navigateToSearchPage2(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }*/
  void _navigateToSearchPage2() async {
    Get.offAll(() => const SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    //var weatherStaticsList = controller.weatherStatics.toList();
    //var info_now_spotName = controller.weatherStatics.isNotEmpty ? controller.weatherStatics[0].spotName.toString() : 'N/A';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // AppBar의 높이를 줄임
        child: Obx(() {
          if (controller.weatherStatics.isEmpty ||
              controller.weatherStatics[0].spotName == null) {
            return AppBar(
              backgroundColor: Colors.transparent, // AppBar 배경색을 투명하게 설정
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                // Column 상단 패딩을 추가해 공간 확보
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          // 뒤로가기(꺽새) 아이콘
                          onPressed: _navigateToSearchPage2,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          // 아이콘이 너무 가까이 붙지 않도록 오른쪽 여백 추가
                          child: Icon(Icons.menu, color: Colors.white),
                        ),
                      ],
                    ),
                    const CircularProgressIndicator(), // 데이터를 로드 중일 때 로딩 인디케이터 표시
                  ],
                ),
              ),
            );
          }

          return AppBar(
            backgroundColor: Colors.transparent, // AppBar 배경색을 투명하게 설정
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              // Column 상단 패딩을 추가해 공간 확보
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        // 뒤로가기(꺽새) 아이콘
                        onPressed: _navigateToSearchPage2,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        // 아이콘이 너무 가까이 붙지 않도록 오른쪽 여백 추가
                        child: Icon(Icons.menu, color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    controller.weatherStatics[0].spotName.toString(),
                    style: const TextStyle(
                      fontSize: 25, // Desired font size
                      fontWeight: FontWeight.bold, // Desired font weight
                      color: Colors.white, // Desired font color
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlueAccent,
            Color.fromARGB(255, 137, 220, 254),
          ],
        )),
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          if (controller.weatherStatics.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          var infoNow = controller.weatherStatics[0];
          var infoOnehour = controller.weatherStatics[1];
          var infoTwohour = controller.weatherStatics[2];
          var infoThreehour = controller.weatherStatics[3];
          var infoFourhour = controller.weatherStatics[4];

          print("info_FourHour: ${infoFourhour.tm}");

          DateTime dateTime1 = DateTime.parse(infoOnehour.tm.toString());
          String time1 = DateFormat('HH:mm').format(dateTime1);

          DateTime dateTime2 = DateTime.parse(infoTwohour.tm.toString());
          String time2 = DateFormat('HH:mm').format(dateTime2);

          DateTime dateTime3 = DateTime.parse(infoThreehour.tm.toString());
          String time3 = DateFormat('HH:mm').format(dateTime3);

          DateTime dateTime4 = DateTime.parse(infoFourhour.tm.toString());
          String time4 = DateFormat('HH:mm').format(dateTime4);

          print(infoNow.sky);

          return ListView(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width, // 화면 너비와 같은 너비 설정
                  height: 130, // 원하는 높이 설정
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (infoNow.sky == "1") // info_now 값이 1인 경우 태양 이미지를 표시
                        Image.asset(
                          'assets/wheather_display_images/sun.png',
                          width: 100,
                          height: 100,
                        ),
                      if (infoNow.sky == "2") // info_now 값이 2인 경우 흐린 이미지를 표시
                        Image.asset(
                          'assets/wheather_display_images/cloud.png',
                          width: 100,
                          height: 100,
                        ),
                      if (infoNow.sky == "3") // info_now 값이 2인 경우 흐린 이미지를 표시
                        Image.asset(
                          'assets/wheather_display_images/clouds.png',
                          width: 100,
                          height: 100,
                        ),
                      if (infoNow.sky == "4") // info_now 값이 2인 경우 흐린 이미지를 표시
                        Image.asset(
                          'assets/wheather_display_images/fog.png',
                          width: 100,
                          height: 100,
                        ),
                      if (infoNow.sky == "5") // info_now 값이 2인 경우 흐린 이미지를 표시
                        Image.asset(
                          'assets/wheather_display_images/raining.png',
                          width: 100,
                          height: 100,
                        ),
                      Positioned(
                        bottom: -20, // 이미지 아래에 위치하도록 설정
                        right: 100, // 이미지 오른쪽에 위치하도록 설정
                        child: Container(
                          padding: const EdgeInsets.all(8.0), // 내부 여백 추가
                          child: Text(
                            '${infoNow.th3 ?? 'N/A'}°',
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // 텍스트 색상을 하얀색으로 변경
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: 150,
                // 너비 설정
                height: 120,
                // 높이 설정
                decoration: BoxDecoration(
                  color: const Color(0xFFB3E5FC), // 연한 하늘색
                  borderRadius: BorderRadius.circular(30), // 둥근 모서리
                ),
                padding: const EdgeInsets.all(16),
                // 내부 여백 조절
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    hourlyForecastWidget(time1, "${infoOnehour.sky}",
                        "${infoOnehour.th3 ?? 'N/A'}°",
                        textColor: Colors.white),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Color(0xffc7c7c7),
                      ),
                    ),
                    hourlyForecastWidget(time2, "${infoTwohour.sky}",
                        "${infoTwohour.th3 ?? 'N/A'}°",
                        textColor: Colors.white),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Color(0xffc7c7c7),
                      ),
                    ),
                    hourlyForecastWidget(time3, "${infoThreehour.sky}",
                        "${infoThreehour.th3 ?? 'N/A'}°",
                        textColor: Colors.white),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Color(0xffc7c7c7),
                      ),
                    ),
                    hourlyForecastWidget(time4, "${infoFourhour.sky}",
                        "${infoFourhour.th3 ?? 'N/A'}°",
                        textColor: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("테 마", infoNow.thema ?? 'N/A'),
                    ),
                  ),
                  Container(
                    width: 180, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("코스 이름", infoNow.courseName ?? 'N/A'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("강수확률", "${infoNow.pop ?? 'N/A'}%"),
                    ),
                  ),
                  Container(
                    width: 120, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("습도", "${infoNow.rhm ?? 'N/A'}%"),
                    ),
                  ),
                  Container(
                    width: 120, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("자외선 지수", "1"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("풍향", infoNow.wd ?? 'N/A'),
                    ),
                  ),
                  Container(
                    width: 180, // 너비 설정
                    height: 120, // 높이 설정
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100, // 연한 하늘색
                      borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: infoWidget("가시거리", "9km"),
                    ),
                  ),
                ],
              ),

              //infoWidget("일출 오전 5:56",  'N/A'),
              //infoWidget("일몰 오후 7:05", 'N/A'),
              //infoWidget("체감온도", info.th3 ?? 'N/A'),
              //infoWidget("습도", info.rhm ?? 'N/A'),
              //infoWidget("자외선 지수", "1"), // Assuming a static value here
              //infoWidget("풍향", info.wd ?? 'N/A'),
              //infoWidget("풍속", info.ws ?? 'N/A'),
              //infoWidget("가시거리", "9km"), // Assuming a static value here
              //infoWidget("강수확률", info.pop ?? 'N/A'),
            ],
          );
        }),
      ),
    );
  }
}

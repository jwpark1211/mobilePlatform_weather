import 'package:final_project/appbar.dart';
import 'package:final_project/weather_card.dart';
import 'package:final_project/weather_model.dart';
import 'package:final_project/weather_service.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<Weather>? result;
  final WeatherService weatherService = WeatherService();
  late Weather searchWeater;

  void _navigateToBookmark() {
    // Implement navigation to bookmark page
  }

  Future<Weather> _fetchWeatherAtSearchPage(String cityName) async {
    final weather = await weatherService.fetchWeather(cityName);
    setState(() {
      result = Future.value(weather);
    });
    return weather;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: const WeatherAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
            child: TextField(
              onSubmitted: _fetchWeatherAtSearchPage,
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
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          result == null
              ? const Text('검색 결과가 없습니다.')
              : FutureBuilder<Weather>(
                  future: result,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final weather = snapshot.data!;
                      return WeatherCard(weather: weather);
                    } else {
                      return const Text('검색 결과가 없습니다.');
                    }
                  },
                ),
        ],
      ),
    );
  }
}

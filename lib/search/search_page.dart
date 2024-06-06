import 'dart:ffi';

import 'package:final_project/appbar.dart';
import 'package:final_project/search/search_result_filtered.dart';
import 'package:final_project/weather_card.dart';
import 'package:final_project/weather_display/repository.dart';
import 'package:final_project/weather_display/weather_model.dart';
import 'package:final_project/weather_model.dart';
import 'package:final_project/weather_service.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final WeatherService weatherService = WeatherService();
  late Weather searchWeater;
  final WeatherStaticsRepository _weatherRepository =
      WeatherStaticsRepository();
  late List<Weather_Model> _weatherStatics = [];

  String searchText = "";

  @override
  void initState() {
    super.initState();
    _loadWeatherStatics();
  }

  void _loadWeatherStatics() async {
    _weatherStatics = await _weatherRepository.fetchWeatherStatices();
    setState(() {});
    print(_weatherStatics[2].courseAreaName);
    print(_weatherStatics.first.courseName);
    print(_weatherStatics[7].spotAreaName);
    print(_weatherStatics.first.spotName);
    print(_weatherStatics.first.thema);
    print(_weatherStatics.first.tm);
    print(_weatherStatics.first.th3);
    print(_weatherStatics.first.pop);
    print(_weatherStatics.first.rhm);
    print(_weatherStatics.first.sky);
    print(_weatherStatics.first.wd);
    print(_weatherStatics.first.ws);
    print(_weatherStatics.length);
  }

  void _navigateToBookmark() {
    // Implement navigation to bookmark page
  }

  void _fetchWeatherAtSearchPage(String spotAreaName) {
    setState(() {
      searchText = spotAreaName;
    });
    print(searchText);
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
          const Text('해당 데이터는 오후 3시 기준입니다.'),
          const SizedBox(
            height: 20,
          ),
          SearchResultFiltered(
            filterSpotAreaName: searchText,
            weatherStatics: _weatherStatics,
          ),
        ],
      ),
    );
  }
}

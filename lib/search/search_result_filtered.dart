import 'package:get/get.dart';
import 'package:final_project/weather_display/weather_model.dart';
import 'package:final_project/weather_model.dart';
import 'package:flutter/material.dart';

import '../weather_display/weatherMorning.dart';

class SearchResultFiltered extends StatelessWidget {
  final List<Weather_Model> weatherStatics;
  final String filterSpotAreaName;

  const SearchResultFiltered({
    super.key,
    required this.weatherStatics,
    required this.filterSpotAreaName,
  });

  void _navigateToWeatherDisplay(BuildContext context, String? courseId) async {
    Get.to(() => WeatherDisplay(courseId!));
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = weatherStatics
        .where((statics) => statics.spotAreaName == filterSpotAreaName)
        .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          Weather_Model statics = filteredData[index];
          return InkWell(
              onTap: () => _navigateToWeatherDisplay(context, statics.courseId),
              child: Card(
                child: ListTile(
                  title: Text(
                    "${statics.courseName}",
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${statics.courseAreaName} ${statics.spotAreaName}"),
                      Text("${statics.spotName}"),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '기온: ${statics.th3}°C',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade800,
                        ),
                      ),
                      Text(
                        '강수확률: ${statics.pop}%',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

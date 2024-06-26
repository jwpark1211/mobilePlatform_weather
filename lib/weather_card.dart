import 'package:flutter/material.dart';
import 'weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF0F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Image.network(
                'http://openweathermap.org/img/w/${weather.icon}.png',
                width: 70,
                height: 70,
              ),*/
              const SizedBox(width: 10),
              Text(
                '${weather.temperature.toStringAsFixed(1)}°',
                style: const TextStyle(
                  color: Color(0xFF012677),
                  fontSize: 70,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            weather.description,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '체감온도 ${weather.feelsLike}°  습도 ${weather.humidity}%  풍속 ${weather.windSpeed}m/s',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '일출 ${weather.sunrise.split('T')[1].substring(0, 5)}  일몰 ${weather.sunset.split('T')[1].substring(0, 5)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

final tourItem = {
  "list": [
    {
      "image": "assets/images/tour1.png",
      "name": "남이섬",
      "address": "강원특별자치도 춘천시 남이섬길 1 남이섬"
    },
    {
      "image": "assets/images/tour2.png",
      "name": "보은 법주사",
      "address": "충청북도 보은군 속리산면 법주사로 405"
    },
    {
      "image": "assets/images/tour3.png",
      "name": "한려해상국립공원",
      "address": "전라남도 여수시 오동도로 222"
    },
    {
      "image": "assets/images/tour4.png",
      "name": "스페이스워크",
      "address": "경상북도 포항시 북구 환호공원길 30"
    },
    {
      "image": "assets/images/tour5.png",
      "name": "영남 알프스",
      "address": "울산광역시 울주군 상북면 알프스온천5길 103-8"
    },
    {
      "image": "assets/images/tour6.png",
      "name": "디피랑(DPIRANG)",
      "address": "경상남도 통영시 남망공원길 29"
    },
  ]
};

class TourList extends StatelessWidget {
  const TourList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8, // Adjust this value to fit your needs
      ),
      itemCount: tourItem["list"]!.length,
      itemBuilder: (context, index) {
        final item = tourItem["list"]![index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    item["image"]!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item["address"]!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

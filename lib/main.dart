import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controllers/weather_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhomeScreen(),
    );
  }
}

class WhomeScreen extends StatelessWidget {
  WhomeScreen({super.key});
  final WeatherController controller = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    print(controller.cityName);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        title: GetBuilder<WeatherController>(builder: (data) {
          return Text(data.cityName);
        }),
      ),
      body: SafeArea(
        child: ListView(shrinkWrap: true, children: const [
          ListTileCustom(
            image: 'assets/images/snow.png',
          ),
          ListTileCustom(
            image: 'assets/images/humidity.png',
          ),
          ListTileCustom(
            image: 'assets/images/cloudCover.png',
          ),
          ListTileCustom(
            image: 'assets/images/pressure.png',
          ),
        ]),
      ),
    );
  }
}

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    Key? key,
    required this.image,
  }) : super(key: key);
  final image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const SizedBox(
          height: 200,
          width: double.infinity,
        ),
        Positioned(
          top: 30,
          left: 0,
          right: 0,
          bottom: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(100))),
            width: double.infinity,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<WeatherController>(builder: (data) {
                  return Text(
                    "${((data.temp) - 273).toStringAsFixed(2)}℃",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  );
                }),
                const Text('Country',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Row(
                  children: const [
                    Text('longitude/latitude',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Spacer(),
                    Text('mild rain',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  image,
                ),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List colors = <MaterialColor>[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.cyan,
];

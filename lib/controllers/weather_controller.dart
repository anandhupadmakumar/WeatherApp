import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/constants/constants.dart';

class WeatherController extends GetxController {
  bool isLoaded = false;
  num temp = 0.0;
  num pressure = 0;
  num cloudCover = 0;
  num humidity = 0;
  String cityName = 'not found';

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    getCurrentCityWeather(position);
    getCityWeather('kottayam');
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${domain}lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      cityName = decodedData['name'];
      temp = decodedData['main']['temp_min'];
      humidity = decodedData['main']['humidity'];
      cloudCover = decodedData['clouds']['all'];

      // print(decodedData);
      update();
      // print(data);
    } else {
      print('no data found');
    }
  }

  getCityWeather(String cityName) async {
    var client = http.Client();
    var uri = '${domain}q=$cityName&appid=$apiKey';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);

      // print(decodedData);
      print(decodedData['name']);
      update();
      print(data);
    } else {
      print('no data found');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:weather_app/application/bloc/wether_bloc.dart';
import 'package:weather_app/core/contsnts.dart' as k;
import 'package:location/location.dart';
import 'package:weather_app/infrastructure/db/model/weather_model.dart';

Future<void> requestPermissionAndTurnOnDeviceGPS(BuildContext context) async {
  Location location = new Location();
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return requestPermissionAndTurnOnDeviceGPS(context);
    }
  }
  if (serviceEnabled) {
    getCurrentLocation(context);
  }
}

Future<bool> checkPermission() async {
  final geo.LocationPermission permission =
      await geo.Geolocator.checkPermission();
  return permission == geo.LocationPermission.always ||
      permission == geo.LocationPermission.whileInUse;
}

getCurrentLocation(BuildContext context) async {
  bool isval = await checkPermission();
  print("the pemission is ${isval}");
  if (await checkPermission()) {
    var p = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );

    getWeatherByPosition(p, context);
  } else {
    requestPermission();
  }
}

Future<void> requestPermission() async {
  try {
    geo.LocationPermission permission =
        await geo.Geolocator.requestPermission();
    if (permission == geo.LocationPermission.denied) {
      print("the location permission is get");
      await geo.Geolocator.openAppSettings();
    }
  } catch (e) {
    print("the erroe we found is $e");
  }
}

getWeatherByPosition(geo.Position position, BuildContext context) async {
  var clint = http.Client();
  var uri =
      "${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKeys}";
  var url = Uri.parse(uri);
  var response = await clint.get(url);
  if (response.statusCode == 200) {
    var data = response.body;
    print(data);
    var decodeData = json.decode(data);
    var wether = await updateUI(decodeData);
    context.read<WetherBloc>().add(WetherUpdateEvent(wether: wether));
  } else {
    print(response.statusCode);
  }
}

WeatherModel theModel = WeatherModel(
    place: "Place",
    currentWeather: "wether",
    temp: 0,
    humidity: 0,
    pressur: 0,
    cover: 0,
    wind: 0,
    icon: "not found");
Future<WeatherModel> updateUI(var decodeData) async {
  if (decodeData == null) {
    theModel = WeatherModel(
        place: "Not found",
        currentWeather: "unknown",
        temp: 0,
        humidity: 0,
        pressur: 0,
        cover: 0,
        wind: 0,
        icon: "not found");
  } else {
    theModel = WeatherModel(
      place: decodeData['name'],
      currentWeather: decodeData["weather"][0]["main"],
      temp: decodeData['main']['temp'] - 273,
      humidity: decodeData['main']['humidity'],
      pressur: decodeData['main']['pressure'],
      cover: decodeData['clouds']['all'],
      icon: decodeData["weather"][0]["icon"],
      wind: decodeData['wind']['speed'],
    );
  }

  return theModel;
}

Future<WeatherModel> getWeatherByCity(String city) async {
  var client = http.Client();
  var uri = "${k.domain}q=$city&appid=${k.apiKeys}";
  var url = Uri.parse(uri);
  var reponse = await client.get(url);
  if (reponse.statusCode == 200) {
    var data = reponse.body;
    print(data);
    var decodeData = json.decode(data);
    var theModel = updateUI(decodeData);
    return theModel;
  } else {
    print(reponse.statusCode);
  }
  theModel = WeatherModel(
      place: "Not found",
      currentWeather: "unknown",
      temp: 0,
      humidity: 0,
      pressur: 0,
      cover: 0,
      wind: 0,
      icon: "not found");
  return theModel;
}

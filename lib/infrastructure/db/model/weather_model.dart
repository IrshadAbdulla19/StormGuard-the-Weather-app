class WeatherModel {
  int? id;
  String place;
  String currentWeather;
  num temp;
  num humidity;
  num pressur;
  num cover;
  String icon;
  num wind;

  WeatherModel({
    required this.place,
    required this.currentWeather,
    required this.temp,
    required this.humidity,
    required this.pressur,
    required this.cover,
    required this.icon,
    required this.wind,
    this.id,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/wether_bloc.dart';
import 'package:weather_app/core/ui_constants.dart';
import 'package:weather_app/presentation/home/widgets/search.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchForm(
          size: size,
        ),
        kHeight,
        BlocBuilder<WetherBloc, WetherState>(
          builder: (context, state) {
            var weather = state.wether;
            var icon = weather.icon;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "📍${weather.place}",
                  style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              icon == "not found"
                                  ? "https://cdn1.iconfinder.com/data/icons/duotone-weather/24/unknown_weather-512.png"
                                  : "https://openweathermap.org/img/wn/$icon@2x.png",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
                Text(
                  weather.currentWeather,
                  style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${weather.temp.toStringAsFixed(0)}℃",
                  style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                kHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "💧\n${weather.humidity.toStringAsFixed(0)}%\nHumidity",
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "🌬\n${weather.wind.toStringAsFixed(0)}Km/h\nWind",
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "🌡\n${weather.pressur.toStringAsFixed(0)}Pa\nPressure",
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            );
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/domain/home_wether.dart';
import 'package:weather_app/presentation/home/widgets/weather.dart';

bool isLoaded = true;
String cityname = '';

TextEditingController controller = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          requestPermissionAndTurnOnDeviceGPS(context);
        },
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff373B44),
            Color(0xff4286f4),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView(
            children: [
              DisplayScreen(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

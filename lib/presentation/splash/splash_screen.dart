import 'package:flutter/material.dart';
import 'package:weather_app/domain/home_wether.dart';
import 'package:weather_app/presentation/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissionAndTurnOnDeviceGPS();
    forNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("asset/imges/pngwing.com.png"),
      ),
    );
  }

  Future<void> forNavigation() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/domain/home_wether.dart';
import 'package:weather_app/presentation/home/home_screen.dart';
import 'package:action_slider/action_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestPermissionAndTurnOnDeviceGPS(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff373B44),
          Color(0xff4286f4),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/imges/pngwing.com.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Column(
              children: [
                Text(
                  "Discover the Weather in Your City",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          const Color.fromARGB(255, 7, 20, 26).withOpacity(0.6),
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ActionSlider.standard(
                    foregroundBorderRadius: BorderRadius.circular(5),
                    backgroundBorderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                    action: (controller) {
                      controller.loading();
                      forNavigation();
                    },
                    child: const Text("Slide to Start"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> forNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }
}

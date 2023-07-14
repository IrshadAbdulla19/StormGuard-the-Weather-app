import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/wether_bloc.dart';
import 'package:weather_app/core/ui_constants.dart';
import 'package:weather_app/domain/home_wether.dart';
import 'package:weather_app/presentation/home/home_screen.dart';

class SearchForm extends StatelessWidget {
  final Size size;
  const SearchForm({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.9,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.3)),
      child: TextFormField(
        onFieldSubmitted: (String city) async {
          cityname = city;
          var model = await getWeatherByCity(cityname);
          context.read<WetherBloc>().add(WetherUpdateEvent(wether: model));
          controller.clear();
        },
        controller: controller,
        cursorColor: kColorWhite,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: "Search the City",
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}

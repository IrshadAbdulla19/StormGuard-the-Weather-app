part of 'wether_bloc.dart';

class WetherState {
  WeatherModel wether;

  WetherState({required this.wether});
}

class WetherInitial extends WetherState {
  WetherInitial() : super(wether: theModel);
}

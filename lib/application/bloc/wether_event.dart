part of 'wether_bloc.dart';

@immutable
abstract class WetherEvent {}

class WetherUpdateEvent extends WetherEvent {
  final WeatherModel wether;

  WetherUpdateEvent({required this.wether});
}

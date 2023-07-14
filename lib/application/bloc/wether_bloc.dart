import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/home_wether.dart';
import 'package:weather_app/infrastructure/db/model/weather_model.dart';

part 'wether_event.dart';
part 'wether_state.dart';

class WetherBloc extends Bloc<WetherEvent, WetherState> {
  WetherBloc() : super(WetherInitial()) {
    on<WetherUpdateEvent>((event, emit) {
      var placeWether = event.wether;
      return emit(WetherState(wether: placeWether));
    });
  }
}

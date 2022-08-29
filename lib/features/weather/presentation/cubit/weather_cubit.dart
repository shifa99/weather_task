import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/config/network/dio_helper.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  static WeatherCubit get(context) => BlocProvider.of(context);
  late Weather weather;

  Future<void> getWeatherByName({String? name}) async {
    emit(WeatherLoading());
    try {
      //q is a query
      final response =
          await DioHelper.getData(url: '', query: {'q': name ?? 'egypt'});
      weather = Weather.fromJson(response.data);
      log(response.data.toString());
      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherError());
      rethrow;
    }
  }

  Future<void> getWeatherByLocation() async {
    emit(WeatherLoading());
    try {
      //q is a query 'lat,lon'
      Position _position = await _determinePosition();
      final response = await DioHelper.getData(
          url: '',
          query: {'q': '${_position.latitude},${_position.longitude}'});
      weather = Weather.fromJson(response.data);
      // log(response.data.toString());
      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherError());
      rethrow;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    
    return  await Geolocator.getCurrentPosition();
  }
}

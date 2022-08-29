part of 'weather_cubit.dart';

abstract class WeatherState  {
  const WeatherState();

 
}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {}
class WeatherError extends WeatherState {}


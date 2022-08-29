import 'weather.dart';

class TempartureDetails {
  TempartureDetails({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });
  late final int lastUpdatedEpoch;
  late final String lastUpdated;
  late final int tempC;
  late final double tempF;
  late final int isDay;
  late final Condition condition;
  late final double windMph;
  late final int windKph;
  late final int windDegree;
  late final String windDir;
  late final int pressureMb;
  late final double pressureIn;
  late final int precipMm;
  late final int precipIn;
  late final int humidity;
  late final int cloud;
  late final double feelslikeC;
  late final int feelslikeF;
  late final int visKm;
  late final int visMiles;
  late final int uv;
  late final double gustMph;
  late final double gustKph;

  
}
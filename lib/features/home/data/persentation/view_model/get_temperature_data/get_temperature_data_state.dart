part of 'get_temperature_data_cubit.dart';

@immutable
abstract class GetTemperatureDataState {}

class GetTemperatureDataInitial extends GetTemperatureDataState {}

class SuccessGetTemperatureFireStore extends GetTemperatureDataState {
  int minTemperatureAtDay;
  int maxTemperatureAtDay;
  int maxSoilMoisture;
  String? sunLight;
  String? wateringFactor;

  SuccessGetTemperatureFireStore({
    required this.minTemperatureAtDay,
    required this.maxTemperatureAtDay,
    required this.maxSoilMoisture,
    this.sunLight,
    this.wateringFactor,
  });
}

class LoadingGetTemperatureFireStore extends GetTemperatureDataState {}

class FailedGetTemperatureFireStore extends GetTemperatureDataState {}

part of 'get_actuators_data_cubit.dart';

@immutable
abstract class GetActuatorsDataState {}

class GetActuatorsDataInitial extends GetActuatorsDataState {}
/*class SuccessGetAcDataReturn extends GetActuatorsDataState {
  List<String>? actuatorData ;
  SuccessGetAcDataReturn ({required this.actuatorData});
}*/

class LoadingGetAcDataReturn extends GetActuatorsDataState {}
class FailedGetAcDataReturn extends GetActuatorsDataState {}
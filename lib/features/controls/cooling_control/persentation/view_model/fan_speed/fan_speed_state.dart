part of 'fan_speed_cubit.dart';

@immutable
abstract class FanSpeedState {}

class FanSpeedInitial extends FanSpeedState {}
class SuccessFanSpeedValueReturn extends FanSpeedState {}
class SuccessGetFanSpeedValueReturn extends FanSpeedState {}
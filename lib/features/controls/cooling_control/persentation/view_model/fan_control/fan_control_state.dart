part of 'fan_control_cubit.dart';

@immutable
abstract class FanControlState {}

class FanControlInitial extends FanControlState {}
class SuccessFanControlTypeReturn extends FanControlState {}
class SuccessGetFanControlTypeReturn extends FanControlState {}
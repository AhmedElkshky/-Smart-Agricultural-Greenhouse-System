part of 'pump_control_cubit.dart';

@immutable
abstract class PumpControlState {}

class PumpControlInitial extends PumpControlState {}
class SuccessPumpControlTypeReturn extends PumpControlState {}
class SuccessGetPumpControlTypeReturn extends PumpControlState {}
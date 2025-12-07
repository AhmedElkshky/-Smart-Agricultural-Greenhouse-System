part of 'lamp_control_cubit.dart';

@immutable
abstract class LampControlState {}

class LampControlInitial extends LampControlState {}
class SuccessLampControlTypeReturn extends LampControlState {}
class SuccessGetLampControlTypeReturn extends LampControlState {}
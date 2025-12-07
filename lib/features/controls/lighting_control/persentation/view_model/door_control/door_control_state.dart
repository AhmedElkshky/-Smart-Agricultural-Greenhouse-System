part of 'door_control_cubit.dart';

@immutable
abstract class DoorControlState {}

class DoorControlInitial extends DoorControlState {}
class SuccessDoorControlTypeReturn extends DoorControlState {}
class SuccessGetDoorControlTypeReturn extends DoorControlState {}
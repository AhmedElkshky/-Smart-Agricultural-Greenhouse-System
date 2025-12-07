part of 'timer_cubit.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState{

  int minutes = 0 ;
  int seconds = 0;
  TimerRunning ({required this.minutes , required this.seconds ,});

}
class TimerFinished extends TimerState {}




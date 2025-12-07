import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view_model/watering_control/pump_control_cubit.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  int minutes = 0;
  int seconds = 0;
   bool? timerRunning ;
  late Timer timer;


  void startTimer({required int minutes, required int seconds ,required BuildContext context}) {
    this.minutes = minutes;
    this.seconds = seconds;
    timerRunning = true;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.seconds > 0) {
        this.seconds -=1;
        emit(TimerRunning(minutes: this.minutes, seconds: this.seconds,));

      } else if (this.minutes > 0) {
        this.minutes -=1;
        this.seconds = 59;
        emit(TimerRunning(minutes: this.minutes, seconds: this.seconds,));

      } else {
        timer.cancel();
        timerRunning = false;
        context.read<PumpControlCubit>().pumpControlTypeReturn(type: PumpControlType.OFF, context: context);
        emit(TimerFinished());

      }

    });
    emit(TimerInitial());


  }
}

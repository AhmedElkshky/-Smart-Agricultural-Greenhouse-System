import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'pump_control_state.dart';
enum PumpControlType{AUTO,OFF,ON}
class PumpControlCubit extends Cubit<PumpControlState> {
  PumpControlCubit() : super(PumpControlInitial());
  PumpControlType pumpControlType = PumpControlType.OFF;


  void getPumpControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myPumpControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Pump_state').get();
    if (myPumpControlType.value.toString() == '3'){
      pumpControlType = PumpControlType.AUTO;
    }
    if (myPumpControlType.value.toString() == '0'){
      pumpControlType = PumpControlType.OFF;
    }
    if (myPumpControlType.value.toString() == '1'){
      pumpControlType = PumpControlType.ON;
    }
    emit(SuccessGetPumpControlTypeReturn());

  }



  void pumpControlTypeReturn({required PumpControlType type,required BuildContext context}){
    pumpControlType = type;
    emit(SuccessPumpControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (pumpControlType == PumpControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Pump_state': 3});
    }
    if (pumpControlType == PumpControlType.OFF){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Pump_state': 0});
    }
    if (pumpControlType == PumpControlType.ON){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Pump_state': 1});
    }
  }
}

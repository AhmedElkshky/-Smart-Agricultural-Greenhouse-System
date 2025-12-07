import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../current_green_house_id/current_green_house_id_cubit.dart';

part 'buzzer_control_state.dart';
 enum BuzzerControlType {AUTO , OFF,ON}
class BuzzerControlCubit extends Cubit<BuzzerControlState> {
  BuzzerControlCubit() : super(BuzzerControlInitial());

  BuzzerControlType? buzzerControlType;


  void getbuzzerControlReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myBuzzerControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Buzzer_state').get();
    if (myBuzzerControlType.value.toString() == '3'){
      buzzerControlType = BuzzerControlType.AUTO;
    }
    if (myBuzzerControlType.value.toString() == '0'){
      buzzerControlType = BuzzerControlType.OFF;
    }
    if (myBuzzerControlType.value.toString() == '1'){
      buzzerControlType = BuzzerControlType.ON;
    }
    emit(SuccessGetbuzzerControlReturn());

  }


  void buzzerControlReturn ({required BuzzerControlType type,required BuildContext context}){
    buzzerControlType = type;
    emit(SuccessBuzzerControlReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (buzzerControlType == BuzzerControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Buzzer_state': 3});
    }
    if (buzzerControlType == BuzzerControlType.OFF){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Buzzer_state': 0});
    }
    if (buzzerControlType == BuzzerControlType.ON){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Buzzer_state': 1});
    }
  }
}

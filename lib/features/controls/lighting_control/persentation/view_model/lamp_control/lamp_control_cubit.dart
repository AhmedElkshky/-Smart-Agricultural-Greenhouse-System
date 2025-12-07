import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'lamp_control_state.dart';

enum LampControlType { AUTO, OFF, ON }

class LampControlCubit extends Cubit<LampControlState> {
  LampControlCubit() : super(LampControlInitial());
  LampControlType? lampControlType ;


  void getLampControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myLampControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Lamp_state').get();
    if (myLampControlType.value.toString() == '3'){
      lampControlType = LampControlType.AUTO;
    }
    if (myLampControlType.value.toString() == '0'){
      lampControlType = LampControlType.OFF;
    }
    if (myLampControlType.value.toString() == '1'){
      lampControlType = LampControlType.ON;
    }
    emit(SuccessGetLampControlTypeReturn());

  }






  void lampControlTypeReturn({
    required LampControlType type,
    required BuildContext context
  }) {
    lampControlType = type;
    emit(SuccessLampControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (lampControlType == LampControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Lamp_state': 3});
    }
    if (lampControlType == LampControlType.OFF){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Lamp_state': 0});
    }
    if (lampControlType == LampControlType.ON){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Lamp_state': 1});
    }
  }
}

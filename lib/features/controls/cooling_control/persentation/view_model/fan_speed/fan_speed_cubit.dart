import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'fan_speed_state.dart';

class FanSpeedCubit extends Cubit<FanSpeedState> {
  FanSpeedCubit() : super(FanSpeedInitial());

  double fanSpeedValue = 0 ;


  void getFanSpeedValueReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myFanSpeedValue = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Fan_state').get();
    if (myFanSpeedValue.value.toString() == '0'){
      fanSpeedValue = 0;
    }
    if (myFanSpeedValue.value.toString() == '50'){
      fanSpeedValue = 1;
    }
    if (myFanSpeedValue.value.toString() == '100'){
      fanSpeedValue = 2;
    }
    if (myFanSpeedValue.value.toString() == '150'){
      fanSpeedValue = 3;
    }if (myFanSpeedValue.value.toString() == '200'){
      fanSpeedValue = 4;
    }if (myFanSpeedValue.value.toString() == '255'){
      fanSpeedValue = 5;
    }
    emit(SuccessGetFanSpeedValueReturn());

  }





  void fanSpeedValueReturn(
      {required double fanSpeed, required BuildContext context}) {
    fanSpeedValue = fanSpeed;
    emit(SuccessFanSpeedValueReturn());
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (fanSpeedValue == 0) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 0});
    }
    if (fanSpeedValue == 1) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 50});
    } if (fanSpeedValue == 2) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 100});
    } if (fanSpeedValue == 3) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 150});
    } if (fanSpeedValue == 4) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 200});
    } if (fanSpeedValue == 5) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_speed': 255});
    }

  }
}

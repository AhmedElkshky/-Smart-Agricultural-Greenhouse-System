import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'fan_control_state.dart';
enum FanControlType {AUTO , OFF, ON}
class FanControlCubit extends Cubit<FanControlState> {
  FanControlCubit() : super(FanControlInitial());

  FanControlType? fanControlType ;



  void getFanControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myFanControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Fan_state').get();
    if (myFanControlType.value.toString() == '3'){
      fanControlType = FanControlType.AUTO;
    }
    if (myFanControlType.value.toString() == '0'){
      fanControlType = FanControlType.OFF;
    }
    if (myFanControlType.value.toString() == '1'){
      fanControlType = FanControlType.ON;
    }
    emit(SuccessGetFanControlTypeReturn());

  }



  void fanControlTypeReturn({required FanControlType type ,required BuildContext context}) {
    fanControlType = type ;
    emit(SuccessFanControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (fanControlType == FanControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_state': 3});
    }
    if (fanControlType == FanControlType.OFF){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_state': 0});
    }
    if (fanControlType == FanControlType.ON){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Fan_state': 1});
    }
  }
}

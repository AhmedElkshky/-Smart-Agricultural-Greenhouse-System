import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'door_control_state.dart';
enum DoorControlType {AUTO,CLOSE,MEDIUM,OPEN}
class DoorControlCubit extends Cubit<DoorControlState> {
  DoorControlCubit() : super(DoorControlInitial());
  DoorControlType? doorControlType ;



  void getDoorControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myDoorControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Door_state').get();
    if (myDoorControlType.value.toString() == '4'){
      doorControlType = DoorControlType.AUTO;
    }
    if (myDoorControlType.value.toString() == '3'){
      doorControlType = DoorControlType.CLOSE;
    }
    if (myDoorControlType.value.toString() == '2'){
      doorControlType = DoorControlType.MEDIUM;
    }
    if (myDoorControlType.value.toString() == '1'){
      doorControlType = DoorControlType.OPEN;
    }
    emit(SuccessGetDoorControlTypeReturn());

  }




  void doorControlTypeReturn ({required DoorControlType type ,required BuildContext context}){
    doorControlType = type ;
    emit(SuccessDoorControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if ( doorControlType == DoorControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Door_state': 4});
    }
    if ( doorControlType == DoorControlType.CLOSE){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Door_state': 3});
    }
    if ( doorControlType == DoorControlType.MEDIUM){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Door_state': 2});
    }
    if ( doorControlType == DoorControlType.OPEN){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Door_state': 1});
    }
  }
}

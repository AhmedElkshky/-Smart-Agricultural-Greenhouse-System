import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'manual_auto_state.dart';

enum ControlType { Manual, Auto }

class ManualAutoCubit extends Cubit<ManualAutoState> {
  ManualAutoCubit() : super(ManualAutoInitial());

  ControlType? controlType ;

  void getControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myControlType = await ref.child('GREENHOUSE/$greenHouseId/CONTROL').get();
    if (myControlType.value.toString() == '1'){
      controlType = ControlType.Manual;
    }
    if (myControlType.value.toString() == '2'){
      controlType = ControlType.Auto;
    }
    emit(SuccessGetControlTypeReturn());

  }

  void controlTypeReturn(
      {required ControlType type, required BuildContext context}) async {
    controlType = type;

    emit(SuccessControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (controlType == ControlType.Manual) {
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId");
      ref.update({'CONTROL': 1});
    }
    if (controlType == ControlType.Auto){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId");
      ref.update({'CONTROL': 2});
    }
    // upload data on firebase
  }
}

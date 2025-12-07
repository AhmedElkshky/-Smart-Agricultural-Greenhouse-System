import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

part 'thermo_control_state.dart';
enum ThermoControlType {AUTO , OFF, ON}
class ThermoControlCubit extends Cubit<ThermoControlState> {
  ThermoControlCubit() : super(ThermoControlInitial());

  ThermoControlType? thermoControlType;







  void getThermoControlTypeReturn ({required BuildContext context})async{
    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    final ref = FirebaseDatabase.instance.ref();
    final myThermoControlType = await ref.child('GREENHOUSE/$greenHouseId/ACTUATORS/Thermo_state').get();
    if (myThermoControlType.value.toString() == '3'){
      thermoControlType = ThermoControlType.AUTO;
    }
    if (myThermoControlType.value.toString() == '0'){
      thermoControlType = ThermoControlType.OFF;
    }
    if (myThermoControlType.value.toString() == '1'){
      thermoControlType = ThermoControlType.ON;
    }
    emit(SuccessGetThermoControlTypeReturn());

  }




  void thermoControlTypeReturn ({required ThermoControlType type, required BuildContext context}){
    thermoControlType = type ;
    emit(SuccessThermoControlTypeReturn());

    String? greenHouseId =
        context.read<CurrentGreenHouseIdCubit>().greenHouseId;
    if (thermoControlType == ThermoControlType.AUTO){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Thermo_state': 3});
    }
    if (thermoControlType == ThermoControlType.OFF){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Thermo_state': 0});
    }
    if (thermoControlType == ThermoControlType.ON){
      DatabaseReference ref =
      FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId/ACTUATORS");
      ref.update({'Thermo_state': 1});
    }
  }
}

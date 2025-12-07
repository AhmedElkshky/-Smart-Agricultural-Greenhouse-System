import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_temperature_data/get_temperature_data_cubit.dart';

import '../pick_green_house_photo/pick_green_house_photo_cubit.dart';

part 'green_house_data_state.dart';

class GreenHouseDataCubit extends Cubit<GreenHouseDataState> {
  GreenHouseDataCubit() : super(GreenHouseDataInitial());
  String? greenHousePhoto;
  String? greenHouseName;
  String? greenHouseId;
  String? selectedPlanet;
  String? selectedPlanetId;
  String? uId;
  int? minTemperatureAtDay;
  int? maxTemperatureAtDay;
  int? maxSoilMoisture;



  Future<void> finalPushDataOnFirebase({
    required BuildContext context,
    required String selectedPlanetId,
    required String greenHouseName,
    required String greenHouseId,
    required String selectedPlanet,
    required int minTemperatureAtDay,
    required int maxTemperatureAtDay,
    required int maxSoilMoisture,
  })async{
    try{
      emit(LoadingFinalPushDataOnFirebaseState());
      // get data from UI screen
      this.selectedPlanetId = selectedPlanetId;
      this.greenHouseName = greenHouseName;
      this.greenHouseId = greenHouseId;
      this.selectedPlanet = selectedPlanet;
      this.greenHousePhoto = context.read<PickGreenHousePhotoCubit>().uploadGreenHouseImage(context: context,selectedPlanetId:selectedPlanetId).toString();
      this.minTemperatureAtDay =  minTemperatureAtDay;
      this.maxTemperatureAtDay =  maxTemperatureAtDay;
      this.maxSoilMoisture     =  maxSoilMoisture ;

      // push data on fireStore
      pushDataFireStore();
      // push data on realTime
      pushDataRealTime(context: context );
      context.read<GetGreenHouseDataCubit>().getAllGreenHouseDataWithDetail(context: context);
      Navigator.pop(context);
      emit(SuccessFinalPushDataOnFirebaseState());

    }catch (e){
      emit(FailedFinalPushDataOnFirebaseState());
    }
  }


  void greenHouseData({

    required String greenHousePhoto,
    required String greenHouseName,
    required String greenHouseId,
    required String selectedPlanet,
  }) {
    this.greenHousePhoto = greenHousePhoto;
    this.greenHouseName = greenHouseName;
    this.greenHouseId = greenHouseId;
    this.selectedPlanet = selectedPlanet;
  }




  void pushDataFireStore() async {
    try {
      uId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .collection("List_Of_Green_House")
          .doc('$greenHouseId')
          .set({
        "greenHouseId": greenHouseId,
      });
    } catch (e) {
      print('push data fire store -----------------------> ${e.toString()}');
    }
  }

  void pushDataRealTime({required BuildContext context ,}) async {

    try {


      DatabaseReference ref =
          FirebaseDatabase.instance.ref("GREENHOUSE/$greenHouseId");
      ref.set({
        "ACTUATORS": {
          "Buzzer_state": 0,
          "Buzzer_state_return": 1,
          "Door_state": 3,
          "Door_state_return": 1,
          "Fan_speed": 0,
          "Fan_speed_return": 1,
          "Fan_state": 0,
          "Fan_state_return": 1,
          "Lamp_state": 0,
          "Lamp_state_return": 1,
          "Pump_state": 0,
          "Pump_state_return": 1,
          "Thermo_state": 0,
          "Thermo_state_return": 1,
        },
        "MinTemperature": minTemperatureAtDay,    // get from fireStore
        "MaxTemperature": maxTemperatureAtDay,   // get from fireStore
        "MaxSoilMoisture": maxSoilMoisture,     // get from fireStore
        "CONTROL": 1,
        "ID": "$greenHouseId",
        "LOCATION": "GIZA",
        "greenHouseName": "$greenHouseName",
        "Out_temperature": 28,
        "greenHousePhoto": "$greenHousePhoto",
        "selectedPlanet": "$selectedPlanet",
        "SENSORS": {
          "Distance": 1,
          "Gas": 1,
          "Humidity": 1,
          "MotionDetected": 1,
          "PhotoResistor": 1,
          "SoilMoisture": 1,
          "Temperature": 1,
          "WaterLevel": 1,
          "StringSoilMoisture":1,
          "StringPhotoResistor":1,
          "StringWaterLevel":1,

        },
        "SuggestedCooling":0,
        "SuggestedLighting":0,
        "SuggestedWatering":0,
      });
    } catch (e) {
      print('push data real time-----------------------> ${e.toString()}');
    }
  }




}

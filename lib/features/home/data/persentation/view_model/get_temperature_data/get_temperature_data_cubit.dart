import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/green_house_data/green_house_data_cubit.dart';

part 'get_temperature_data_state.dart';

class GetTemperatureDataCubit extends Cubit<GetTemperatureDataState> {
  GetTemperatureDataCubit() : super(GetTemperatureDataInitial());



  void getTemperatureFireStore({required String selectedPlanetId,required BuildContext context}) async {

    try {
      emit(LoadingGetTemperatureFireStore());
      int minTemperatureAtDay;
      int maxTemperatureAtDay;
      int maxSoilMoisture;
      String sunLight ;
      String wateringFactor ;

      final myMinTemperature = await FirebaseFirestore.instance
          .collection('PLANTS')
          .doc('$selectedPlanetId')
          .get();
      final myMinTemperatureDate = myMinTemperature.data();
      minTemperatureAtDay =
          myMinTemperatureDate?['MinTemperatureAtDay'];
      //--------------------------------------------------------------------
      final myMaxTemperature = await FirebaseFirestore.instance
          .collection('PLANTS')
          .doc('$selectedPlanetId')
          .get();
      final myMaxTemperatureDate = myMaxTemperature.data();
      maxTemperatureAtDay =
          myMaxTemperatureDate?['MaxTemperatureAtDay'];
      //-------------------------------------------------------------------
      final myMaxSoilMoisture = await FirebaseFirestore.instance
          .collection('PLANTS')
          .doc('$selectedPlanetId')
          .get();
      final myMaxSoilMoistureDate = myMaxSoilMoisture.data();
      maxSoilMoisture = myMaxSoilMoistureDate?['MaxSoilMoisture'];
      //--------------------------------------------------------------------

      final mySunLight = await FirebaseFirestore.instance
          .collection('PLANTS')
          .doc('$selectedPlanetId')
          .get();
      final mySunLightData = mySunLight.data();
      sunLight = mySunLightData?['SunLight'];

      //--------------------------------------------------------------------
      final myWateringFactor = await FirebaseFirestore.instance
          .collection('PLANTS')
          .doc('$selectedPlanetId')
          .get();
      final myWateringFactorData = myWateringFactor.data();
      wateringFactor = myWateringFactorData?['Watering Frequency Factors'];

      emit(SuccessGetTemperatureFireStore(
          minTemperatureAtDay: minTemperatureAtDay,
          maxTemperatureAtDay: maxTemperatureAtDay,
          maxSoilMoisture: maxSoilMoisture,
        sunLight: sunLight,
        wateringFactor: wateringFactor,
      ));

      print('minTemperatureAtDay?????????????????: $minTemperatureAtDay');
      print('maxTemperatureAtDay:?????????????????: $maxTemperatureAtDay');
      print('maxSoilMoisture?????????????????: $maxSoilMoisture');

    } catch (e) {
      print('get temp error -----------> ${e.toString()}');
      emit(FailedGetTemperatureFireStore());

    }
  }
}

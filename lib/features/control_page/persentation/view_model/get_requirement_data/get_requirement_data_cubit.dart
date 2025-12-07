import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../current_green_house_id/current_green_house_id_cubit.dart';
part 'get_requirement_data_state.dart';

class GetRequirementDataCubit extends Cubit<GetRequirementDataState> {
  GetRequirementDataCubit() : super(GetRequirementDataInitial());

  final _requirementDataSubject = BehaviorSubject<List<String>>();

  Stream<List<String>> get requirementDataStream =>
      _requirementDataSubject.stream;

  String? greenHouseId;

  void getRequirementDataReturn({
    required BuildContext context,
    /* required String greenHouseId*/
  }) async {
    try {
      emit(LoadingGetRequirementDataReturn());

      greenHouseId = context.read<CurrentGreenHouseIdCubit>().greenHouseId;
//------------------------------------------------------------
      final database = FirebaseDatabase.instance;

      final lightingDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SuggestedLighting')
          .onValue
          .map((event) =>
              _convertLightingToString(event.snapshot.value.toString()));

      final coolingDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SuggestedCooling')
          .onValue
          .map((event) =>
              _convertCoolingToString(event.snapshot.value.toString()));

      final wateringDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SuggestedWatering')
          .onValue
          .map((event) =>
              _convertWateringToString(event.snapshot.value.toString()));

      // Combine all streams into a single stream of actuator data
      final combinedStream = Rx.combineLatest3(
          lightingDataStream,
          coolingDataStream,
          wateringDataStream,
          (lightingData, coolingData, wateringData) => [
                _convertLightingToString(lightingData),
                _convertCoolingToString(coolingData),
                _convertWateringToString(wateringData),
              ]);

      combinedStream.listen((requirementData) {
        _requirementDataSubject.add(requirementData);
        print(
            'requirement data emitted: $requirementData'); // Added for verification
      });
    } catch (e) {
      emit(FailedGetRequirementDataReturn());
      print('requirement error -------------->${e.toString()}');
    }
  }

  String _convertLightingToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String _convertCoolingToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String _convertWateringToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  @override
  Future<void> close() async {
    _requirementDataSubject.close();
    super.close();
  }
}

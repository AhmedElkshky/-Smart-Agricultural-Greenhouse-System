import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';

import '../../../../home/data/persentation/view_model/get_green_house_data_model/get_green_house_data_model.dart';

part 'visitor_house_id_state.dart';

class VisitorHouseIdCubit extends Cubit<VisitorHouseIdState> {
  VisitorHouseIdCubit() : super(VisitorHouseIdInitial());

  String greenHouseId = '=';
  List<GetGreenHouseDataModel> _getGreenHouseDataModel = [];

  void checkVisitorHouseId({required String greenHouseId ,required BuildContext context}) async {
    this.greenHouseId = greenHouseId;
    context.read<CurrentGreenHouseIdCubit>().catchGreenHouseId(greenHouseId: greenHouseId, greenHouseName: '', selectedPlanetId: '');
    List<String> allGreenHouse = [];

    try {
      emit(LoadingCheckVisitorHouseId());
      final ref = FirebaseDatabase.instance.ref();
      final greenhouseRef = ref.child('GREENHOUSE');

      final snapshot = await greenhouseRef.get();

      if (snapshot.exists) {
        snapshot.children.forEach((element) {
          allGreenHouse.add(element.key.toString());
        });
      }

      if (allGreenHouse.contains(this.greenHouseId)) {
        getVisitorGreenHouseData();

      }
      if (!allGreenHouse.contains(this.greenHouseId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('This Id Isn\'t Exists '),
          ),
        );
        emit(WrongCheckVisitorHouseId());
      }
    } catch (e) {
      emit(FailedCheckVisitorHouseId());
      print('errorrrrr------------${e.toString()}');
    }
  }

  void getVisitorGreenHouseData() async {
    try {
      String? getGreenHousePhoto;
      String? getGreenHouseName;
      String? getSelectedPlanet;
      String? getGreenHouseId;
      String? getSelectedPlanetId;

      final ref = FirebaseDatabase.instance.ref();
      final greenHousePhoto = await ref
          .child('GREENHOUSE/${this.greenHouseId}/greenHousePhoto')
          .get();
      final greenHouseName = await ref
          .child('GREENHOUSE/${this.greenHouseId}/greenHouseName')
          .get();
      final selectedPlanet = await ref
          .child('GREENHOUSE/${this.greenHouseId}/selectedPlanet')
          .get();
      final greenHouseId =
          await ref.child('GREENHOUSE/${this.greenHouseId}/ID').get();
      final selectedPlanetId = await ref
          .child('GREENHOUSE/${this.greenHouseId}/selectedPlanet')
          .get();
      getGreenHousePhoto = greenHousePhoto.value.toString();
      getGreenHouseName = greenHouseName.value.toString();
      getSelectedPlanet = selectedPlanet.value.toString();
      getGreenHouseId = greenHouseId.value.toString();
      getSelectedPlanetId = selectedPlanetId.value.toString();

      _getGreenHouseDataModel.add(GetGreenHouseDataModel(
          greenHousePhoto: getGreenHousePhoto,
          greenHouseName: getGreenHouseName,
          selectedPlanet: getSelectedPlanet,
          greenHouseId: getGreenHouseId,
          selectedPlanetId: getSelectedPlanetId));

      emit(SuccessCheckVisitorHouseId(
          getGreenHouseDataModel: _getGreenHouseDataModel));
      _getGreenHouseDataModel = [];

      print('modeeeel -----------${_getGreenHouseDataModel[0].greenHouseName}');
    } catch (e) {
      print('getVisitorGreenHouseData error -----------> ${e.toString()}');
    }
  }
}

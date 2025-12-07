
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_green_house_data_model/get_green_house_data_model.dart';
part 'get_green_house_data_state.dart';

class GetGreenHouseDataCubit extends Cubit<GetGreenHouseDataState> {
  GetGreenHouseDataCubit() : super(GetGreenHouseDataInitial());

  Future<void> getAllGreenHouseDataWithDetail(
      {required BuildContext context}) async {
    List<GetGreenHouseDataModel> _getGreenHouseDataModel = [];

    try {
      emit(LoadingGetAllGreenhouseState());
      String? getGreenHousePhoto;
      String? getGreenHouseName;
      String? getSelectedPlanet;
      String? getGreenHouseId;
      String? getSelectedPlanetId;
      String? myGreenHouseId;

      List<String?> allGreenHouseUserId = [];

      final uId = await FirebaseAuth.instance.currentUser!.uid;
      final usersCollection =
          await FirebaseFirestore.instance.collection('users');
      final allGreenHousesDoc = await usersCollection
          .doc('user $uId')
          .collection('List_Of_Green_House')
          .get();
      allGreenHousesDoc.docs.forEach((doc) {
        Map<String, dynamic> docData = doc.data();
        allGreenHouseUserId.add(docData['greenHouseId']);
      });

      print(
          'allGreenHouseUserId-------------------> ${allGreenHouseUserId.length}');

      for (int i = allGreenHouseUserId.length - 1; i >= 0; i--) {
        myGreenHouseId = allGreenHouseUserId[i];

        final ref = FirebaseDatabase.instance.ref();
        final greenHousePhoto =
            await ref.child('GREENHOUSE/$myGreenHouseId/greenHousePhoto').get();
        final greenHouseName =
            await ref.child('GREENHOUSE/$myGreenHouseId/greenHouseName').get();
        final selectedPlanet =
            await ref.child('GREENHOUSE/$myGreenHouseId/selectedPlanet').get();
        final greenHouseId =
            await ref.child('GREENHOUSE/$myGreenHouseId/ID').get();
        final selectedPlanetId =
            await ref.child('GREENHOUSE/$myGreenHouseId/selectedPlanet').get();
        getGreenHousePhoto = greenHousePhoto.value.toString();
        getGreenHouseName = greenHouseName.value.toString();
        getSelectedPlanet = selectedPlanet.value.toString();
        getGreenHouseId = greenHouseId.value.toString();
        getSelectedPlanetId = selectedPlanetId.value.toString();

        _getGreenHouseDataModel.add(
          GetGreenHouseDataModel(
              greenHousePhoto: getGreenHousePhoto,
              greenHouseName: getGreenHouseName,
              selectedPlanet: getSelectedPlanet,
              greenHouseId: getGreenHouseId,
              selectedPlanetId: getSelectedPlanetId),
        );

        for (var element in _getGreenHouseDataModel) {
          print('name: ${element.greenHouseName} ');
        }

        emit(SuccessGetAllGreenHouseDataWithDetail(
            listOfGreenHouseDataModel: _getGreenHouseDataModel));
      }
    } catch (e) {
      print('error ---------------------> ${e.toString()}');
      emit(ErrorGetAllGreenhouseState());
    }
  }
}

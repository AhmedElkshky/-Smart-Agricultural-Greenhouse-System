import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'green_house_id_state.dart';

class GreenHouseIdCubit extends Cubit<GreenHouseIdState> {
  GreenHouseIdCubit() : super(GreenHouseIdInitial());
  String? greenHouseId;
  String? uId;

  void checkFarmerHouseId(
      {required String greenHouseId, required BuildContext context}) async {
    this.greenHouseId = greenHouseId;
    List<String> allGreenHouse = [];
    try {
      emit(LoadingPushIdFireStore());
      final ref = FirebaseDatabase.instance.ref();
      final greenhouseRef = ref.child('GREENHOUSE');

      final snapshot = await greenhouseRef.get();

      if (snapshot.exists) {
        snapshot.children.forEach((element) {
          allGreenHouse.add(element.key.toString());
        });
      }

      if (allGreenHouse.contains(this.greenHouseId)) {
        pushIdFireStore();
      }
      if (!allGreenHouse.contains(this.greenHouseId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('This Id Isn\'t Exists '),
          ),
        );
      }
    } catch (e) {
      print('errorr -----------------${e.toString()}');
      emit(FailedPushIdFireStore());
    }
  }

  void pushIdFireStore() async {
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
      emit(SuccessPushIdFireStore());
    } catch (e) {
      print('error push id ------------> ${e.toString()}');
    }
  }
}

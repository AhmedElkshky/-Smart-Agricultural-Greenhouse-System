import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/check_user_type/check_user_type_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/firebase_services/firebase_authentication.dart';

part 'user_data_state.dart';

enum TypeSignUP { google, email, phone }

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  String? fullName;
  String? email;
  String? phone;
  String? password;
  String? photo;
  String? userType;
  String? uId;
  TypeSignUP? typeSignUp;

  void emailData(
      {required BuildContext context,
      required String email,
      required String phone,
      required String password}) {
    try {
      typeSignUp = TypeSignUP.email;
      Auth.instance.signUpWithEmail(
          email: email!, password: password!, context: context);

      this.email = email;
      this.phone = phone;
      this.password = password;
      emit(SuccessEmailData());
    } catch (e) {
      print('email data --------------------> ${e.toString()}');
      emit(FailedEmailData());
    }
  }

  void userData({
    String? photo,
    required String userType,
    String? fullName,
  }) {
    this.userType = userType;
    if (photo != null && photo.isNotEmpty) {
      this.photo = photo;
    }
    if (fullName != null && fullName.isNotEmpty) {
      this.fullName = fullName;
    }
  }

  //--------------------------------------------------------------------

  void googleData({
    required BuildContext context,
  }) {
    try {
      Auth.instance.signInWithGoogle(context);

      this.fullName = FirebaseAuth.instance.currentUser?.displayName;
      this.email = FirebaseAuth.instance.currentUser?.email;
      this.photo = FirebaseAuth.instance.currentUser?.photoURL;

      typeSignUp = TypeSignUP.google;
    } catch (e) {}
  }

  void pushData() async {
    try {
      uId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc('user $uId').set(
        {
          "email": email,
          "password": password,
          "phone": phone,
          "photo": photo,
          "userType": userType,
          "fullName": fullName,
          "typeSignUp": typeSignUp.toString(),
        },
      );
      emit(SuccessPushData());
    } catch (e) {
      print('push data-----------------------> ${e.toString()}');
      emit(FailedPushData());
    }
  }
}

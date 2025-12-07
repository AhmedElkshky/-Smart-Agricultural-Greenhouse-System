import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/admin_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/farmer_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view/widgets/farmer_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';

import '../../../../firebase_services/firebase_authentication.dart';

part 'sign_in_with_email_state.dart';

class SignInWithEmailCubit extends Cubit<SignInWithEmailState> {
  SignInWithEmailCubit() : super(SignInWithEmailInitial());

  void signInWithEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(LoadingSignInWithEmailPassword());
      UserCredential? userCredential = await Auth.instance
          .signInWithEmail(email: email, password: password, context: context);
     final uId = FirebaseAuth.instance.currentUser!.uid;
      final myUserType = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myUserTypeData = myUserType.data();
     final userType = myUserTypeData?['userType'];
      if (userCredential != null && userType == "Admin") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AdminNavigationBarBody();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Success',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            backgroundColor: Colors.greenAccent,
          ),
        );
      }
      if (userCredential != null && userType == "Farmer") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FarmerNavigationBarBody();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Success',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            backgroundColor: Colors.greenAccent,
          ),
        );
      }

      emit(SuccessSignInWithEmailPassword());

    } catch (e) {
      print('sign in error ---------> ${e.toString()}');
      emit(FailedSignInWithEmailPassword());
    }
  }
}

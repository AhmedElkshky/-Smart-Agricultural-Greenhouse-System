import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../firebase_services/firebase_authentication.dart';

part 'create_email_account_state.dart';

class CreateEmailAccountCubit extends Cubit<CreateEmailAccountState> {
  CreateEmailAccountCubit() : super(CreateEmailAccountInitial());

  Future<void> createEmailAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      emit(LoadingCreateAccountState());

      final userCredential = await Auth.instance
          .signUpWithEmail(email: email, password: password, context: context);
      if (userCredential != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc('user ${userCredential.user!.uid}')
            .set(
          {
            'email': email,
            'phone': phone,
            'password':password,
          },
        );
      }

      emit(SuccessCreateAccountState());
    } catch (e) {
      emit(ErrorCreateAccountState());
      print('error --------------------> ${e.toString()}');
    }
  }
}

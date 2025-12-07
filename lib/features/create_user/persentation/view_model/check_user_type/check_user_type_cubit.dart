import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_user_type_state.dart';

enum UserType {Admin , Farmer}

class CheckUserTypeCubit extends Cubit<CheckUserTypeState> {
  CheckUserTypeCubit() : super(CheckUserTypeInitial());

  UserType? userType;

  void checkUserType({required UserType type}){
    userType = type;
    emit(CheckUserState());
  }
}

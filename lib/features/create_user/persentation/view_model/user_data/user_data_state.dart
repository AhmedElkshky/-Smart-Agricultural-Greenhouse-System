part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class SuccessEmailData extends UserDataState{}
class FailedEmailData extends UserDataState{}
class SuccessPushData extends UserDataState {}
class FailedPushData extends UserDataState {}



class UserData extends UserDataState{}
class PushData extends UserDataState{}

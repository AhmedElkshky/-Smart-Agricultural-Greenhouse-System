part of 'create_email_account_cubit.dart';

@immutable
abstract class CreateEmailAccountState {}

class CreateEmailAccountInitial extends CreateEmailAccountState {}
class SuccessCreateAccountState extends CreateEmailAccountState{}
class LoadingCreateAccountState extends CreateEmailAccountState{}
class ErrorCreateAccountState extends CreateEmailAccountState{}
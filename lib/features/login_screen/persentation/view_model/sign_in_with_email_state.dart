part of 'sign_in_with_email_cubit.dart';

@immutable
abstract class SignInWithEmailState {}

class SignInWithEmailInitial extends SignInWithEmailState {}
class SuccessSignInWithEmailPassword extends SignInWithEmailState {}
class FailedSignInWithEmailPassword extends SignInWithEmailState {}
class LoadingSignInWithEmailPassword extends SignInWithEmailState {}
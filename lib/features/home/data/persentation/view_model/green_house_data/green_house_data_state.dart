part of 'green_house_data_cubit.dart';

@immutable
abstract class GreenHouseDataState {}

class GreenHouseDataInitial extends GreenHouseDataState {}
class SuccessFinalPushDataOnFirebaseState extends GreenHouseDataState {}
class LoadingFinalPushDataOnFirebaseState extends GreenHouseDataState {}
class FailedFinalPushDataOnFirebaseState extends GreenHouseDataState {}



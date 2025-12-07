part of 'green_house_id_cubit.dart';

@immutable
abstract class GreenHouseIdState {}

class GreenHouseIdInitial extends GreenHouseIdState {}
class SuccessPushIdFireStore extends GreenHouseIdState {}
class FailedPushIdFireStore extends GreenHouseIdState {}
class LoadingPushIdFireStore extends GreenHouseIdState {}
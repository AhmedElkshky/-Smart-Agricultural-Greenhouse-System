part of 'visitor_house_id_cubit.dart';

@immutable
abstract class VisitorHouseIdState {}

class VisitorHouseIdInitial extends VisitorHouseIdState {}
class LoadingCheckVisitorHouseId extends VisitorHouseIdState {}
class SuccessCheckVisitorHouseId extends VisitorHouseIdState {
  List<GetGreenHouseDataModel>? getGreenHouseDataModel ;
  SuccessCheckVisitorHouseId({required this.getGreenHouseDataModel});
}
class FailedCheckVisitorHouseId extends VisitorHouseIdState {}
class WrongCheckVisitorHouseId extends VisitorHouseIdState {}
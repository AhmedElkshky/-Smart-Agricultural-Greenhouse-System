part of 'get_green_house_data_cubit.dart';

@immutable
abstract class GetGreenHouseDataState {}

class GetGreenHouseDataInitial extends GetGreenHouseDataState {}

class SuccessGetAllGreenHouseDataWithDetail extends GetGreenHouseDataState {
  List<GetGreenHouseDataModel> listOfGreenHouseDataModel;
  SuccessGetAllGreenHouseDataWithDetail(
      {required this.listOfGreenHouseDataModel});
}
class ErrorGetAllGreenhouseState extends GetGreenHouseDataState {}
class LoadingGetAllGreenhouseState extends GetGreenHouseDataState {}
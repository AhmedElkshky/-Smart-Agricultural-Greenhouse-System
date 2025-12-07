part of 'get_requirement_data_cubit.dart';

@immutable
abstract class GetRequirementDataState {}

class GetRequirementDataInitial extends GetRequirementDataState {}
class LoadingGetRequirementDataReturn extends GetRequirementDataState {}
class FailedGetRequirementDataReturn extends GetRequirementDataState {}
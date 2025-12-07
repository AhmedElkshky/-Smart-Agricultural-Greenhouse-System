part of 'get_component_data_cubit.dart';

@immutable
abstract class GetComponentDataState {}

class GetComponentDataInitial extends GetComponentDataState {}
class LoadingGetComponentDataReturn extends GetComponentDataState {}
class FailedGetComponentDataReturn extends GetComponentDataState {}
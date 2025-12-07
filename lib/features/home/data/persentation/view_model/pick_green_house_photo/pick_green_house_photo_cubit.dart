import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/green_house_data/green_house_data_cubit.dart';

part 'pick_green_house_photo_state.dart';

class PickGreenHousePhotoCubit extends Cubit<PickGreenHousePhotoState> {
  PickGreenHousePhotoCubit() : super(PickGreenHousePhotoInitial());

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  String?  selectedPlanetId;

  void pickGreenHouseImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(PickGreenHouseImageSuccess());
  }

  Future<String> uploadGreenHouseImage({required BuildContext context , required String selectedPlanetId}) async {
    String url = "";
    // Create a storage reference from our app
    try {
      final storageRef = FirebaseStorage.instance.ref();
     //selectedPlanetId = context.read<GreenHouseDataCubit>().selectedPlanetId;

      final path =
          'GreenHouseImages/${selectedPlanetId}/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

      File file = File(image!.path);

      final upLoadedImage = await storageRef.child(path).putFile(file);

      url = await storageRef.child(path).getDownloadURL();



      emit(PickGreenHouseImageSuccess());

    } catch (e) {
      print('error-------------->${e.toString()}');
    }

    return url ;
  }
}

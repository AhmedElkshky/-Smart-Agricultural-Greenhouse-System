import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/check_user_type/check_user_type_cubit.dart';

part 'pick_user_image_state.dart';

class PickUserImageCubit extends Cubit<PickUserImageState> {

  PickUserImageCubit() : super(PickUserImageInitial());

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

   String? uId;

  void pickAnImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);

    emit(PickImageSuccess());
  }

  Future<String> uploadPhoto() async {
    String url = "";
    // Create a storage reference from our app
    try {
      final storageRef = FirebaseStorage.instance.ref();
       uId = FirebaseAuth.instance.currentUser!.uid;

      final path =
          'profile picture/${uId}/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

      File file = File(image!.path);

      final upLoadedImage = await storageRef.child(path).putFile(file);

      url = await storageRef.child(path).getDownloadURL();



      emit(PickImageSuccess());

    } catch (e) {
      print('error-------------->${e.toString()}');
    }

    return url ;
  }
}

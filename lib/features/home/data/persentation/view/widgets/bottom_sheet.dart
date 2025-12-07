import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_temperature_data/get_temperature_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/green_house_data/green_house_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/pick_green_house_photo/pick_green_house_photo_cubit.dart';
import '../../../../../../core/utiles/custom_buttons.dart';
import '../../../../../../core/utiles/custom_text_form_field.dart';
import '../../../../../create_user/persentation/view_model/pick_user_image/pick_user_image_cubit.dart';
import '../../view_model/get_green_house_data/get_green_house_data_cubit.dart';

void showBottomSheetPlanet({required BuildContext context}) {
  double widthScreen = MediaQuery.of(context).size.width;
  double heightScreen = MediaQuery.of(context).size.height;
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseIDController = TextEditingController();
  TextEditingController selectedPlanetController = TextEditingController();

  List<String> plants = [
    'Mint',
    'Tomatoes',
    'Potatoes',
    'Peas',
    'Beans',
    'Grapes',
    'Carrots',
    'Okra',
    'Cotton Plant',
    'Pepper',
    'Onions',
    'Garlic',
    'Arugula',
    'Eggplant',
    'Cucumber',
    'Cabbage',
    'Cauliflower',
    'Kohlrabi',
    'Turnip Rape',
    'Brussel Sprouts',
    'Bok Choy',
    'Cayenne Pepper',
    'Field Pumpkin',
    'Beet',
    'Winter Squash',
    'Sweet Potato',
    'Coriander',
    'Wild Celery',
    'Maize',
    'Spinach',
    'Globe Artichoke',
    'Lettuce',
    'Ginger',
    'Snake Plant',
    'Peace Lily',
    'Aloe Vera',
    'Lavender',
    'Rosemary',
    'Sunflowers',
    'Daffodils',
    'Marigolds',
    'Spider Plan',
    'Succulents',
    'Ficus Tree',
    'Pothos',
    'Rubber Plant',
    'Boston Fern',
    'Orchid',
  ];

  showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: 1000,
    ),
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ),
              BlocBuilder<PickGreenHousePhotoCubit, PickGreenHousePhotoState>(
                builder: (context, state) {
                  XFile? image =
                      context.read<PickGreenHousePhotoCubit>().image;
                  return (image != null)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                Image.file(File(image.path)).image,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.black,
                          ),
                        );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CustomButton(
                  onPressed: () {
                    context
                        .read<PickGreenHousePhotoCubit>()
                        .pickGreenHouseImage();
                  },
                  text: Text(
                    'Upload Photo',
                    style: TextStyle(
                      color: Color(0xff39D2C0),
                    ),
                  ),
                  color: Colors.white,
                  width: widthScreen * 0.33,
                  height: heightScreen * 0.0474,
                  radius: 30,
                  borderColor: Color(0xffC1F802),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: CustomTextFormField(
                      controller: houseNameController,
                      hintText: 'green house name',
                      bottomRightRadius: 0,
                      topRightRadius: 0,
                      suffixIcon: Icon(Icons.close),
                      prefixIcon: Icon(
                        Icons.text_fields_sharp,
                        color: Color(0xffDBEC0E),
                      ),
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: widthScreen * 0.6,
                      child: CustomTextFormField(
                        controller: houseIDController,
                        hintText: 'house ID',
                        bottomRightRadius: 0,
                        topRightRadius: 0,
                        suffixIcon: Icon(Icons.close),
                        prefixIcon: Icon(
                          Icons.text_fields_sharp,
                          color: Color(0xffDBEC0E),
                        ),
                        height: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: DropdownMenu(
                      controller: selectedPlanetController,
                      menuStyle: MenuStyle(),
                      menuHeight: 150,
                      width: widthScreen * 0.5,
                      hintText: 'select planet',
                      dropdownMenuEntries: plants
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  BlocBuilder<GetTemperatureDataCubit,
                      GetTemperatureDataState>(
                    builder: (context, tempState) {
                      if (tempState is LoadingGetTemperatureFireStore) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return BlocBuilder<GreenHouseDataCubit,
                          GreenHouseDataState>(
                        builder: (context, pushState) {
                          if (pushState
                              is LoadingFinalPushDataOnFirebaseState) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return CustomButton(
                              onPressed: () {
                                context
                                    .read<GetTemperatureDataCubit>()
                                    .getTemperatureFireStore(
                                        context: context, selectedPlanetId: selectedPlanetController.text);
                                if (tempState is SuccessGetTemperatureFireStore) {
                                  context
                                      .read<GreenHouseDataCubit>()
                                      .finalPushDataOnFirebase(
                                          context: context,
                                          selectedPlanetId:
                                              selectedPlanetController.text,
                                          greenHouseName:
                                              houseNameController.text,
                                          greenHouseId:
                                              houseIDController.text,
                                          selectedPlanet:
                                              selectedPlanetController.text, minTemperatureAtDay: tempState.minTemperatureAtDay, maxTemperatureAtDay:tempState.maxTemperatureAtDay, maxSoilMoisture: tempState.maxSoilMoisture);
                                  if (pushState
                                      is SuccessFinalPushDataOnFirebaseState) {

                                    // todo snakeBar Success
                                  } else if (pushState
                                      is FailedFinalPushDataOnFirebaseState) {
                                    // todo snakeBar error in push data
                                  }
                                } else {
                                  // todo snakeBar Error in read data
                                  print("Errorrrrrrrr");
                                }

                                // context
                                //     .read<GreenHouseDataCubit>()
                                //     .setSelectedPlanetId(selectedPlanetId:
                                //         selectedPlanetController.text);
                                //
                                // String greenHousePhoto = context
                                //     .read<PickGreenHousePhotoCubit>()
                                //     .uploadGreenHouseImage(context: context).toString();
                                //
                                // context.read<GreenHouseDataCubit>().greenHouseData(
                                //       greenHousePhoto: greenHousePhoto,
                                //       greenHouseName: houseNameController.text,
                                //       greenHouseId: houseIDController.text,
                                //       selectedPlanet: selectedPlanetController.text,
                                //     );
                                // context.read<GetTemperatureDataCubit>().getTemperatureFireStore(context: context);
                                // context.read<GreenHouseDataCubit>().pushDataFireStore();
                                // context.read<GreenHouseDataCubit>().pushDataRealTime(context: context);
                                // context.read<GetGreenHouseDataCubit>()
                                //     .getAllGreenHouseDataWithDetail(context: context);
                                // if(state is SuccessPushDataFireStore && state is SuccessPushDataRealTime){
                                //   Navigator.pop(context);
                                // }
                              },
                              text: Text(
                                'Add',
                                style: TextStyle(
                                  color: Color(0xff39D2C0),
                                ),
                              ),
                              color: Colors.white,
                              width: widthScreen * 0.33,
                              height: heightScreen * 0.0474,
                              radius: 30,
                              borderColor: Color(0xffC1F802),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      );
    },
  );
}

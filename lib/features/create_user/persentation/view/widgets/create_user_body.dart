import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/admin_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/farmer_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/check_user_type/check_user_type_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/pick_user_image/pick_user_image_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view/widgets/farmer_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view/widgets/login_screen_body.dart';

import '../../../../../core/utiles/custom_buttons.dart';
import '../../../../../core/utiles/custom_text_form_field.dart';
import '../../../../home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';

class CreateUserBody extends StatelessWidget {
  CreateUserBody({
    Key? key,
  }) : super(key: key);

  TextEditingController fullNameController = TextEditingController();
  String type = '';



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Create User',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<PickUserImageCubit, PickUserImageState>(
              builder: (context, state) {
                XFile? image = context.read<PickUserImageCubit>().image;
                return Column(
                  children: [
                    (image != null)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              backgroundImage:
                                  Image.file(File(image.path)).image,
                              backgroundColor: Colors.black,
                              radius: 60,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/user/anonymous-profile.png'),
                              backgroundColor: Colors.black,
                              radius: 60,
                            ),
                          ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomButton(
                  onPressed: () {
                    context.read<PickUserImageCubit>().pickAnImage();
                  },
                  text: Text(
                    'upload photo',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.white,
                  width: 130,
                  height: 40,
                  radius: 30),
            ),
            BlocBuilder<CheckUserTypeCubit, CheckUserTypeState>(
              builder: (context, state) {
                UserType? userType =
                    context.read<CheckUserTypeCubit>().userType;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CheckUserTypeCubit>()
                              .checkUserType(type: UserType.Admin);
                        },
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: (userType == UserType.Admin)
                                  ? Colors.black
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.admin_panel_settings_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CheckUserTypeCubit>()
                              .checkUserType(type: UserType.Farmer);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: (userType == UserType.Farmer)
                                  ? Colors.black
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(7),
                          child: Row(
                            children: [
                              Icon(
                                Icons.agriculture,
                                color: Colors.white,
                              ),
                              Text(
                                'Farmer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: CustomTextFormField(
                  controller: fullNameController,
                  hintText: 'Full name',
                  enabledOutBorder: true,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person),
                  height: 56,
                  topRightRadius: 0,
                  bottomRightRadius: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<CheckUserTypeCubit, CheckUserTypeState>(
                builder: (context, state) {
                  UserType? userType =
                      context.read<CheckUserTypeCubit>().userType;

                  return CustomButton(
                    onPressed: () async {
                      context.read<PickUserImageCubit>().uploadPhoto();

                      String photo = await context.read<PickUserImageCubit>().uploadPhoto();
                      print('photo---------------------->$photo');
                      String fullName = fullNameController.text;
                      UserType? userType =
                          context.read<CheckUserTypeCubit>().userType;
                      if (userType == UserType.Admin) {
                        type = 'Admin';
                      } else if (userType == UserType.Farmer) {
                        type = 'Farmer';
                      }
                      context.read<UserDataCubit>().userData(
                            photo: photo,
                            userType: type,
                            fullName: fullName,
                          );

                      context.read<UserDataCubit>().pushData();
                      TypeSignUP? typeSignUp = context.read<UserDataCubit>().typeSignUp;

                      if (type == 'Admin' || type == 'Farmer') {
                        if (typeSignUp == TypeSignUP.email){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginScreenBody();
                          },
                        ), (route) => false);
                        }
                        // edit navigation -------------------------------------------------------
                        else if (typeSignUp == TypeSignUP.google && userType == UserType.Admin ){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) {
                              return AdminNavigationBarBody();
                            },
                          ), (route) => false);
                        }
                        // edit navigation -------------------------------------------------------
                        else if (typeSignUp == TypeSignUP.google && userType == UserType.Farmer ){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) {
                              return FarmerNavigationBarBody();
                            },
                          ), (route) => false);
                        }


                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.grey,
                            content:
                                Text('please select you are admin or farmer'),
                          ),
                        );
                      }
                      context.read<GetGreenHouseDataCubit>()
                          .getAllGreenHouseDataWithDetail(context: context);
                    },
                    text: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    color: (userType == UserType.Admin || userType == UserType.Farmer) ? Colors.black : Colors.grey,
                    width: 230,
                    height: 50,
                    radius: 50,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

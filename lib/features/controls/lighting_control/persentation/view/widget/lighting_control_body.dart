import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/lighting_control/persentation/view_model/door_control/door_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/lighting_control/persentation/view_model/lamp_control/lamp_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_temperature_data/get_temperature_data_cubit.dart';

import '../../../../../control_page/persentation/view/widgets/custom_list_tile_control.dart';
import '../../../../../control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';

class LightingControlBody extends StatelessWidget {
  LightingControlBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  width: widthScreen * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                      Icon(
                        Icons.sunny,
                        color: Color(0xff6E6EDD),
                        size: 40,
                      ),
                      GradientText(
                        'Lighting Control',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ltr,
                        radius: 20,
                        colors: [
                          Color(0xff39D2C0),
                          Color(0xFF4B39EF),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: CustomListTileControl(
                  title: 'L A M P S',
                  subTitle: 'control the status of lighting',
                  icon: Icons.light_rounded,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff1B0453),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: BlocBuilder<LampControlCubit, LampControlState>(
                    builder: (context, state) {
                      String controlType = context
                          .read<LampControlCubit>()
                          .lampControlType
                          .toString();
                      if (controlType == 'LampControlType.AUTO') {
                        controlType = 'AUTO';
                      } else if (controlType == 'LampControlType.OFF') {
                        controlType = 'OFF';
                      } else if (controlType == 'LampControlType.ON') {
                        controlType = 'ON';
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            'LAMPS',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                            gradientType: GradientType.linear,
                            gradientDirection: GradientDirection.ltr,
                            radius: 20,
                            colors: [
                              Color(0xff39D2C0),
                              Color(0xFF4B39EF),
                            ],
                          ),
                          Radio(
                            value: 'AUTO',
                            groupValue: controlType,
                            onChanged: (val) {
                              context
                                  .read<LampControlCubit>()
                                  .lampControlTypeReturn(
                                      type: LampControlType.AUTO,
                                      context: context);
                            },
                          ),
                          Text(
                            'AUTO',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Radio(
                            value: 'OFF',
                            groupValue: controlType,
                            onChanged: (val) {
                              context
                                  .read<LampControlCubit>()
                                  .lampControlTypeReturn(
                                      type: LampControlType.OFF,
                                      context: context);
                            },
                          ),
                          Text(
                            'OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Radio(
                            value: 'ON',
                            groupValue: controlType,
                            onChanged: (val) {
                              context
                                  .read<LampControlCubit>()
                                  .lampControlTypeReturn(
                                      type: LampControlType.ON,
                                      context: context);
                            },
                          ),
                          Text(
                            'ON',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: CustomListTileControl(
                  title: 'Shading & ventilation ',
                  subTitle: 'control the status of the door',
                  icon: Icons.sunny,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color(0xff1B0453),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: BlocBuilder<DoorControlCubit, DoorControlState>(
                    builder: (context, state) {
                      String controlType = context
                          .read<DoorControlCubit>()
                          .doorControlType
                          .toString();
                      if (controlType == 'DoorControlType.AUTO') {
                        controlType = 'AUTO';
                      } else if (controlType == 'DoorControlType.CLOSE') {
                        controlType = 'CLOSE';
                      } else if (controlType == 'DoorControlType.MEDIUM') {
                        controlType = 'MEDIUM';
                      } else if (controlType == 'DoorControlType.OPEN') {
                        controlType = 'OPEN';
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GradientText(
                              'DOOR',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                              gradientType: GradientType.linear,
                              gradientDirection: GradientDirection.ltr,
                              radius: 20,
                              colors: [
                                Color(0xff39D2C0),
                                Color(0xFF4B39EF),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'AUTO',
                                    groupValue: controlType,
                                    onChanged: (val) {
                                      context
                                          .read<DoorControlCubit>()
                                          .doorControlTypeReturn(
                                              type: DoorControlType.AUTO,
                                              context: context);
                                    },
                                  ),
                                  Text(
                                    'AUTO',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Radio(
                                      value: 'CLOSE',
                                      groupValue: controlType,
                                      onChanged: (val) {
                                        context
                                            .read<DoorControlCubit>()
                                            .doorControlTypeReturn(
                                                type: DoorControlType.CLOSE,
                                                context: context);
                                      },
                                    ),
                                  ),
                                  Text(
                                    'CLOSE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'MEDIUM',
                                    groupValue: controlType,
                                    onChanged: (val) {
                                      context
                                          .read<DoorControlCubit>()
                                          .doorControlTypeReturn(
                                              type: DoorControlType.MEDIUM,
                                              context: context);
                                    },
                                  ),
                                  Text(
                                    'MEDIUM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Radio(
                                    value: 'OPEN',
                                    groupValue: controlType,
                                    onChanged: (val) {
                                      context
                                          .read<DoorControlCubit>()
                                          .doorControlTypeReturn(
                                              type: DoorControlType.OPEN,
                                              context: context);
                                    },
                                  ),
                                  Text(
                                    'OPEN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        width: widthScreen * 0.9,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(
                                0xff95A1AC,
                              ),
                              blurRadius: 8,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: BlocBuilder<GetTemperatureDataCubit,
                              GetTemperatureDataState>(
                            builder: (context, state) {

                              if (state is SuccessGetTemperatureFireStore){
                                String sunLight  = state.sunLight!;
                                return GradientText(
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  '${sunLight}',
                                  colors: [
                                    Color(0xff101213),
                                    Color(
                                      (0xffFCDC0C),
                                    ),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: widthScreen * 0.7,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              0xff95A1AC,
                            ),
                            blurRadius: 8,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: GradientText(
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ltr,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        'Sun Light Rang ',
                        colors: [
                          Color(0xff101213),
                          Color(
                            (0xffFCDC0C),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

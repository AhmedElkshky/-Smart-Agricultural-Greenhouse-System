import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/fan_control/fan_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/fan_speed/fan_speed_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/thermo_control/thermo_control_cubit.dart';

import '../../../../../control_page/persentation/view/widgets/custom_list_tile_control.dart';
import '../../../../../control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';

class CoolingControlBody extends StatelessWidget {
  CoolingControlBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      Icons.ac_unit,
                      color: Color(0xff6E6EDD),
                      size: 40,
                    ),
                    GradientText(
                      'Cooling Control',
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
              padding: const EdgeInsets.only(top: 30),
              child: CustomListTileControl(
                title: 'F A N',
                subTitle: 'control speed and status of the Fan',
                icon: Icons.mode_fan_off_outlined,
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
                child: BlocBuilder<FanControlCubit, FanControlState>(
                  builder: (context, state) {
                    String controlType = context
                        .read<FanControlCubit>()
                        .fanControlType
                        .toString();
                    if (controlType == 'FanControlType.AUTO') {
                      controlType = 'AUTO';
                    } else if (controlType == 'FanControlType.OFF') {
                      controlType = 'OFF';
                    } else if (controlType == 'FanControlType.ON') {
                      controlType = 'ON';
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          'FAN',
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
                                .read<FanControlCubit>()
                                .fanControlTypeReturn(
                                    type: FanControlType.AUTO,
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
                                .read<FanControlCubit>()
                                .fanControlTypeReturn(
                                    type: FanControlType.OFF, context: context);
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
                                .read<FanControlCubit>()
                                .fanControlTypeReturn(
                                    type: FanControlType.ON, context: context);
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
            BlocBuilder<FanControlCubit, FanControlState>(
              builder: (context, state) {
                FanControlType? fanControlType =
                    context.read<FanControlCubit>().fanControlType;
                if (fanControlType == FanControlType.ON) {
                  return Container(
                    height: heightScreen * 0.08,
                    width: widthScreen * 0.71,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 8,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BlocBuilder<FanSpeedCubit, FanSpeedState>(
                        builder: (context, state) {
                          double speedValue =
                              context.read<FanSpeedCubit>().fanSpeedValue;

                          return Row(
                            children: [
                              GradientText(
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.ltr,
                                  'Speed',
                                  colors: [
                                    Color(0xff39D2C0),
                                    Color(0xff4B39EF),
                                  ]),
                              Slider(
                                label: speedValue.round().toString(),
                                inactiveColor: Colors.white,
                                activeColor: Color(0xff39D2C0),
                                divisions: 5,
                                min: 0,
                                max: 5,
                                value: speedValue,
                                onChanged: (double newSpeed) {
                                  context
                                      .read<FanSpeedCubit>()
                                      .fanSpeedValueReturn(
                                          fanSpeed: newSpeed, context: context);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                } else
                  return SizedBox();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CustomListTileControl(
                title: 'H E A T',
                subTitle: 'control the Thermoelectric cooler ',
                icon: Icons.local_fire_department,
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
                child: BlocBuilder<ThermoControlCubit, ThermoControlState>(
                  builder: (context, state) {
                    String controlType = context
                        .read<ThermoControlCubit>()
                        .thermoControlType
                        .toString();

                    if (controlType == 'ThermoControlType.AUTO') {
                      controlType = 'AUTO';
                    } else if (controlType == 'ThermoControlType.OFF') {
                      controlType = 'OFF';
                    } else if (controlType == 'ThermoControlType.ON') {
                      controlType = 'ON';
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          'THERMO',
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
                                .read<ThermoControlCubit>()
                                .thermoControlTypeReturn(
                                    type: ThermoControlType.AUTO,
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
                                .read<ThermoControlCubit>()
                                .thermoControlTypeReturn(
                                    type: ThermoControlType.OFF,
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
                                .read<ThermoControlCubit>()
                                .thermoControlTypeReturn(
                                    type: ThermoControlType.ON,
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
          ],
        ),
      ),
    );
  }
}

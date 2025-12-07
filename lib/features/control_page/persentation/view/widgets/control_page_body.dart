import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/custom_actuators.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/custom_control.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/custom_list_tile_control.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/custom_requirement.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/buzzer_control/buzzer_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_component_data/get_component_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_requirement_data/get_requirement_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view/widgets/cooling_control_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/lighting_control/persentation/view/widget/lighting_control_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view/widget/watering_control_body.dart';

import '../../../../create_user/persentation/view_model/check_user_type/check_user_type_cubit.dart';
import '../../view_model/manual_auto/manual_auto_cubit.dart';
import 'custom_component.dart';

class ControlPageBody extends StatefulWidget {
  ControlPageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlPageBody> createState() => _ControlPageBodyState();
}

class _ControlPageBodyState extends State<ControlPageBody> {
  void initState() {
    super.initState();
    context
        .read<GetComponentDataCubit>()
        .getComponentDataReturn(context: context);
    context.read<GetActuatorsDataCubit>().getAcDataReturn(context: context);
    context.read<GetRequirementDataCubit>().getRequirementDataReturn(context: context);
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff39D2C0), Color(0xFF4B39EF)],
  ).createShader(Rect.fromLTWH(30.0, 20.0, 200.0, 70.0));

  List<String> listOfText = [
    'Out Temp',
    'Temperature',
    'Humidity',
    'Moisture',
    'Co2',
    'Light',
    'Water Tank',
    'Distance',
    'Motion',
  ];

  List<IconData> listOfIcons = [
    Icons.cloudy_snowing,
    Icons.thermostat,
    Icons.air,
    Icons.water,
    Icons.co2_outlined,
    Icons.sunny,
    Icons.water_drop_outlined,
    Icons.social_distance,
    Icons.man,
  ];

  List<String> listOfAcrText = [
    'FAN',
    'THERMO',
    'PUMP',
    'LAMP',
    'DOOR',
    'BUZZER',
  ];

  List<IconData> listOfAcrIcons = [
    Icons.mode_fan_off_outlined,
    Icons.local_fire_department_outlined,
    Icons.water_drop,
    Icons.light,
    Icons.roller_shades_closed_sharp,
    Icons.notifications,
  ];

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${context.read<CurrentGreenHouseIdCubit>().greenHouseName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Control & view',
                style: TextStyle(
                  color: Color(0xff57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                  width: widthScreen * 0.70,
                  child: BlocBuilder<ManualAutoCubit, ManualAutoState>(
                    builder: (context, state) {
                      String controlType = context
                          .read<ManualAutoCubit>()
                          .controlType
                          .toString();
                      if (controlType == 'ControlType.Manual') {
                        controlType = 'Manual';
                      } else if (controlType == 'ControlType.Auto') {
                        controlType = 'Auto';
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Control',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                          Radio(
                            value: 'Manual',
                            groupValue: controlType,
                            onChanged: (val) {
                              context.read<ManualAutoCubit>().controlTypeReturn(
                                  type: ControlType.Manual, context: context);
                            },
                          ),
                          Text(
                            'Manual',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Radio(
                            value: 'Auto',
                            groupValue: controlType,
                            onChanged: (val) {
                              context.read<ManualAutoCubit>().controlTypeReturn(
                                  type: ControlType.Auto, context: context);
                            },
                          ),
                          Text(
                            'Auto',
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xff57636C)),
                        ),
                        Text(
                          'Good',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff2F615A)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Harvest',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xff57636C)),
                        ),
                        Text(
                          '1m',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Duration',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xff57636C)),
                        ),
                        Text(
                          '2m',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<String>>(
                  stream:
                      context.read<GetComponentDataCubit>().componentDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      // Handle errors (optional)
                      return Text('Error: ${snapshot.error}');
                    }
                    try {
                      if (snapshot.hasData) {
                        final listOfComponentData = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 361,
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: listOfText.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return CustomComponent(
                                    icon: listOfIcons[index],
                                    text: listOfText[index],
                                    data: (index == 0 || index == 1)
                                        ? "${listOfComponentData[index]} ℃"
                                        : (index == 2)
                                            ? "${listOfComponentData[index]} %"
                                            : (index == 7)
                                                ? "${listOfComponentData[index]} cm"
                                                : listOfComponentData[index]);
                              },
                            ),
                          ),
                        );
                      } else {
                        // Handle no data case (optional)
                        return Center(child: Text('No data available'));
                      }
                    } catch (error) {
                      print('Error building UI: $error');
                      // Handle UI building errors (optional)
                      return Text('Error: An error occurred');
                    }
                  }),
              StreamBuilder<List<String>>(
                stream:
                    context.read<GetActuatorsDataCubit>().actuatorDataStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    // Handle errors (optional)
                    return Text('Error: ${snapshot.error}');
                  }
                  try {
                    if (snapshot.hasData) {
                      final listOfAcData = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 80, bottom: 20),
                        child: Container(
                          width: widthScreen,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Color(0xffF1F4F8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: GradientText(
                                  'ACTUATORS',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.ltr,
                                  radius: 20,
                                  colors: [
                                    Color(0xff101213),
                                    Color(0xFF4B39EF),
                                  ],
                                ),
                              ),
                              Container(
                                width: widthScreen * 0.86,
                                height: 221,
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: listOfAcrText.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return CustomActuators(
                                      text: listOfAcrText[index],
                                      icon: listOfAcrIcons[index],
                                      data: listOfAcData[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Handle no data case (optional)
                      return Center(child: Text('No data available'));
                    }
                  } catch (error) {
                    print('Error building UI: $error');
                    // Handle UI building errors (optional)
                    return Text('Error: An error occurred');
                  }

                  //Show loading indicator while waiting for data
                  return Center(child: CircularProgressIndicator());
                },
              ),
              BlocBuilder<ManualAutoCubit, ManualAutoState>(
                builder: (context, state) {
                  ControlType? controlType =
                      context.read<ManualAutoCubit>().controlType;
                  if (controlType == ControlType.Manual) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: widthScreen,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black87,
                                      Colors.white,
                                    ])),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GradientText(
                                    'REQUIREMENT ',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    gradientType: GradientType.linear,
                                    gradientDirection: GradientDirection.ltr,
                                    radius: 20,
                                    colors: [
                                      Color(0xffFCDC0C),
                                      Color(0xFF4B39EF),
                                    ],
                                  ),
                                ),
                                StreamBuilder<List<String>>(
                                    stream: context
                                        .read<GetRequirementDataCubit>()
                                        .requirementDataStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        // Handle errors (optional)
                                        return Text('Error: ${snapshot.error}');
                                      }
                                      try {
                                        if (snapshot.hasData) {
                                          final listOfReData = snapshot.data!;
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomRequirement(
                                                    text: 'Lighting', borderColor: (listOfReData[0] == '0')? Colors.red : null,),
                                                CustomRequirement(
                                                    text: (listOfReData[1] == '0')?'Cooling':(listOfReData[1] == '1')?'Heating':'Cooling', borderColor: (listOfReData[1] == '0' || listOfReData[1] == '1' )? Colors.red : null, ),
                                                CustomRequirement(
                                                    text: 'Watering' , borderColor: (listOfReData[2] == '0')? Colors.red : null,),
                                              ],
                                            ),
                                          );
                                        } else {
                                          // Handle no data case (optional)
                                          return Center(
                                              child: Text('No data available'));
                                        }
                                      } catch (error) {
                                        print('Error building UI: $error');
                                        // Handle UI building errors (optional)
                                        return Text('Error: An error occurred');
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomControl(
                              icon: Icons.sunny,
                              text: 'Lighting',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LightingControlBody();
                                    },
                                  ),
                                );
                              },
                            ),
                            CustomControl(
                              icon: Icons.mode_fan_off_outlined,
                              text: 'cooling',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CoolingControlBody();
                                    },
                                  ),
                                );
                              },
                            ),
                            CustomControl(
                              icon: Icons.water_drop,
                              text: 'Watering',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WateringControlBody();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: CustomListTileControl(
                            title: 'A L E R T',
                            subTitle: 'control the status of lighting',
                            icon: Icons.circle_notifications_sharp,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
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
                            child: BlocBuilder<BuzzerControlCubit,
                                BuzzerControlState>(
                              builder: (context, state) {
                                String? controlType = context
                                    .read<BuzzerControlCubit>()
                                    .buzzerControlType
                                    .toString();
                                if (controlType == 'BuzzerControlType.AUTO') {
                                  controlType = 'AUTO';
                                } else if (controlType ==
                                    'BuzzerControlType.OFF') {
                                  controlType = 'OFF';
                                } else if (controlType ==
                                    'BuzzerControlType.ON') {
                                  controlType = 'ON';
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GradientText(
                                      'BUZZER',
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
                                            .read<BuzzerControlCubit>()
                                            .buzzerControlReturn(
                                                type: BuzzerControlType.AUTO,
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
                                            .read<BuzzerControlCubit>()
                                            .buzzerControlReturn(
                                                type: BuzzerControlType.OFF,
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
                                            .read<BuzzerControlCubit>()
                                            .buzzerControlReturn(
                                                type: BuzzerControlType.ON,
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
                    );
                  } else
                    return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

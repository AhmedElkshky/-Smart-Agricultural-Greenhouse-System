import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_green_agriculture_graduation_project/core/utiles/custom_buttons.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/custom_list_tile_control.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view_model/timer/timer_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view_model/watering_control/pump_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_temperature_data/get_temperature_data_cubit.dart';

import '../../../../../control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';

class WateringControlBody extends StatelessWidget {
  WateringControlBody({Key? key}) : super(key: key);
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                        Icons.water_drop_outlined,
                        color: Color(0xff6E6EDD),
                        size: 40,
                      ),
                      GradientText(
                        'Watering Control',
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
                padding: const EdgeInsets.only(top: 50),
                child: CustomListTileControl(
                  title: 'watering',
                  subTitle: 'start watering the plant',
                  icon: Icons.water_drop,
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
                  child: BlocBuilder<PumpControlCubit, PumpControlState>(
                    builder: (context, state) {
                      String controlType = context
                          .read<PumpControlCubit>()
                          .pumpControlType
                          .toString();
                      if (controlType == 'PumpControlType.AUTO') {
                        controlType = 'AUTO';
                      } else if (controlType == 'PumpControlType.OFF') {
                        controlType = 'OFF';
                      } else if (controlType == 'PumpControlType.ON') {
                        controlType = 'ON';
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            'PUMP',
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
                                  .read<PumpControlCubit>()
                                  .pumpControlTypeReturn(
                                      type: PumpControlType.AUTO,
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
                                  .read<PumpControlCubit>()
                                  .pumpControlTypeReturn(
                                      type: PumpControlType.OFF,
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
                                  .read<PumpControlCubit>()
                                  .pumpControlTypeReturn(
                                      type: PumpControlType.ON,
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
              BlocBuilder<PumpControlCubit, PumpControlState>(
                builder: (context, state) {
                  PumpControlType pumpControlType =
                      context.read<PumpControlCubit>().pumpControlType;
                  if (pumpControlType == PumpControlType.ON) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          width: widthScreen * 0.6,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GradientText(
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                                'Timer To Stop',
                                colors: [
                                  Color(0xff090F13),
                                  Color(0xff1790E0),
                                ],
                              ),
                              BlocBuilder<TimerCubit, TimerState>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      (state is TimerRunning)
                                          ? Text(
                                              '${state.minutes} : ${state.seconds}',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                  child: TextField(
                                                    controller:
                                                        minutesController,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: '00',
                                                      helperStyle: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ':',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: TextField(
                                                      controller:
                                                          secondsController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: '00',
                                                        helperStyle: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomButton(
                            text: Text(
                              'Start Timer',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            color: Colors.white54,
                            width: widthScreen * 0.3,
                            height: 50,
                            radius: 20,
                            onPressed: () {
                              if (context.read<TimerCubit>().timerRunning ==
                                  true) {
                                return null;
                              } else {
                                return context.read<TimerCubit>().startTimer(
                                      minutes: int.tryParse(
                                              minutesController.text) ??
                                          0,
                                      seconds: int.tryParse(
                                              secondsController.text) ??
                                          0,
                                      context: context,
                                    );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return SizedBox();
                },
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
                                String wateringFactor = state.wateringFactor!;
                                return GradientText(
                                  textAlign: TextAlign.center,
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  '${wateringFactor.toString()}',
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
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        'Watering Frequency Factors',
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

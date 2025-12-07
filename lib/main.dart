import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/control_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/buzzer_control/buzzer_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_component_data/get_component_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_requirement_data/get_requirement_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/manual_auto/manual_auto_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/fan_control/fan_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/fan_speed/fan_speed_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/cooling_control/persentation/view_model/thermo_control/thermo_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/lighting_control/persentation/view_model/door_control/door_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/lighting_control/persentation/view_model/lamp_control/lamp_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view_model/timer/timer_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/controls/watering_control/persentation/view_model/watering_control/pump_control_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view/widgets/create_user_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/check_user_type/check_user_type_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/pick_user_image/pick_user_image_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view/widgets/farmer_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view_model/green_house_id/green_house_id_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_temperature_data/get_temperature_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/green_house_data/green_house_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/pick_green_house_photo/pick_green_house_photo_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view_model/sign_in_with_email_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/vistor_page/persentation/view_model/visitor_house_id/visitor_house_id_cubit.dart';
import 'features/create_account/persentation/view_model/create_email_acount/create_email_account_cubit.dart';
import 'features/home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';
import 'features/splash screen/persentation/view/widgets/splash_screen_body.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  /* runApp( DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),);*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickUserImageCubit(),
        ),
        BlocProvider(
          create: (context) => CreateEmailAccountCubit(),
        ),
        BlocProvider(
          create: (context) => CheckUserTypeCubit(),
        ),
        BlocProvider(
          create: (context) => UserDataCubit(),
        ),
        BlocProvider(
          create: (context) => PickGreenHousePhotoCubit(),
        ),
        BlocProvider(
          create: (context) => GreenHouseDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetGreenHouseDataCubit(),
        ),
        BlocProvider(
          create: (context) => ManualAutoCubit(),
        ),
        BlocProvider(
          create: (context) => BuzzerControlCubit(),
        ),
        BlocProvider(
          create: (context) => FanControlCubit(),
        ),
        BlocProvider(
          create: (context) => FanSpeedCubit(),
        ),
        BlocProvider(
          create: (context) => ThermoControlCubit(),
        ),
        BlocProvider(
          create: (context) => LampControlCubit(),
        ),
        BlocProvider(
          create: (context) => DoorControlCubit(),
        ),
        BlocProvider(
          create: (context) => PumpControlCubit(),
        ),

        BlocProvider(
          create: (context) => TimerCubit(),
        ),
        BlocProvider(
          create: (context) => GreenHouseIdCubit(),
        ),
        BlocProvider(
          create: (context) => CurrentGreenHouseIdCubit(),
        ),
        BlocProvider(
          create: (context) => GetActuatorsDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetComponentDataCubit(),
        ),
        BlocProvider(
          create: (context) => VisitorHouseIdCubit(),
        ),
        BlocProvider(
          create: (context) => GetTemperatureDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetRequirementDataCubit(),
        ),
        BlocProvider(
          create: (context) => SignInWithEmailCubit(),
        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          /*locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,*/
          home: SplashScreenBody()),
    );
  }
}

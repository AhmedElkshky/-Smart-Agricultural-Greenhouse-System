/*import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../current_green_house_id/current_green_house_id_cubit.dart';

part 'get_actuators_data_state.dart';

class GetActuatorsDataCubit extends Cubit<GetActuatorsDataState> {
  GetActuatorsDataCubit() : super(GetActuatorsDataInitial());
  List<String> actuatorData = [];
  String? myFanData;
  String? myThermoData;
  String? myPumpData;
  String? myLampData;
  String? myDoorData;
  String? myBuzzerData;


  void getAcDataReturn({required BuildContext context}) async {

    emit(LoadingGetAcDataReturn());
     List<String> myActuatorData = [];
    try {
        String? greenHouseId =
          context.read<CurrentGreenHouseIdCubit>().greenHouseId;
//------------------------------------------------------------
      final fanDataRef = await FirebaseDatabase.instance
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Fan_state_return');
      await fanDataRef.onValue.listen((DatabaseEvent event) async {
        String myFanData1 = await event.snapshot.value.toString();
        if (myFanData1 == '0') {
          myFanData = 'OFF';
        }
        if (myFanData1 == '1') {
          myFanData = 'ON';
        }

      });
//-------------------------------------------------------------
        final thermoDataRef = await FirebaseDatabase.instance
            .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Thermo_state_return');
        await thermoDataRef.onValue.listen((DatabaseEvent event) async {
          String myThermoData1 = await event.snapshot.value.toString();
          if (myThermoData1 == '0') {
            myThermoData = 'OFF';
          }
          if (myThermoData1 == '1') {
            myThermoData = 'ON';
          }

        });
//-------------------------------------------------------------
        final pumpDataRef = await FirebaseDatabase.instance
            .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Pump_state_return');
        await pumpDataRef.onValue.listen((DatabaseEvent event) async {
          String myPumpData1 = await event.snapshot.value.toString();
          if (myPumpData1 == '0') {
            myPumpData = 'OFF';
          }
          if (myPumpData1 == '1') {
            myPumpData = 'ON';
          }

        });
//-------------------------------------------------------------
        final lampDataRef = await FirebaseDatabase.instance
            .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Lamp_state_return');
        await lampDataRef.onValue.listen((DatabaseEvent event) async {
          String myLampData1 = await event.snapshot.value.toString();
          if (myLampData1 == '0') {
            myLampData = 'OFF';
          }
          if (myLampData1 == '1') {
            myLampData = 'ON';
          }

        });
//-------------------------------------------------------------
      final doorDataRef = await FirebaseDatabase.instance
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Door_state_return');
      await doorDataRef.onValue.listen((DatabaseEvent event) async {
        String myDoorData1 = await event.snapshot.value.toString();
        if (myDoorData1 == '3') {
          myDoorData = 'CLOSE';
        }
        if (myDoorData1 == '2') {
          myDoorData = 'MEDIUM';
        }
        if (myDoorData1 == '1') {
          myDoorData = 'OPEN';
        }
//-------------------------------------------------------------

        final buzzerDataRef = await FirebaseDatabase.instance
            .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Buzzer_state_return');
        await buzzerDataRef.onValue.listen((DatabaseEvent event) async {
          String myBuzzerData1 = await event.snapshot.value.toString();
          if (myBuzzerData1 == '0') {
            myBuzzerData = 'OFF';
          }
          if (myBuzzerData1 == '1') {
            myBuzzerData = 'ON';
          }

        });

      });

//---------------------------------------------------------------
      myActuatorData = [myFanData!,myThermoData!,myPumpData!,myLampData!,myDoorData!,myBuzzerData!];
      actuatorData = myActuatorData;
      emit(SuccessGetAcDataReturn(actuatorData:actuatorData ));


    } catch (e) {
      emit(FailedGetAcDataReturn());
      print('actuator error -------------->${e.toString()}');
    }

  }

}*/

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../current_green_house_id/current_green_house_id_cubit.dart';

part 'get_actuators_data_state.dart';

class GetActuatorsDataCubit extends Cubit<GetActuatorsDataState> {
  GetActuatorsDataCubit() : super(GetActuatorsDataInitial());

  final _actuatorDataSubject = BehaviorSubject<List<String>>();

  Stream<List<String>> get actuatorDataStream => _actuatorDataSubject.stream;

  String? greenHouseId;

  void getAcDataReturn({required BuildContext context}) async {
    emit(LoadingGetAcDataReturn());

    try {
      greenHouseId = context.read<CurrentGreenHouseIdCubit>().greenHouseId;
//------------------------------------------------------------
      final database = FirebaseDatabase.instance;

      final fanDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Fan_state_return')
          .onValue
          .map((event) => _convertFanToString(event.snapshot.value));

      final thermoDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Thermo_state_return')
          .onValue
          .map((event) => _convertThermoToString(event.snapshot.value));

      final pumpDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Pump_state_return')
          .onValue
          .map((event) => _convertPumpToString(event.snapshot.value));

      final lampDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Lamp_state_return')
          .onValue
          .map((event) => _convertLampToString(event.snapshot.value));

      final doorDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Door_state_return')
          .onValue
          .map((event) => _convertDoorData(event.snapshot.value));

      final buzzerDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Buzzer_state_return')
          .onValue
          .map((event) => _convertBuzzerToString(event.snapshot.value));

      // Combine all streams into a single stream of actuator data
      final combinedStream = Rx.combineLatest6(
          fanDataStream,
          thermoDataStream,
          pumpDataStream,
          lampDataStream,
          doorDataStream,
          buzzerDataStream,
          (fanData, thermoData, pumpData, lampData, doorData, buzzerData) => [
                _convertFanToString(fanData),
                _convertThermoToString(thermoData),
                _convertPumpToString(pumpData),
                _convertLampToString(lampData),
                _convertDoorData(doorData),
                _convertBuzzerToString(buzzerData),
              ]);

      combinedStream.listen((actuatorData) {
        _actuatorDataSubject.add(actuatorData);
        print('Actuator data emitted: $actuatorData'); // Added for verification
      });
    } catch (e) {
      emit(FailedGetAcDataReturn());
      print('actuator error -------------->${e.toString()}');
    }
  }

  String _convertFanToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertThermoToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertPumpToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertLampToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertBuzzerToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertDoorData(dynamic value) {
    if (value == '3') {
      return 'CLOSE';
    } else if (value == '2') {
      return 'MEDIUM';
    } else if (value == '1') {
      return 'OPEN';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  @override
  Future<void> close() async {
    _actuatorDataSubject.close();
    super.close();
  }
}

/*final thermoData = await ref
          .child('GREENHOUSE/$greenHouseId/ACTUATORS/Thermo_state_return')
          .get();
      final pumpData = await ref
          .child('GREENHOUSE/$greenHouseId/ACTUATORS/Pump_state_return')
          .get();
      final lampData = await ref
          .child('GREENHOUSE/$greenHouseId/ACTUATORS/Lamp_state_return')
          .get();
      final doorData = await ref
          .child('GREENHOUSE/$greenHouseId/ACTUATORS/Door_state_return')
          .get();
      final buzzerData = await ref
          .child('GREENHOUSE/$greenHouseId/ACTUATORS/Buzzer_state_return')
          .get();*/

/*  if (myFanData == '0') {
        myFanData = 'OFF';
      }
      if (fanData == '1') {
        myFanData = 'ON';
      }
      if (thermoData.value.toString() == '0') {
        myThermoData = 'OFF';
      }
      if (thermoData.value.toString() == '1') {
        myThermoData = 'ON';
      }
      if (pumpData.value.toString() == '0') {
        myPumpData = 'OFF';
      }
      if (pumpData.value.toString() == '1') {
        myPumpData = 'ON';
      }
      if (lampData.value.toString() == '0') {
        myLampData = 'OFF';
      }
      if (lampData.value.toString() == '1') {
        myLampData = 'ON';
      }
      if (doorData.value.toString() == '3') {
        myDoorData = 'CLOSE';
      }
      if (doorData.value.toString() == '2') {
        myDoorData = 'MEDIUM';
      }
      if (doorData.value.toString() == '1') {
        myDoorData = 'OPEN';
      }
      if (buzzerData.value.toString() == '0') {
        myBuzzerData = 'OFF';
      }
      if (buzzerData.value.toString() == '1') {
        myBuzzerData = 'ON';
      }
      actuatorData = [
        myFanData!,
        myThermoData!,
        myPumpData!,
        myLampData!,
        myDoorData!,
        myBuzzerData!,
      ];*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/vistor_page/persentation/view_model/visitor_house_id/visitor_house_id_cubit.dart';

import '../../../../../core/utiles/custom_text_form_field.dart';
import '../../../../control_page/persentation/view/widgets/custom_component.dart';
import '../../../../control_page/persentation/view_model/get_component_data/get_component_data_cubit.dart';
import '../../../../home/data/persentation/view_model/get_green_house_data_model/get_green_house_data_model.dart';

class VisitorPageBody extends StatelessWidget {
  VisitorPageBody({Key? key}) : super(key: key);

  TextEditingController greenHouseIdController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Smart green house',
                  style: TextStyle(
                    color: Color(0xff160953),
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Agriculture is under control',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CustomTextFormField(
                  onFieldSubmitted: (val) async {
                    context.read<VisitorHouseIdCubit>().checkVisitorHouseId(
                        greenHouseId: greenHouseIdController.text,
                        context: context);
                    context
                        .read<GetComponentDataCubit>()
                        .getComponentDataReturn(context: context);
                    greenHouseIdController!.text = '';

                  },
                  controller: greenHouseIdController,
                  hintText: 'GreenHouse ID',
                  prefixIcon: Icon(
                    Icons.text_fields_sharp,
                    color: Color(0xffDBEC0E),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      greenHouseIdController!.text = '';
                    },
                    icon: Icon(Icons.close),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  height: 60,
                  topRightRadius: 30,
                  bottomRightRadius: 0,
                ),
              ),
              BlocBuilder<VisitorHouseIdCubit, VisitorHouseIdState>(
                builder: (context, state) {
                  if (state is LoadingCheckVisitorHouseId) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SuccessCheckVisitorHouseId) {
                    List<GetGreenHouseDataModel> lisOGreenHouses =
                        state.getGreenHouseDataModel!;
                    return Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: lisOGreenHouses.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xff39D2C0),
                                        Color(0xFF4B39EF),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    leading: (lisOGreenHouses[index]
                                                .greenHousePhoto !=
                                            null)
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${lisOGreenHouses[index].greenHousePhoto}'),
                                            radius: 30,
                                          )
                                        : CircleAvatar(
                                            radius: 30,
                                          ),
                                    title: Text(
                                      '${lisOGreenHouses[index].greenHouseName}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      '${lisOGreenHouses[index].selectedPlanet}',
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                    trailing: Text(
                                      '${lisOGreenHouses[index].greenHouseId}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        StreamBuilder<List<String>>(
                            stream: context
                                .read<GetComponentDataCubit>()
                                .componentDataStream,
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

                                  final listOfComponentData = snapshot.data!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFF4B39EF),
                                              width: 3),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30))),
                                      height: 415,
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
                                                          : listOfComponentData[
                                                              index]);
                                        },
                                      ),
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
                    );
                  }

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

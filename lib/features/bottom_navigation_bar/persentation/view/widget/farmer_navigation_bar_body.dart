import 'package:flutter/material.dart';
import 'package:smart_green_agriculture_graduation_project/features/detect_planet/persentation/view/widget/detect_planet_page.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view/widgets/farmer_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/setting_page/persentation/view/widget/setting_page.dart';

class FarmerNavigationBarBody extends StatefulWidget {
  FarmerNavigationBarBody({Key? key}) : super(key: key);

  @override
  State<FarmerNavigationBarBody> createState() => _FarmerNavigationBarBodyState();
}

class _FarmerNavigationBarBodyState extends State<FarmerNavigationBarBody> {
  int selectedIndex = 0;
  List farmerNav = [FarmerPageBody(), DetectPlanetPage(), SettingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF160953),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass_outlined),
            label: 'Planet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
      body: farmerNav[selectedIndex],
    );
  }
}

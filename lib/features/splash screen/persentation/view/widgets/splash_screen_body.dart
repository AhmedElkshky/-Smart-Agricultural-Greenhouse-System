import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../on_boarding_screen/persentation/view/widgets/on_boarding_body.dart';


class SplashScreenBody extends StatefulWidget {
  SplashScreenBody({Key? key}) : super(key: key);

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
      () {
       /* if (FirebaseAuth.instance.currentUser == null){*/
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OnBoardingBody();
              },
            ),
          );
        // }
       /* else {
          Navigator to home screen
        }*/
      },
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Smart Agricultural Green House',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

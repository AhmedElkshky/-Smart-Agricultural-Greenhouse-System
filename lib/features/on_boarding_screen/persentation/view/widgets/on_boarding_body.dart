import 'package:flutter/material.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view/widgets/login_screen_body.dart';

import '../../../../../core/utiles/custom_buttons.dart';
import '../../view_model/on_boarding_model.dart';

class OnBoardingBody extends StatefulWidget {
  OnBoardingBody({Key? key}) : super(key: key);

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  List<OnBoardingModel> onBoardingContent = [
    OnBoardingModel(
      image: 'assets/images/on_boarding/smart-agriculture.jpg',
      title: 'The Future Of Agriculture',
      description: 'Keep track of all future agriculture in one\napplication.',
    ),
    OnBoardingModel(
      image: 'assets/images/on_boarding/Smart-farming-LetsNurture.jpg',
      title: 'Full Control',
      description:
          'Always have control over your farming,\ntemp,water,soil,light,humidity and range.',
    ),
    OnBoardingModel(
      image: 'assets/images/on_boarding/3461225.jpg',
      title: 'Easy  Speed  Accuracy',
      description:
          'With an artificial intelligence model, we guarantee\naccuracy and production efficiency',
    ),
  ];

  int currentIndex = 0 ;
  PageController? _pageController;
@override
  void initState() {
   _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }
  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/on_boarding/logo.jpg',
                  width: widthScreen * 0.3,
                  height: heightScreen * 0.2,
                ),
                SizedBox(
                  width: widthScreen*0.16,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreenBody();
                        },
                      ), (route) => false);
                    },
                    child: Text("Skip"),
                )
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardingContent.length,
                onPageChanged: (index) {
                  setState(
                    () {
                      currentIndex = index;
                    },
                  );
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          onBoardingContent[index].image,
                          width: widthScreen,
                          height: heightScreen * 0.48,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          onBoardingContent[index].title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          onBoardingContent[index].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingContent.length,
                  (index) {
                    return buildDots(index);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: CustomButton(
                  onPressed: () {
                    if (currentIndex == onBoardingContent.length - 1) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreenBody();
                        },
                      ), (route) => false);
                    }
                    _pageController?.nextPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.bounceIn);
                  },
                  text: Text(
                    (currentIndex == onBoardingContent.length - 1)
                        ? 'Continue'
                        : 'Next',
                    style: TextStyle(
                      color: Color(0xff39D2C0),
                    ),
                    // style: Theme.of(context).textTheme.titleLarge,
                  ),
                  color: Color(0xffF0F5F6),
                  width: widthScreen * 0.5,
                  height: heightScreen * 0.058,
                  radius: 40),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDots(int index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 5,
      width: (currentIndex == index ) ? 30 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff95A1AC),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view/widgets/create_user_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view_model/sign_in_with_email_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/vistor_page/persentation/view/widget/vistor_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/firebase_services/firebase_authentication.dart';

import '../../../../../core/utiles/custom_buttons.dart';

import '../../../../../core/utiles/custom_text_form_field.dart';
import '../../../../create_account/persentation/view/widgets/create_account_body.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key? key}) : super(key: key);

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.white, Color(0xFFBAEF39)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  double myHeightScreen1 = 784;

  double myWidthScreen1 = 384;

  TextEditingController? emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/login_screen/115-600x600.jpg',
                      // height: 0.1*heightScreen,
                      height: 60 / myHeightScreen1 * heightScreen,
                      width: widthScreen,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'smart agriculture green house',
                      style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/login_screen/3461225.jpg',
                  width: widthScreen,
                  height: heightScreen * 0.25,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                'Welcome!',
                style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: CustomTextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.contains('@') ||
                        !value.contains('.') ||
                        !value.contains('gmail')) {
                      return 'your email not correct';
                    }
                    return null;
                  },
                  hintText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xffDBEC0E),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      emailController!.text = '';
                    },
                    icon: Icon(Icons.close),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  height: 60 / myHeightScreen1 * heightScreen,
                  topRightRadius: 30,
                  bottomRightRadius: 0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: CustomObscureTextFiled(passwordController: passwordController,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed(createAccountScreen,);
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CreateAccountBody();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffDBEC0E),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          context.read<SignInWithEmailCubit>().signInWithEmailPassword(email: emailController!.text, password: passwordController!.text, context: context);

                          /*
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                          return BottomNavView();
                        }), (route) => false);*/
                        }
                      },
                      text: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      color: Colors.black,
                      borderColor: Color(0xffC1F802),
                      width: 130,
                      height: 50,
                      radius: 30,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  /* Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ForgotPasswordView();
                    },
                  ),
                );*/
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'Use a Social Platform to Login',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xB2FFFFFF),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        context
                            .read<UserDataCubit>()
                            .googleData(context: context);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images/login_screen/Google.png',
                          width: widthScreen * 0.11,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images/login_screen/phone.png',
                          width: widthScreen * 0.10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return VisitorPageBody();
                        },
                      ),
                    );
                  },
                  text: Text(
                    'Continue as Guest',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.black,
                  width: 230 / myWidthScreen1 * widthScreen,
                  height: 50 / myHeightScreen1 * heightScreen,
                  radius: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomObscureTextFiled extends StatefulWidget {
  CustomObscureTextFiled({Key? key , required this.passwordController}) : super(key: key);
TextEditingController passwordController;
  @override
  State<CustomObscureTextFiled> createState() => _CustomObscureTextFiledState();
}

class _CustomObscureTextFiledState extends State<CustomObscureTextFiled> {
  bool _isObscured = true;
  double myHeightScreen1 = 784;

  double myWidthScreen1 = 384;


  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return CustomTextFormField(
      controller: widget.passwordController,
      obscureText: _isObscured,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      hintText: 'Password',
      prefixIcon: Icon(
        Icons.lock_outline,
        color: Color(0xffDBEC0E),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          setState(
            () {
              _isObscured = !_isObscured;
            },
          );
        },
        icon: (_isObscured)
            ? Icon(Icons.visibility_off_outlined)
            : Icon(Icons.visibility_outlined),
      ),
      filled: true,
      fillColor: Colors.white,
      height: 60 / myHeightScreen1 * heightScreen,
      topRightRadius: 30,
      bottomRightRadius: 0,
    );
  }
}

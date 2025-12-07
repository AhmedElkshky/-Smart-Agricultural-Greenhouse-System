import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_account/persentation/view_model/create_email_acount/create_email_account_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view/widgets/create_user_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/vistor_page/persentation/view/widget/vistor_page_body.dart';

import '../../../../../core/utiles/custom_buttons.dart';
import '../../../../../core/utiles/custom_text_form_field.dart';
import '../../../../../firebase_services/firebase_authentication.dart';

class CreateAccountBody extends StatelessWidget {
  CreateAccountBody({Key? key}) : super(key: key);
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff39D2C0), Color(0xFF4B39EF)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'The future of agriculture is at your\n finger tips',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: CustomTextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.contains('@') ||
                          !value.contains('.') ||
                          !value.contains('gmail')) {
                        return 'your email not correct';
                      }
                      return null;
                    },
                    hintText: 'Email address',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    height: 56,
                    topRightRadius: 30,
                    bottomRightRadius: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomTextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length != 11) {
                        return 'your phone not correct!';
                      }
                      return null;
                    },
                    hintText: 'Phone',
                    enabledOutBorder: true,
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.phone),
                    height: 56,
                    topRightRadius: 0,
                    bottomRightRadius: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomPasswordObscure(
                    passwordController: passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                foreground: Paint()..shader = linearGradient,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  foreground: Paint()..shader = linearGradient,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        onPressed: () async {
                          final phone = phoneController.text;
                          final email = emailController.text;
                          final password = passwordController.text;
                          if (_formKey.currentState!.validate()) {
                            context.read<UserDataCubit>().emailData(
                                  context: context,
                                  email: email,
                                  phone: phone,
                                  password: password,
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CreateUserBody();
                                },
                              ),
                            );
                          }
                        },
                        text: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        color: Color(0xff39D2C0),
                        borderColor: Color(0xffC1F802),
                        width: 130,
                        height: 50,
                        radius: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    'Use a Social Platform to Create Account',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xB2FFFFFF),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<UserDataCubit>()
                                .googleData(context: context);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images/create_account/Google.png',
                              width: widthScreen * 0.11,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images/create_account/phone.png',
                              width: widthScreen * 0.10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
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
                    width: 230,
                    height: 50,
                    radius: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPasswordObscure extends StatefulWidget {
  CustomPasswordObscure({Key? key, required this.passwordController})
      : super(key: key);

  TextEditingController passwordController;

  @override
  State<CustomPasswordObscure> createState() => _CustomPasswordObscureState();
}

class _CustomPasswordObscureState extends State<CustomPasswordObscure> {
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (value.length < 6) {
              return 'password should be more than 6 letters';
            }
            return null;
          },
          controller: widget.passwordController,
          obscureText: isPasswordObscure,
          hintText: 'Password',
          enabledOutBorder: true,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.password),
          suffixIcon: IconButton(
            onPressed: () {
              setState(
                () {
                  isPasswordObscure = !isPasswordObscure;
                },
              );
            },
            icon: (isPasswordObscure)
                ? Icon(Icons.visibility_off_outlined)
                : Icon(Icons.visibility_outlined),
          ),
          height: 56,
          topRightRadius: 0,
          bottomRightRadius: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (widget.passwordController.text !=
                  confirmPasswordController.text) {
                return 'Your password not matching';
              }

              return null;
            },
            controller: confirmPasswordController,
            obscureText: isConfirmPasswordObscure,
            hintText: 'Confirm Password',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
              onPressed: () {
                setState(
                  () {
                    isConfirmPasswordObscure = !isConfirmPasswordObscure;
                  },
                );
              },
              icon: (isConfirmPasswordObscure)
                  ? Icon(Icons.visibility_off_outlined)
                  : Icon(Icons.visibility_outlined),
            ),
            height: 56,
            topRightRadius: 0,
            bottomRightRadius: 30,
          ),
        ),
      ],
    );
  }
}

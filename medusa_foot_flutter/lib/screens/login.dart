import 'dart:ui';

import 'package:medusa_foot_flutter/components/blur_container.dart';
import 'package:medusa_foot_flutter/components/buttons.dart';
import 'package:medusa_foot_flutter/components/textfields.dart';
import 'package:medusa_foot_flutter/constants/images.dart';
import 'package:medusa_foot_flutter/screens/home/main_home.dart';
import 'package:medusa_foot_flutter/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;

  @override
  void initState() {
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 6,
    );
    super.initState();
    _blurAnimationController.forward();
    _blurAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _blurAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              Images.loginBg,
            ),
            fit: BoxFit.cover,
          )),
        ),
        BlurContainer(value: _blurAnimationController.value),
        SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                double.infinity.widthBox,
                const Spacer(),
                const Spacer(),
                _buildTitleText(context),
                const Spacer(),
                const PrimaryTextField(
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                ),
                24.heightBox,
                const PrimaryTextField(
                  hintText: 'Password',
                  isObscure: true,
                  prefixIcon: CupertinoIcons.padlock,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(),
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    24.widthBox,
                  ],
                ),
                const Spacer(),
                AuthButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.of(context).pushNamed(UserDashboard.id);
                    }),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground)),
                    TextSpan(
                        text: 'Create',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(SignUpScreen.id);
                          }),
                  ]),
                ),
              ],
            ).p(24),
          ),
        ),
      ]),
    );
  }

  Column _buildTitleText(BuildContext context) {
    return Column(
      children: [
         Image.network(
          'https://user-images.githubusercontent.com/7554214/153162406-bf8fd16f-aa98-4604-b87b-e13ab4baf604.png',
          width: 90,
          height: 90,
        ),
        Text(
          'Hello',
          softWrap: true,
          
          style: TextStyle(
              fontSize: 85,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
       
        Text(
          'Sign in to your account',
          softWrap: true,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}

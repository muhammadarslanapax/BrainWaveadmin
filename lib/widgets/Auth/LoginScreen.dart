import 'dart:js';

import 'package:fintech_dashboard_clone/Controller/LoginController.dart';
import 'package:fintech_dashboard_clone/responsive.dart';
import 'package:fintech_dashboard_clone/widgets/Setting/SettingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lottieInit();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControlelr = TextEditingController();

  late LottieBuilder _splashLottie;
  // late AnimationController _lottieController;

  void _lottieInit() {
    _splashLottie = Lottie.asset(
      'assets/splashlogo.json',
      repeat: true,
      animate: true,
      width: double.infinity,
      height: double.infinity,

      // controller: _lottieController,
      onLoaded: (composition) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          SizedBox(
              // color: Colors.red,
              width: Responsive.isMobile(context)
                  ? context.width
                  : context.width * 0.4,
              height: Responsive.isMobile(context)
                  ? context.height * 0.45
                  : context.height,
              child: _splashLottie),
          SizedBox(
            // color: Colors.green,
            width: Responsive.isMobile(context)
                ? context.width
                : context.width * 0.5,
            height: Responsive.isMobile(context)
                ? context.height * 0.55
                : context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextField(
                    context: context,
                    controller: emailController,
                    hintText: 'Enter email'),
                customTextField(
                    context: context,
                    controller: passwordControlelr,
                    hintText: 'Enter password'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 75, right: 75),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              Responsive.isMobile(context)
                                  ? context.width
                                  : context.width * 0.5,
                              50)),
                      onPressed: () {
                        Provider.of<LoginController>(context, listen: false)
                            .login(
                                email: emailController.text.trim(),
                                password: passwordControlelr.text);
                      },
                      child: const Text('Login')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

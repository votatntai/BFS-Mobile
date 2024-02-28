import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/login/login_cubit.dart';
import 'package:flutter_application_1/cubit/login/login_state.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_application_1/utils/messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants.dart';
import '../widgets/Background.dart';
import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
          }
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
          } else if (state is LoginFailedState) {
            showModalBottomSheet(context: context, builder: (context) => AlertDialog(
              title: const Text(msg_login_failed_title),
                content: Text('$msg_login_failed_content\n${state.error.toString().replaceFirst('Exception: ', '')}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<LoginCubit>(context);
          return Scaffold(
            body: Stack(
              children: [
                CustomPaint(
                  painter: DotPainter(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(
                    color: Colors.black.withOpacity(
                        0), // Container phải có màu nhưng có thể trong suốt
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Gap.kSection.height,
                      Gap.kSection.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Gap.k16.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Gap.kSection.height,
                      Gap.kSection.height,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstant.textButtonSize),
                            ),
                            Gap.k8.width,
                            const Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                          ],
                        )),
                      ).onTap((){ 
                        cubit.login(email: emailController.text, password: passwordController.text);
                      }),
                    ],
                  ).paddingSymmetric(horizontal: 32),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}


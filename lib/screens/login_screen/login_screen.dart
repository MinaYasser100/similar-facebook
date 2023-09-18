import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/social_layout.dart';
import 'package:reve_fire/local/chach_helper/cache_helper.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/screens/login_screen/cubit/cubit.dart';
import 'package:reve_fire/screens/login_screen/cubit/states.dart';

import '../../component.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastsStates.error);
          }
          if (state is SocialLoginSuccessState) {
            cacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              Future.delayed(const Duration(seconds: 30));
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).currentIndex = 0;
              navigatorAndFinish(context, const socialLayoutScreen());
            });
          }
        },
        builder: (context, state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Back',
              ),
              titleSpacing: 0,
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: heightScreen! * 0.89,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 150,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Hello, enter your information here',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 500,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Positioned(
                                top: 130,
                                bottom: -500,
                                left: -165,
                                child: ClipOval(
                                  child: Container(
                                    height: double.maxFinite,
                                    width: 700,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      defaultTextFormField(
                                          controller: emailController,
                                          keyboard_type:
                                              TextInputType.emailAddress,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'The email must to be empty';
                                            }
                                          },
                                          label: 'Email',
                                          prefix: Icons.email_outlined),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      defaultTextFormField(
                                          controller: passwordController,
                                          keyboard_type:
                                              TextInputType.visiblePassword,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'The password must to be empty';
                                            }
                                          },
                                          label: 'Password',
                                          prefix: Icons.lock_outlined,
                                          suffix: cubit.suffixIcon,
                                          isPassword: cubit.isPassword,
                                          pressed: () {
                                            cubit.changePassword();
                                            return null;
                                          }),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ConditionalBuilder(
                                        condition:
                                            state is! SocialLoginLoadingState,
                                        builder: (context) {
                                          return defaultButton(
                                              onpressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.userLogin(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text);

                                                  emailController.clear();
                                                  passwordController.clear();
                                                }
                                                return null;
                                              },
                                              text: 'LOGIN',
                                              width: 150);
                                        },
                                        fallback: (context) => const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.white,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

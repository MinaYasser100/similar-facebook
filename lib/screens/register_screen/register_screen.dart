import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/social_layout.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/screens/register_screen/cubit/cubit.dart';
import 'package:reve_fire/screens/register_screen/cubit/states.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/local/chach_helper/cache_helper.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterCreateUserSuccessState) {
            cacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              Future.delayed(const Duration(seconds: 30));
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).currentIndex = 0;
              navigatorAndFinish(context, const socialLayoutScreen());
            });
            // socialCubit.get(context).getUserData();
            // socialCubit.get(context).currentIndex = 0;
            // NavigatorAndFinish(context, socialLayoutScreen());
          }
        },
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Back'),
              titleSpacing: 0,
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: heightScreen!,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 80,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Register',
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
                        // Beinning of implementation the curve and text form fields
                        SizedBox(
                          width: double.infinity,
                          height: heightScreen! * 0.795,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              // code of the curve
                              Positioned(
                                top: 70,
                                bottom: -500,
                                left: -165,
                                child: ClipOval(
                                  child: Container(
                                    height: double.maxFinite,
                                    width: 730,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              // container to the four text form field
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 150,
                                ),
                                child: SizedBox(
                                  height: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        defaultTextFormField(
                                            controller: nameController,
                                            keyboard_type: TextInputType.name,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return 'The name must to be empty';
                                              }
                                            },
                                            label: 'name',
                                            prefix: Icons.person_outlined),
                                        const SizedBox(
                                          height: 15,
                                        ),
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
                                          height: 15,
                                        ),
                                        defaultTextFormField(
                                            controller: phoneController,
                                            keyboard_type: TextInputType.phone,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return 'The phone must to be empty';
                                              }
                                            },
                                            label: 'Phone',
                                            prefix: Icons.phone),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ConditionalBuilder(
                                          condition: state
                                              is! SocialRegisterLoadingState,
                                          builder: (context) {
                                            return defaultButton(
                                                onpressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cubit.userRegister(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        phone: phoneController
                                                            .text);
                                                  }
                                                  nameController.clear();
                                                  emailController.clear();
                                                  passwordController.clear();
                                                  phoneController.clear();
                                                  return null;
                                                },
                                                text: 'register',
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

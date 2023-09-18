import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/screens/login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitailState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePassword() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialLoginChangePasswordVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}

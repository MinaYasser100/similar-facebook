import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitailState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePassword() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  // the method to the create information user on the fire base (firestore)
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://img.freepik.com/premium-vector/person-avatar-icon-design-vector-multiple-use-vector-illustration_625349-290.jpg?w=740',
      coverImage:
          'https://img.freepik.com/free-vector/technology-wire-mesh-network-connection-digital-background_1017-28407.jpg?w=1060&t=st=1675111290~exp=1675111890~hmac=641782fbb4a5a55bac90c8182ebc887ef518403dfa9efd4c9518f6461601a29f',
      bio: 'I use this application',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialRegisterCreateUserSuccessState(userModel.uId));
    }).catchError((error) {
      emit(SocialRegisterCreateUserErrorState(error.toString()));
    });
  }
}

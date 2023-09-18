abstract class SocialRegisterStates {}

class SocialRegisterInitailState extends SocialRegisterStates {}

class SocialRegisterChangePasswordVisibility extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

// to create user

class SocialRegisterCreateUserSuccessState extends SocialRegisterStates {
  final String? uId;

  SocialRegisterCreateUserSuccessState(this.uId);
}

class SocialRegisterCreateUserErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterCreateUserErrorState(this.error);
}

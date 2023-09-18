abstract class SocialLoginStates {}

class SocialLoginInitailState extends SocialLoginStates {}

class SocialLoginChangePasswordVisibility extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String? uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// states to get user infromation
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// state to change button navigation bar
class SocialChangeButtonNavBarState extends SocialStates {}

// state to move into add post Screen
class SocialAddNewPoatState extends SocialStates {}

// states to pick profile image
class SocialPickProfileImageSuccessState extends SocialStates {}

class SocialPickProfileImageErrorState extends SocialStates {}

// states to pick cover image
class SocialPickCoverImageSuccessState extends SocialStates {}

class SocialPickCoverImageErrorState extends SocialStates {}

// states to upload the profile image
class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}

// states to upload the cover image
class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {
  final String error;

  SocialUploadCoverImageErrorState(this.error);
}

// states to update user information
class SocialUpdateLoadingState extends SocialStates {}

class SocialUpdateErrorState extends SocialStates {
  final String error;

  SocialUpdateErrorState(this.error);
}

// states to create new post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {
  final String error;

  SocialCreatePostErrorState(this.error);
}

// states to get post image
class SocialGetPostImageSuccessState extends SocialStates {}

class SocialGetPostImageErrorState extends SocialStates {}

class SocialRemovePostImageSuccessState extends SocialStates {}

// states to get posts
class SocialGetsPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialLikeSuccessState extends SocialStates {}

// states to do likes of the posts
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

// state to show the image in the application
class SocialshowImageState extends SocialStates {}

// state to the get all users from firebase
class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

// states to send message inside the chat
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;

  SocialSendMessageErrorState(this.error);
}

// states to get message inside the chat
class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {
  final String error;

  SocialGetMessageErrorState(this.error);
}

class SocialupdateProfileImagePostLoadingState extends SocialStates {}

class SocialupdateProfileImagePostState extends SocialStates {}

class ErrorState extends SocialStates {
  final String error;

  ErrorState(this.error);
}

class SocialGetChatImageSuccessState extends SocialStates {}

class SocialGetChatImageErrorState extends SocialStates {}

class SocialCreateChatImageLoadingState extends SocialStates {}

class SocialCreateChatImageErrorState extends SocialStates {
  final String error;

  SocialCreateChatImageErrorState(this.error);
}

class SocialRemoveChatImageSuccessState extends SocialStates {}

// state to do logout
class SocialLogoutUserStates extends SocialStates {}

//
class SocialStorageMyImagesSuccessState extends SocialStates {}

class SocialStorageMyImagesErrorState extends SocialStates {
  final String error;

  SocialStorageMyImagesErrorState(this.error);
}

//
class SocialgetMyImagesSuccessState extends SocialStates {}

class SocialgetMyImagesErrorState extends SocialStates {
  final String error;

  SocialgetMyImagesErrorState(this.error);
}

//
class SocialChangeShowImagesSuccessState extends SocialStates {}

// states to get user id that you need to see your profile
class SocialgetUserIdLoadingState extends SocialStates {}

class SocialgetUserIdSuccessState extends SocialStates {}

class SocialgetUserIdErrorState extends SocialStates {
  final String error;

  SocialgetUserIdErrorState(this.error);
}

//the state to the show number of the posts for the on tap user
class SocialChangeShowNumberPostsSuccessState extends SocialStates {}

//the state to the show number of the image for the on tap user
class SocialChangeShowNumberImagesSuccessState extends SocialStates {}

//the states to get the user Images from firebase firestore
class SocialgetUserImagesSuccessState extends SocialStates {}

class SocialgetUserImagesErrorState extends SocialStates {
  final String error;

  SocialgetUserImagesErrorState(this.error);
}

//the states to get my posts from firebase firestore
class SocialgetPostsModelSuccessState extends SocialStates {}

class SocialgetPostsModelErrorState extends SocialStates {
  final String error;

  SocialgetPostsModelErrorState(this.error);
}

//the states to get user posts from firebase firestore
class SocialgetPostsUserModelSuccessState extends SocialStates {}

class SocialgetPostsUserModelErrorState extends SocialStates {
  final String error;

  SocialgetPostsUserModelErrorState(this.error);
}

class SocialChangeShowOnTapUserImagesSuccessState extends SocialStates {}

//the state to the show number of my posts
class SocialChangeShowNumberMyPostsSuccessState extends SocialStates {}

//the state to the show number of my image
class SocialChangeShowNumberMyImagesSuccessState extends SocialStates {}

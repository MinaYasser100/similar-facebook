import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/models/chat_model.dart';
import 'package:reve_fire/models/post_model.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/chat/chat_screen.dart';
import 'package:reve_fire/screens/choose_screen/choose_screen.dart';
import 'package:reve_fire/screens/feeds/feeds_screen.dart';
import 'package:reve_fire/screens/post/post_screen.dart';
import 'package:reve_fire/screens/settings/setting_screen.dart';
import 'package:reve_fire/screens/user/user_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:reve_fire/local/chach_helper/cache_helper.dart';

// this is cubit to the all screen with out login & register.
class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  // this method to get the infromation of the user that do login.
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      // userModel is the variable that hold the all infromatio of the user
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  //Type to the current index to Nav Bar.
  int currentIndex = 0;
  // list to the screens to the Nav Bar.
  List<Widget> screen = [
    const FeedsScreen(),
    const ChatScreen(),
    const PostScreen(),
    const UserScreen(),
    const SettingsScreen(),
  ];
  // list of String type to the title of the the screens
  List<String> titles = [
    'Home',
    'Chat',
    'Add Post',
    'User',
    'Settings',
  ];
  // function to the change the current index to the move in the screens.
  void cahngeButtomBar(int index) {
    if (index == 0) {
      getUserData();
      posts = [];
      getPosts();
      getMyPosts();
    }
    if (index == 3) {
      allMyImage = [];
      getMyImages();
      postsModel = [];
      getMyPosts();
    }
    if (index == 4) {
      getMyImages();
    }
    if (index == 1) {
      getAllUsers(uId: uId as String);
    }
    if (index == 2) {
      emit(SocialAddNewPoatState());
    } else {
      currentIndex = index;
      emit(SocialChangeButtonNavBarState());
    }
  }

  // variable to profile image
  File? profileImage;
  var picker = ImagePicker();
  //method to get profile image from gallery
  Future<void> getProfileImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickProfileImageSuccessState());
    } else {
      emit(SocialPickProfileImageErrorState());
    }
  }

  // variable to cover image
  File? coverImage;
  //method to get cover image from gallery
  Future<void> getCoverImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickCoverImageSuccessState());
    } else {
      emit(SocialPickCoverImageErrorState());
    }
  }

  // variable to save profile image url
  //String? profileImageUrl = '';
  // method to upload profile image on the fire base storage
  //String? newprofileImage = '';
  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //newprofileImage = value;
        sendMyImage(image: value);
        //you do update there to change and update your infromation and your profile image
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState(error.toString()));
    });
  }

  // variable to save cover image url
  //String? coverImageUrl = '';
  // method to upload cover image on the fire base storage
  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMyImage(image: value);
        //you do update there to change and update your infromation and your cover image
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState(error.toString()));
    });
  }

  // The method is used in do update user date and uplaod prodile image & cover image
  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      coverImage: cover ?? userModel!.coverImage,
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateErrorState(error));
    });
  }

  // variable to post image
  File? postImage;
  //method to get post image from gallery
  Future<void> getPostImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetPostImageSuccessState());
    } else {
      emit(SocialGetPostImageErrorState());
    }
  }

  // method is used to upload post with image
  void uploadImagePost({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMyImage(image: value);
        createNewPost(
          text: text,
          dateTime: dateTime,
          postmage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  // method is used to upload post
  void createNewPost({
    required String text,
    required String dateTime,
    String? postmage,
  }) {
    emit(SocialUpdateLoadingState());
    SocialPostModel model = SocialPostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postmage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error));
    });
  }

  // small method to remove image after image call from gallery
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  // list from socialPostModel type to put it the all posts from firebase
  List<SocialPostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  bool delay = false;
  // method to get the post model from firebase
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          posts.add(SocialPostModel.fromJson(element.data()));
          postsId.add(element.id);
          if (SocialPostModel.fromJson(element.data()).uId == userModel!.uId) {
            updateProfileImagePost(
                model: SocialPostModel.fromJson(element.data()),
                elementId: element.id);
          }
          likes.add(value.docs.length);
          element.reference.collection('likes').get().then((value) {
            emit(SocialLikeSuccessState());
          }).catchError((error) {});
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  // I create this method to do upload the profile image on the odd posts
  //
  void updateProfileImagePost({
    required SocialPostModel model,
    required String elementId,
  }) {
    if (model.image != userModel!.image) {
      model = SocialPostModel(
        name: model.name,
        dateTime: model.dateTime,
        image: userModel!.image ?? model.image,
        postImage: model.postImage,
        text: model.text,
        uId: model.uId,
      );
      emit(SocialupdateProfileImagePostLoadingState());
      FirebaseFirestore.instance
          .collection('posts')
          .doc(elementId)
          .update(model.toMap())
          .then((value) {
        emit(SocialupdateProfileImagePostState());
      }).catchError((error) {
        emit(ErrorState(error.toString()));
      });
    }
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  String? imageOnTap;
  // the small method to store the image is pressurized for it
  void onTap(String image) {
    imageOnTap = image;
    emit(SocialshowImageState());
  }

  List<SocialUserModel> users = [];
  // method to the get the all users inside the chat screen without my account
  void getAllUsers({
    required String uId,
  }) {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  // method to the send the all message
  void sendMessage({
    required String reciverId,
    required String dateTime,
    required String text,
    String? chatImage,
  }) {
    SocialChatModel chatModel = SocialChatModel(
      senderId: userModel!.uId,
      reciverId: reciverId,
      dateTime: dateTime,
      text: text,
      chatImage: chatImage ?? '',
    );
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    // set reciver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<SocialChatModel> listMessages = [];

  void getAllMessages({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      listMessages = [];
      event.docs.forEach((element) {
        listMessages.add(SocialChatModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  File? chatImage;
  //method to get chat image from gallery
  Future<void> getChatImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialGetChatImageSuccessState());
    } else {
      emit(SocialGetChatImageErrorState());
    }
  }

  //method to upload the image in the chat with the message
  void uploadImageChat({
    required String reciverId,
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreateChatImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            reciverId: reciverId,
            dateTime: dateTime,
            text: text,
            chatImage: value);
      }).catchError((error) {
        emit(SocialCreateChatImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreateChatImageErrorState(error.toString()));
    });
  }

  // small method to remove image after image call from gallery
  void removeChatImage() {
    chatImage = null;
    emit(SocialRemoveChatImageSuccessState());
  }

  //small method to do logout by my accont
  // ignore: non_constant_identifier_names
  void SignOut(BuildContext context) {
    cacheHelper.removeData(key: uId as String).then((value) {
      navigatorAndFinish(context, const ChooseScreen());
      emit(SocialLogoutUserStates());
    });
  }

  // this method to do send the all images that it send by you to the firebase
  void sendMyImage({
    required String image,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('images')
        .add({'image': image}).then((value) {
      emit(SocialStorageMyImagesSuccessState());
    }).catchError((error) {
      emit(SocialStorageMyImagesErrorState(error.toString()));
    });
  }

  // the variable to storage the all images
  List<String>? allMyImage = [];
  //this method to the get all my images from the firebase firestore
  void getMyImages() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('images')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allMyImage!.add(element.data()['image']);
      });
      emit(SocialgetMyImagesSuccessState());
    }).catchError((error) {
      emit(SocialgetMyImagesErrorState(error.toString()));
    });
  }

  // variable to show the image in the user screen
  bool showImages = false;
  //small method to do change for variable of showImages
  void changeShowImage() {
    showImages = !showImages;
    emit(SocialChangeShowImagesSuccessState());
  }

  //the variable to used to get the user id from FirebaseFirestore
  SocialUserModel? model;
  //the variable to storage the user that you need to see your profile
  SocialUserModel? onTapUsermodel;
  //this method to the search the user id and storage your iformation in the onTapUsermodel
  void getUserId({
    required String text,
  }) {
    emit(SocialgetUserIdLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        model = SocialUserModel.fromJson(element.data());
        if (model!.name == text) {
          onTapUsermodel = model;
          allUserImage = [];
          getUserImages();
          getUserPosts();
        }
      });
      emit(SocialgetUserIdSuccessState());
    }).catchError((error) {
      emit(SocialgetUserIdErrorState(error.toString()));
    });
  }

  // variable and method to show the numbers of posts
  bool showNumberposts = false;
  void changeShowNumberPosts() {
    showNumberposts = !showNumberposts;
    emit(SocialChangeShowNumberPostsSuccessState());
  }

  // variable and method to show the numbers of images
  bool showNumberImages = false;
  void changeShowNumberImages() {
    showNumberImages = !showNumberImages;
    emit(SocialChangeShowNumberImagesSuccessState());
  }

  // the variable to storage the all images
  List<String>? allUserImage = [];
  //this method to the get all my images from the firebase firestore
  void getUserImages() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(onTapUsermodel!.uId)
        .collection('images')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allUserImage!.add(element.data()['image']);
      });
      emit(SocialgetUserImagesSuccessState());
    }).catchError((error) {
      emit(SocialgetUserImagesErrorState(error.toString()));
    });
  }

  // variable to storage the my posts from firebase firestore
  List<SocialPostModel> postsModel = [];
  // method to get all my posts from firebase firestore
  void getMyPosts() {
    postsModel = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        if (SocialPostModel.fromJson(element.data()).uId == userModel!.uId) {
          postsModel.add(SocialPostModel.fromJson(element.data()));
        }
      });
      emit(SocialgetPostsModelSuccessState());
    }).catchError((error) {
      emit(SocialgetPostsModelErrorState(error.toString()));
    });
  }

  // variable to storage the user posts from firebase firestore
  List<SocialPostModel> postsUserModel = [];
  // method to get all user posts from firebase firestore
  void getUserPosts() {
    postsUserModel = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        if (SocialPostModel.fromJson(element.data()).uId ==
            onTapUsermodel!.uId) {
          postsUserModel.add(SocialPostModel.fromJson(element.data()));
        }
      });
      emit(SocialgetPostsUserModelSuccessState());
    }).catchError((error) {
      emit(SocialgetPostsUserModelErrorState(error.toString()));
    });
  }

// variable to show the image in the user screen
  bool showOnTapUserImages = false;
  //small method to do change for variable of showImages
  void changeOnTapUserShowImage() {
    showOnTapUserImages = !showOnTapUserImages;
    emit(SocialChangeShowOnTapUserImagesSuccessState());
  }

  // variable and method to show the numbers of posts
  bool showNumberMyposts = false;
  void changeShowNumberMyPosts() {
    showNumberMyposts = !showNumberMyposts;
    emit(SocialChangeShowNumberMyPostsSuccessState());
  }

  // variable and method to show the numbers of images
  bool showNumberMyImages = false;
  void changeShowNumberMyImages() {
    showNumberMyImages = !showNumberMyImages;
    emit(SocialChangeShowNumberMyImagesSuccessState());
  }
}

//userModel!.uId of getAllUsers
//gs://fire-learn-dff30.appspot.com/users

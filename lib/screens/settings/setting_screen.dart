import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/edit_profile/edit_profile.dart';
import 'package:reve_fire/screens/image/image_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialUserModel? model = SocialCubit.get(context).userModel!;
        return Padding(
          padding: const EdgeInsets.only(
            top: 3.0,
            bottom: 10,
            right: 10,
            left: 10,
          ),
          child: Column(
            children: [
              // the cover image & profile image
              SizedBox(
                height: 210,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: InkWell(
                        onTap: () {
                          SocialCubit.get(context).onTap('${model.coverImage}');
                          navigatorTo(context, const ImageScreen());
                        },
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            // cover image for the use
                            image: DecorationImage(
                              image: NetworkImage(
                                '${model.coverImage}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).onTap('${model.image}');
                        navigatorTo(context, const ImageScreen());
                      },
                      child: CircleAvatar(
                        radius: 62,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60,
                          // profile image for the user
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // the name of the user
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // the bio in the user profile
              Text(
                '${model.bio}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              // number of posts & photos & follower & following
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    // post
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '${SocialCubit.get(context).postsModel.length}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Post',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // photos
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '251',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'photos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // followers
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '5.2k',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'followers',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // following
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '1K',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'following',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // two button , one to add photos and other edit
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Add Photos'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigatorTo(context, const EditProfileScreen());
                      },
                      child: const Icon(FluentIcons.edit_24_regular))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance
                            .subscribeToTopic('announcement');
                      },
                      child: const Text('Subscribe'),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('announcement');
                      },
                      child: const Text('Unsubscribe'),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              defaultButton(
                width: double.infinity,
                textColor: Colors.white,
                color: primaryColor,
                onpressed: () {
                  SocialCubit.get(context).SignOut(context);
                  return null;
                },
                text: 'Logout',
              ),
            ],
          ),
        );
      },
    );
  }
}

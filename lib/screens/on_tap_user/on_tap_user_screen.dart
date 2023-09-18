import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/image/image_screen.dart';

class OnTapUserScreen extends StatelessWidget {
  const OnTapUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Back'),
        titleSpacing: 0.0,
      ),
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).onTapUsermodel != null,
            builder: (context) {
              SocialUserModel? userModel =
                  SocialCubit.get(context).onTapUsermodel!;
              var cubit = SocialCubit.get(context);
              return Padding(
                padding: const EdgeInsets.only(
                  top: 3.0,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // cover image and profile image
                      SizedBox(
                        height: 210,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            // cover image
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: InkWell(
                                onTap: () {
                                  SocialCubit.get(context)
                                      .onTap('${userModel.coverImage}');
                                  navigatorTo(context, const ImageScreen());
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${userModel.coverImage}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // profile image
                            InkWell(
                              onTap: () {
                                SocialCubit.get(context)
                                    .onTap('${userModel.image}');
                                navigatorTo(context, const ImageScreen());
                              },
                              child: CircleAvatar(
                                radius: 62,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage('${userModel.image}'),
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
                        '${userModel.name}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // the bio in the user profile
                      Text(
                        '${userModel.bio}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // row hold the two button to show number of the posts and images
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // button to show the number of posts
                                defaultButton(
                                  onpressed: () {
                                    cubit.changeShowNumberPosts();
                                    return null;
                                  },
                                  text: 'Posts',
                                  color: primaryColor,
                                  height: 40,
                                  isUperCase: false,
                                  textColor: Colors.white,
                                  width: cubit.showNumberposts == true
                                      ? widthScreen! * 0.34
                                      : widthScreen! * 0.45,
                                ),
                                if (cubit.showNumberposts == true)
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                if (cubit.showNumberposts == true)
                                  CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: Text(
                                      '${cubit.postsUserModel.length}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // button to show the number of image
                                defaultButton(
                                  onpressed: () {
                                    cubit.changeShowNumberImages();
                                    return null;
                                  },
                                  text: 'Images',
                                  color: primaryColor,
                                  height: 40,
                                  isUperCase: false,
                                  textColor: Colors.white,
                                  width: cubit.showNumberImages == true
                                      ? widthScreen! * 0.34
                                      : widthScreen! * 0.45,
                                ),
                                if (cubit.showNumberImages == true)
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                if (cubit.showNumberImages == true)
                                  CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: Text(
                                      '${cubit.allUserImage!.length}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: divider(),
                      ),
                      // hold text to photos
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 20,
                            child: const Icon(
                              FluentIcons.image_24_regular,
                              color: Colors.black,
                            ),
                          ),
                          defaultButton(
                            onpressed: () {
                              cubit.changeOnTapUserShowImage();
                              return null;
                            },
                            text: 'Photos',
                            color: Colors.grey[300] as Color,
                            height: 40.0,
                            isUperCase: false,
                            textColor: Colors.black,
                          )
                        ],
                      ),
                      if (cubit.showOnTapUserImages == true)
                        const SizedBox(
                          height: 10,
                        ),
                      // grad to see the image im the profile
                      if (cubit.showOnTapUserImages == true)
                        Container(
                          color: Colors.grey[300],
                          height: 300,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ConditionalBuilder(
                              condition: cubit.allUserImage!.isNotEmpty,
                              builder: (context) {
                                return GridView.count(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  physics: const BouncingScrollPhysics(),
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  children: List.generate(
                                    cubit.allUserImage!.length,
                                    (index) => gradUserImage(
                                        cubit.allUserImage![index], context,
                                        () {
                                      SocialCubit.get(context)
                                          .onTap(cubit.allUserImage![index]);
                                      navigatorTo(context, const ImageScreen());
                                      return null;
                                    }),
                                  ),
                                );
                              },
                              fallback: (context) => const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'No images for you in the application',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: divider(),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => postItem(
                              context, cubit.postsUserModel[index], index, 0),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: cubit.postsUserModel.length),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

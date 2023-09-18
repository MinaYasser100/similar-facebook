import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/layout/social_layout.dart';
import 'package:reve_fire/models/social_user_model.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SocialUserModel userModel = SocialCubit.get(context).userModel!;
            int numberName = userModel.name!.length;
            String? firstName;
            List<String> names = userModel.name!.split(' ');
            for (var i = 0; i < numberName; i++) {
              firstName = names[0];
            }
            var cubit = SocialCubit.get(context);
            TextEditingController textController = TextEditingController();
            var now = DateTime.now();
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      navigatorAndFinish(context, const socialLayoutScreen());
                      SocialCubit.get(context).currentIndex = 0;
                      SocialCubit.get(context).posts = [];
                      SocialCubit.get(context).getPosts();
                      SocialCubit.get(context).getMyPosts();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                title: const Text('Create Post'),
                titleSpacing: 0.0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                    ),
                    child: defaultTextButton(
                      function: () {
                        if (cubit.postImage == null) {
                          cubit.createNewPost(
                            text: textController.text,
                            dateTime: now.toString(),
                          );
                        } else {
                          cubit.uploadImagePost(
                            text: textController.text,
                            dateTime: now.toString(),
                          );
                          cubit.postImage = null;
                        }
                        return null;
                      },
                      text: 'Post',
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 3.0,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialCreatePostLoadingState)
                      const SizedBox(
                        height: 4.0,
                      ),

                    Row(
                      children: [
                        // profile image
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage('${userModel.image}'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // texts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // the name text
                            Text(
                              '${userModel.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.public,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text('Pubic',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'What is on your mind, $firstName',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    if (cubit.postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              // cover image for the use
                              image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // icon button to change cover image profile
                          IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.close_outlined,
                                  size: 20,
                                ),
                              )),
                        ],
                      ),
                    // row hold the two button , one to add photos and other to do tag
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              cubit.getPostImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.image_24_regular,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('add photos')
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {}, child: const Text('# tags')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

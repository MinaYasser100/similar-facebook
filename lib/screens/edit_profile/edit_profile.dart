import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/models/social_user_model.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUploadProfileImageSuccessState) {
          SocialCubit.get(context).posts = [];
          SocialCubit.get(context).getPosts();
        }
      },
      builder: (context, state) {
        SocialUserModel model = SocialCubit.get(context).userModel!;
        TextEditingController nameController = TextEditingController();
        TextEditingController bioController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        nameController.text = model.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        GlobalKey formKey = GlobalKey<FormState>();
        var profileImage = SocialCubit.get(context).profileImage;
        var cubit = SocialCubit.get(context);
        var coverImage = SocialCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () {
                  Navigator.pop(context);
                  SocialCubit.get(context).posts = [];
                  SocialCubit.get(context).getPosts();
                }),
            title: const Text('Edit Profile'),
            actions: [
              defaultTextButton(
                function: () {
                  cubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                  return null;
                },
                text: 'Update',
                textColor: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          //     defalut_appBar(context: context, title: 'Edit Profile', actions: [
          //   defaultTextButton(
          //     function: () {
          //       cubit.updateUser(
          //         name: nameController.text,
          //         bio: bioController.text,
          //         phone: phoneController.text,
          //       );
          //     },
          //     text: 'Update',
          //     textColor: Colors.white,
          //   ),
          //   const SizedBox(
          //     width: 10,
          //   ),
          // ]),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 3.0,
              bottom: 10,
              right: 10,
              left: 10,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is SocialUpdateLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialUpdateLoadingState)
                      const SizedBox(
                        height: 6,
                      ),
                    // two image (profile image & cover image)
                    SizedBox(
                      height: 210,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            // this the stack hold the cover image & icon button is camera
                            child: Stack(
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
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${model.coverImage}',
                                            )
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // icon button to change cover image profile
                                IconButton(
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        FluentIcons.camera_add_20_regular,
                                        size: 20,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          // this the stack hold the image profile & icon button is camera
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              // profile image
                              CircleAvatar(
                                radius: 62,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  // profile image for the user
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${model.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              // icon button to change image profile
                              IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      FluentIcons.camera_add_20_regular,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // two button to upload the profile and cover image
                    if (cubit.profileImage != null || cubit.coverImage != null)
                      Row(
                        children: [
                          // button to upload the profile image
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      width: double.infinity,
                                      onpressed: () {
                                        cubit.uploadProfileImage(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text,
                                        );
                                        cubit.profileImage = null;
                                        return null;
                                      },
                                      text: 'Upload profile',
                                      color: primaryColor,
                                      textColor: Colors.white,
                                      radius: 10),
                                  if (state is SocialUpdateLoadingState)
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  if (state is SocialUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),

                          if (cubit.profileImage != null &&
                              cubit.coverImage != null)
                            const SizedBox(
                              width: 5.0,
                            ),
                          // button to upload the profile image
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    width: double.infinity,
                                    onpressed: () {
                                      cubit.uploadCoverImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );
                                      cubit.coverImage = null;
                                      return null;
                                    },
                                    text: 'Upload cover',
                                    color: primaryColor,
                                    textColor: Colors.white,
                                    radius: 10,
                                  ),
                                  if (state is SocialUpdateLoadingState)
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  if (state is SocialUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (cubit.profileImage != null || cubit.coverImage != null)
                      const SizedBox(
                        height: 20.0,
                      ),
                    // text form field  to the name of the user
                    defaultTextFormField(
                      controller: nameController,
                      keyboard_type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'The name must not be empty';
                        }
                      },
                      label: 'Name',
                      prefix: FluentIcons.person_24_regular,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // text form field  to the bio of the user
                    defaultTextFormField(
                      controller: bioController,
                      keyboard_type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'The bio must not be empty';
                        }
                      },
                      label: 'Bio',
                      prefix: FluentIcons.book_20_regular,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // text form field  to the phone of the user
                    defaultTextFormField(
                      controller: phoneController,
                      keyboard_type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'The phone must not be empty';
                        }
                      },
                      label: 'phone',
                      prefix: FluentIcons.call_24_regular,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:reve_fire/models/chat_model.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/image/image_screen.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  ChatDetailsScreen({
    super.key,
    this.userModel,
  });
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getAllMessages(
          reciverId: userModel!.uId!,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.amber[50],
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${userModel!.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: cubit.listMessages.isNotEmpty,
                        builder: (context) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = cubit.listMessages[index];
                              if (cubit.userModel!.uId == message.senderId) {
                                return sendMyMessage(message, context);
                              } else {
                                return sendMessage(message, context);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5.0,
                            ),
                            itemCount: cubit.listMessages.length,
                          );
                        },
                        // the fallback is the text
                        fallback: (context) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('type the messaeg your frind',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.grey[300],
                              )),
                        ),
                      ),
                    ),
                    if (cubit.chatImage != null)
                      // stack to show the image to send the received from gallery
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(cubit.chatImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.removeChatImage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              backgroundColor: primaryColor,
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.amber[50],
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey[300] as Color,
                          )),
                      // the row contain the textformfield & button to send message
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: ' Type your message here ...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          //MaterialButton hold the button to get image to the chat
                          MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              cubit.getChatImage();
                            },
                            child: Icon(
                              Icons.photo_camera,
                              color: primaryColor,
                              size: 26,
                            ),
                          ),
                          //container hold the button send
                          Container(
                            color: Colors.grey[300],
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: () {
                                if (cubit.chatImage == null) {
                                  SocialCubit.get(context).sendMessage(
                                      reciverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.clear();
                                } else {
                                  cubit.uploadImageChat(
                                    reciverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.clear();
                                  cubit.removeChatImage();
                                }
                              },
                              child: Icon(
                                Icons.send_rounded,
                                color: primaryColor,
                                size: 26,
                              ),
                            ),
                          )
                        ],
                      ),
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

  // the method to show the my message that i send it
  Align sendMyMessage(SocialChatModel message, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Column(
            children: [
              if (message.chatImage != "")
                InkWell(
                  onTap: () {
                    SocialCubit.get(context).onTap(message.chatImage!);
                    navigatorTo(context, const ImageScreen());
                  },
                  child: Image(
                    image: NetworkImage(
                      '${message.chatImage}',
                    ),
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Text(
                '${message.text}',
                style: const TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      );
}

// the method to show the message that came for me
Widget sendMessage(SocialChatModel message, context) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            )),
        child: Column(
          children: [
            if (message.chatImage != "")
              InkWell(
                onTap: () {
                  SocialCubit.get(context).onTap(message.chatImage!);
                  navigatorTo(context, const ImageScreen());
                },
                child: Image(
                  image: NetworkImage(
                    '${message.chatImage}',
                  ),
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            Text(
              '${message.text}',
              style: const TextStyle(
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ),
    );

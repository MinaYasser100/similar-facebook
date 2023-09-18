import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/models/social_user_model.dart';
import 'package:reve_fire/screens/chat/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return userChatItem(
                      SocialCubit.get(context).users[index], context);
                },
                separatorBuilder: (context, index) => divider(),
                itemCount: SocialCubit.get(context).users.length);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget userChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigatorTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}

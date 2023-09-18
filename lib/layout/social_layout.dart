import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:reve_fire/screens/post/post_screen.dart';

// ignore: camel_case_types
class socialLayoutScreen extends StatelessWidget {
  const socialLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddNewPoatState) {
          navigatorTo(context, const PostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search_outlined)),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.cahngeButtomBar(index);
            },
            height: 60.0,
            color: primaryColor,
            // icons that show in the bottomNavigationBar
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const Icon(
                FluentIcons.home_24_regular,
                color: Colors.white,
              ),
              const Icon(
                FluentIcons.chat_24_regular,
                color: Colors.white,
              ),
              const Icon(
                Icons.post_add,
                color: Colors.white,
              ),
              const Icon(
                FluentIcons.person_24_regular,
                color: Colors.white,
              ),
              const Icon(
                FluentIcons.settings_24_regular,
                color: Colors.white,
              ),
            ],
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(
              milliseconds: 600,
            ),
            buttonBackgroundColor: primaryColor,
          ),
        );
      },
    );
  }
}

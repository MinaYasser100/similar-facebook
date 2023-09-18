import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';
import 'package:reve_fire/local/constant.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: grandColorBar,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: grandColorBar,
          ),
          body: Center(
            child: Image(
                image: NetworkImage('${SocialCubit.get(context).imageOnTap}')),
          ),
        );
      },
    );
  }
}

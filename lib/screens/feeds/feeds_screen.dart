import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/cubit/states.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      const Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        child: Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/best-friends-coffee-shop_329181-8510.jpg?w=996&t=st=1675018758~exp=1675019358~hmac=e2cf34ddd2e33cc7973e34e122ce9f67d9cd35e00e4e53436d00f440035d0d29',
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'communicate with your friends',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          postItem(context, cubit.posts[index], index, 10),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.posts.length),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

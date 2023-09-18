import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reve_fire/models/post_model.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/screens/image/image_screen.dart';
import 'package:reve_fire/screens/on_tap_user/on_tap_user_screen.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  // ignore: non_constant_identifier_names
  required TextInputType keyboard_type,
  Function? onSubmit,
  Function? onchange,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? Function()? pressed,
  Function? Function()? ontap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboard_type,
      onFieldSubmitted: onSubmit != null ? (val) => onSubmit(val) : null,
      onChanged: onchange != null ? (val) => onchange(val) : null,
      validator: (value) {
        return validate(value);
      },
      onTap: ontap,
      obscureText: isPassword,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
            ),
            onPressed: pressed,
          )),
    );

Widget defaultTextButton({
  required Function? Function() function,
  required String text,
  Color textColor = Colors.teal,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: textColor,
          ),
        ));
Widget defaultButton({
  required Function? Function() onpressed,
  required String text,
  bool isUperCase = true,
  double width = 100,
  Color color = Colors.white,
  Color textColor = Colors.teal,
  double radius = 20.0,
  double height = 50.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          isUperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

void navigatorTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void showToast({required String text, required ToastsStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastsStates { success, error, waiting }

Color chooseToastColor(ToastsStates state) {
  Color color;
  switch (state) {
    case ToastsStates.success:
      color = Colors.green;
      break;
    case ToastsStates.error:
      color = Colors.red;
      break;
    case ToastsStates.waiting:
      color = Colors.amber;
      break;
  }
  return color;
}

// move to the other screen wthiout back
void navigatorAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Container divider() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey.withOpacity(0.7),
    );

// ignore: non_constant_identifier_names
PreferredSizeWidget defalutAppBar({
  required BuildContext context,
  String? title,
  double? titleSpacing = 0.0,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title!),
    titleSpacing: titleSpacing,
    leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          Navigator.pop(context);
        }),
    actions: actions,
  );
}

// widget to the iamge that is show inside the grad in the user screen and user on tap
Widget gradUserImage(String image, context, Function? Function()? onTap) =>
    InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );

Widget postItem(
    BuildContext context, SocialPostModel postModel, index, double horizontal) {
  return Card(
    elevation: 7.0,
    margin: EdgeInsets.symmetric(
      horizontal: horizontal,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // profile image
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${postModel.image}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // text to the name
                      InkWell(
                        onTap: () {
                          SocialCubit.get(context).getUserId(
                            text: '${postModel.name}',
                          );
                          // socialCubit.get(context).allUserImage = [];
                          // socialCubit.get(context).getUserImages();
                          navigatorTo(context, const OnTapUserScreen());
                        },
                        child: Text(
                          '${postModel.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Colors.blue,
                      )
                    ],
                  ),
                  //text to تاريخ
                  Text(
                    '${postModel.dateTime}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
            ],
          ),
          // the divider unber the know information
          Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              bottom: 10.0,
            ),
            child: divider(),
          ),
          // the text post
          Text(
            '${postModel.text}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          //wrap inside container to the tags
          // Container(
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5),
          //         child: Container(
          //           height: 25.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 0.1,
          //             onPressed: () {},
          //             child: Text(
          //               '#software',
          //               style: TextStyle(
          //                 color: Colors.blue,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 5),
          //         child: Container(
          //           height: 25.0,
          //           child: MaterialButton(
          //             padding: EdgeInsets.zero,
          //             minWidth: 0.1,
          //             onPressed: () {},
          //             child: Text(
          //               '#software_engineering',
          //               style: TextStyle(
          //                 color: Colors.blue,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 5.0,
          ),
          // card to the image in the post
          if (postModel.postImage != '')
            InkWell(
              onTap: () {
                SocialCubit.get(context).onTap(postModel.postImage!);
                navigatorTo(context, const ImageScreen());
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5,
                ),
                child: Image(
                  image: NetworkImage(
                    '${postModel.postImage}',
                  ),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          // Row to do communts & likes
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.heart_24_filled,
                          color: Colors.red.withOpacity(0.8),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        const Text(
                          '1',
                          // '${socialCubit.get(context).likes[index]}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          FluentIcons.chat_24_regular,
                          color: Colors.amber,
                          size: 18,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '567 communts',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Write a communt',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.heart_24_filled,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

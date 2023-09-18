import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/layout/cubit/cubit.dart';
import 'package:reve_fire/layout/social_layout.dart';
import 'package:reve_fire/local/chach_helper/cache_helper.dart';
import 'package:reve_fire/screens/choose_screen/choose_screen.dart';
import 'local/constant.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastsStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  // foreground fcm
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    showToast(text: 'on message', state: ToastsStates.success);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  // click notification and opened the message on the app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    showToast(text: 'on message opened app', state: ToastsStates.success);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = AppBlocObserver();
  await cacheHelper.init();
  uId = cacheHelper.getData(key: 'uId');
  Widget? widget;
  if (uId != null) {
    widget = const socialLayoutScreen();
  } else {
    widget = const ChooseScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({super.key, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: primaryColor as MaterialColor,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(
          builder: (p0, p1) {
            heightScreen = p1.minHeight.toDouble();
            widthScreen = p1.minWidth.toDouble();
            print(heightScreen);
            return startWidget!;
          },
        ),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

import 'package:flutter/material.dart';
import 'package:reve_fire/component.dart';
import 'package:reve_fire/screens/login_screen/login_screen.dart';
import 'package:reve_fire/screens/register_screen/register_screen.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 200,
              ),
              child: Text(
                'Hello',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 400,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Positioned(
                    top: 100,
                    bottom: -500,
                    left: -165,
                    child: ClipOval(
                      child: Container(
                        height: double.maxFinite,
                        width: 700,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 210,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        defaultButton(
                            width: 200,
                            onpressed: () {
                              navigatorTo(context, LoginScreen());
                              return null;
                            },
                            text: 'login'),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            width: 200,
                            onpressed: () {
                              navigatorTo(context, RegisterScreen());
                              return null;
                            },
                            text: 'Register'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
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
}

// Widget _curved() {
//   return CustomPaint(
//     size: Size(600, (320 * 1.1617600000000001).toDouble()),
//     //You can Replace [WIDTH] with your desired width for
//     // Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
//   );
// }

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.071853, size.height * 1.035738);
    path_0.lineTo(size.width * 0.07250032, size.height * 1.035738);
    path_0.lineTo(size.width * 0.07250032, size.height * 0.3868996);
    path_0.cubicTo(
        size.width * 0.07241850,
        size.height * 0.3325917,
        size.width * 0.09748933,
        size.height * 0.2804976,
        size.width * 0.1421620,
        size.height * 0.2421464);
    path_0.cubicTo(
        size.width * 0.1969324,
        size.height * 0.1950013,
        size.width * 0.2692701,
        size.height * 0.1829006,
        size.width * 0.3079311,
        size.height * 0.1816967);
    path_0.cubicTo(
        size.width * 0.5894098,
        size.height * 0.1729377,
        size.width * 0.8344350,
        size.height * 0.1919213,
        size.width * 0.9302565,
        size.height * 0.1649115);
    path_0.cubicTo(
        size.width * 0.9696772,
        size.height * 0.1538054,
        size.width * 1.040485,
        size.height * 0.1192928,
        size.width * 1.071848,
        size.height * 0.03573744);
    path_0.cubicTo(
        size.width * 1.069587,
        size.height * 0.2428419,
        size.width * 1.074102,
        size.height * 0.8286341,
        size.width * 1.071853,
        size.height * 1.035738);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.blue;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

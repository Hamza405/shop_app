import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/widgets/curve_pinter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child:CustomPaint(
                painter:CurvePainter()
              )
            )
          ],
        ),
      ),
    );
  }
}
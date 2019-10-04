import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_1/auth.dart';
import 'package:test_1/fadetransition.dart';
import 'package:test_1/page3.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  _myFunc() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context, FadeRoute(page: Page3(auth: new Auth())));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    Timer(Duration(milliseconds: 1800), () => _myFunc());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
          begin: Alignment(-1.0, 1.0),
          end: Alignment(1.0, -1.0),
          colors: [const Color(0xAA13CD06), const Color(0xAA2296F3)],
        )),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTap: () {},
              child: Transform.scale(
                scale: _scale,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: 700.0,
                  ),
                ),
              ),
            ),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

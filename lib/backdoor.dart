import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Backdoor extends StatefulWidget {
  @override
  _BackdoorState createState() => _BackdoorState();
}

class _BackdoorState extends State<Backdoor> {
  RandomColor _randomColor = RandomColor();
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  var list = [Color(0xAA13CD06), Color(0xAA2296F3)];
  var _tapcount = 0;

  void changeMe() {
    _tapcount++;
    Color _color1 =
        _randomColor.randomColor(colorBrightness: ColorBrightness.light);
    Color _color2 =
        _randomColor.randomColor(colorBrightness: ColorBrightness.dark);
    if (_tapcount % 2 == 1) {
      setState(() {
        top = FractionalOffset.topRight;
        bottom = FractionalOffset.bottomLeft;
        list = [_color1, _color2];
      });
    } else {
      setState(() {
        top = FractionalOffset.topCenter;
        bottom = FractionalOffset.bottomLeft;
        list = [_color1, _color2];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // while(_tapcount >= 0) {
    // Timer(Duration(milliseconds: 100), () => changeMe());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Center(
        child: AnimatedContainer(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          duration: Duration(seconds: 1),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: new LinearGradient(
              begin: top,
              end: bottom,
              colors: list,
            ),
            color: Colors.lightGreen,
          ),
          child: Stack(
            children: <Widget>[
              Center(child: BackButton()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: changeMe,
          icon: Icon(Icons.update),
          label: Text("Transform")),
    );
  }
}

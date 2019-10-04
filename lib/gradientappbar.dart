import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth.dart';

class GradientAppBar extends StatelessWidget {
  GradientAppBar(this.title, this.onSignedOut, this.auth);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String title;
  final double barHeight = 50.0;


  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
      Fluttertoast.showToast(
          msg: "Logged Out Successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(165.0, 0.0, 0.0, 0.0),
            child: Center(
              child: new Text(
                title,
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FlatButton(
            padding: const EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text("LOG OUT",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              )),
          onPressed: _signOut,
        ),
        ],
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.greenAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}

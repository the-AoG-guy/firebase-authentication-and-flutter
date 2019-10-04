import 'package:flutter/material.dart';
import 'package:test_1/gradientappbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_color/random_color.dart';
import 'auth.dart';

int _posts = 12;

class Page2 extends StatefulWidget {
  Page2({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  RandomColor _randomColor = RandomColor();

  _Page2State({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  // void _signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.onSignedOut();
  //     Fluttertoast.showToast(
  //         msg: "Logged Out Successfully.",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.white,
  //         textColor: Colors.black,
  //         fontSize: 15.0);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _increase() {
    setState(() => _posts++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xAA13CD06), const Color(0xAA2296F3)],
            )),
            child: Stack(alignment: Alignment.topLeft, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Image(
                    image: AssetImage('assets/logo1.gif'),
                    height: 200.0,
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                bottom: 250.0,
                child: Container(
                    padding: EdgeInsets.fromLTRB(75.0, 70.0, 0.0, 0.0),
                    child: FloatingActionButton(
                      elevation: 10.0,
                      child: Icon(
                        Icons.add,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => {
                        _increase(),
                        Fluttertoast.showToast(
                            msg: "Hey I don't do anything yet. Or do I?",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: _randomColor.randomColor(
                                colorBrightness: ColorBrightness.light),
                            textColor: Colors.black,
                            fontSize: 15.0)
                      },
                    )),
              ),
              Positioned(
                top: 300.0,
                bottom: 10.0,
                child: Container(
                    padding: EdgeInsets.fromLTRB(30.0, 100.0, 10.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "$_posts",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Posts",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 75.0,
                            ),
                            Text(
                              "12",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 75.0,
                            ),
                            Text(
                              "49",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "   Amrit Dash",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "       AOG Developer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 0.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                "I was a coder and pretty much backend. Up untill then, I came to know the existance of Actions on Google. I realised that this would be the new generation's mobile application. Fast forward to the present, I am an Actions on Google Developer(still stuck with backend tough). With one Action published and few more still at beta. So, it's all pretty fresh, you know.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.7),
                                maxLines: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .12,
                child:
                    GradientAppBar("Profile", widget.onSignedOut, widget.auth),
              ),
              // Positioned(
              //   top: MediaQuery.of(context).size.height * .83,
              //   left: MediaQuery.of(context).size.width * .128,
              //   // right: MediaQuery.of(context).size.width,
              //   child: Center(
              //     child: RaisedButton(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
              //       color: Colors.red[300],
              //       elevation: 10.0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //       onPressed: _signOut,
              //       child: new Text(
              //         "LOG OUT",
              //         style: TextStyle(
              //             fontSize: 25.0,
              //             color: Colors.white,
              //             fontWeight: FontWeight.w900,
              //             letterSpacing: 1.0),
              //       ),
              //     ),
              //   ),
              // ),
            ])));
  }
}

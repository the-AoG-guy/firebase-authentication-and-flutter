import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/backdoor.dart';
import 'auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.auth, this.onSignedIn})
      : super(key: key);
  final String title;
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

enum FormType {
  login,
  register,
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String _email, _password;
  int _count = 0;
  bool _obscureText = true;
  FormType _formType = FormType.login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController _textFieldController1 = TextEditingController();
  // TextEditingController _textFieldController2 = TextEditingController();

  double _scale;
  AnimationController _controller;

  void registerUser() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void loginUser() {
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  void initState() {
    super.initState();
    _obscureText = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void backdoor() {
    _count++;
    if (_count == 3) {
      Fluttertoast.showToast(
          msg: "Fine. Fine. You got me!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.pinkAccent,
          textColor: Colors.black,
          fontSize: 15.0);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Backdoor()));
      _count = 0;
    }
    else if (_count == 2) {
      Fluttertoast.showToast(
          msg: "No point in doing that. Backdoor == GONE.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.deepPurpleAccent,
          textColor: Colors.black,
          fontSize: 14.0);
    }
    else {
      Fluttertoast.showToast(
          msg: "Trying the Backdoor? Lol I\'ve removed it!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.purpleAccent,
          textColor: Colors.black,
          fontSize: 15.0);
    }
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

    return new Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment(-1.0, 1.0),
            end: Alignment(1.0, -1.0),
            colors: [const Color(0xAA13CD06), const Color(0xAA2296F3)],
          )),
          padding: const EdgeInsets.fromLTRB(20.0, 100.0, 10.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: backdoor,
                  child: Transform.scale(
                    scale: _scale,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 250.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: 400.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width,
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                          margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 45.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(10.0),
                            border: new Border.all(
                              width: 5.0,
                              color: Colors.white,
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: allFormFields(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 270.0,
                          bottom: 0.0,
                          child: Container(
                            width: 240.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Builder(
                                  builder: (context) => Center(
                                    child: Column(
                                      children: allButtonBuilder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  List<Widget> allButtonBuilder() {
    if (_formType == FormType.register) {
      return [
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 16.0),
          color: Colors.lightBlueAccent,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: signIn,
          child: new Text(
            "SIGN UP",
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text("Already have an account. Login.",
              style: TextStyle(
                fontSize: 12.0,
              )),
          onPressed: () {
            loginUser();
          },
        ),
      ];
    } else {
      return [
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 16.0),
          color: Colors.lightBlueAccent,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: signIn,
          child: new Text(
            "LOG IN",
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text("No Account? Create one now.",
              style: TextStyle(
                fontSize: 12.0,
              )),
          onPressed: () {
            registerUser();
          },
        ),
      ];
    }
  }

  List<Widget> allFormFields() {
    return [
      TextFormField(
        // controller: _textFieldController1,
        validator: (input) {
          if (input.isEmpty) {
            return 'Please type an email';
          }
          if (input.contains('@') == false) {
            return 'Invaild email address.';
          }
        },
        onSaved: (input) => _email = input,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
              size: 25.0,
            ),
            border: InputBorder.none,
            hintText: "Email",
            hintStyle: TextStyle(fontSize: 17.0),
            filled: false,
            fillColor: Colors.black,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0)),
      ),
      SizedBox(height: 10.0),
      Container(
        height: 1.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(150.0, 0.0, 120.0, 0.0),
        ),
        color: Colors.grey[400],
      ),
      SizedBox(height: 20.0),
      TextFormField(
        // controller: _textFieldController2,
        obscureText: !_obscureText,
        validator: (input) {
          if (input.length < 6) {
            return 'Password must be 6 charecters.';
          }
        },
        onSaved: (input) => _password = input,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              size: 25.0,
            ),
            suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: new Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            border: InputBorder.none,
            hintText: "Password",
            hintStyle: TextStyle(fontSize: 17.0),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        if (_formType == FormType.login) {
          String user = await widget.auth.logIn(_email, _password);
          if (user != null) {
            print("Logged In: $user");
            widget.onSignedIn();
            Fluttertoast.showToast(
                msg: "Successfully Logged In",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            _formKey.currentState.reset();
          } else {
            Fluttertoast.showToast(
                msg: "Please verify email first.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          String user = await widget.auth.signUp(_email, _password);
          print("Signed Up: $user");
          // widget.onSignedIn();
          Fluttertoast.showToast(
              msg:
                  "Account Created Successfully.\nVerify your email before logging in.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 13.0);
          _formKey.currentState.reset();
        }
      } catch (e) {
        print(e);
        if (_formType == FormType.login) {
          Fluttertoast.showToast(
              msg: "Incorrect Username or Password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Email Address Exists.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }
}

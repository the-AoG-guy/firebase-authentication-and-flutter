import 'package:flutter/material.dart';
import 'package:test_1/auth.dart';
import 'package:test_1/page1.dart';
import 'package:test_1/page2.dart';

class Page3 extends StatefulWidget {
  Page3({this.auth});
  final BaseAuth auth;

  @override
  _Page3State createState() => _Page3State();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _Page3State extends State<Page3> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() { 
    super.initState();
    widget.auth.activeUser().then((userId) {
        setState(() {
         _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
      }).catchError((onError){
        _authStatus = AuthStatus.notSignedIn;
      });
  }

  void _siginedIn () {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _siginedOut () {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(_authStatus == AuthStatus.notSignedIn) {
      return new MyHomePage(
        auth: widget.auth,
        onSignedIn: _siginedIn,
        );
    }
    else {
      return new Page2(
        auth: widget.auth,
        onSignedOut: _siginedOut,
      );
    }
  }
}


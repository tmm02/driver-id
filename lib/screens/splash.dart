import 'dart:async';

import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


import '../config.dart';
import '../styles.dart';
import 'auth/login_screen.dart';
import 'main_screen.dart';
//import 'auth/login_screen.dart';
//import 'main_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isLogged = false;
  CommonProvider _commonProvider;

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    super.initState();
    letsSnip();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      body: Stack(
        children: [
          Positioned(
            //top: 100,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash_logo.png',
                    width: size.width-150,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 20,),
                  Text('Supported By', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/image22.png',
                        height: 40,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(width: 30,),
                      Image.asset(
                        'assets/images/LogoIPC1.png',
                        height: 40,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text("Versi 1.0"),
            ),
          ),
        ],
      ),
    );
  }

  void letsSnip() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        _isLogged = await Session.get(Session.TOKEN_SESSION_KEY) != null ? true : false;
        //Navigator.of(context).pop();
        if (_isLogged) {
          AccountModel accountModel = await _commonProvider.getMyProfile();
          if(accountModel != null){
            Navigator.push(
              context,
              PageTransition(
                type: Config.PAGE_TRANSITION,
                child: MainScreen(accountModel),
              ),
            );
          }else{
            Navigator.push(
              context,
              PageTransition(
                type: Config.PAGE_TRANSITION,
                child: LoginScreen(),
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            PageTransition(
              type: Config.PAGE_TRANSITION,
              child: LoginScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

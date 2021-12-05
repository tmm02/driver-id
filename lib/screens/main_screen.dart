import 'dart:convert';
import 'dart:io';

import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/beranda/beranda.dart';
import 'package:driverid/screens/riwayat/riwayat.dart';
import 'package:driverid/screens/riwayat/riwayat_list.dart';
import 'package:driverid/screens/verified_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:page_transition/page_transition.dart';

import '../config.dart';
import '../styles.dart';
import 'profile/profile_menu.dart';

class MainScreen extends StatefulWidget {
  AccountModel accountModel;

  MainScreen(this.accountModel, {Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isVerified = false;
  int vercount;

  CommonProvider _commonProvider;

  @override
  void initState() {
    _isVerified = widget.accountModel.status == 'verified' ? true : false;
    if (_isVerified == false) {
      vercount = 1;
    } else {
      vercount = 2;
    }
    _commonProvider = new CommonProvider();

    FirebaseMessaging.instance.getToken().then((fcmId) {
      print("FCM " + fcmId);
      _commonProvider.storeFcm(fcmId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (vercount == 1) {
      Future.delayed(
          Duration.zero,
          () => DialogUtil.notVerifiedDialog(context,
                  message:
                      "Akun anda belum terverifikasi, lengkapi profile anda untuk bisa menikmati benefit berikut:",
                  m1: "Transaksi",
                  m2: "Riwayat Point Transaksi",
                  m3: "Tukar Poin", dialogCallback: (value) async {
                if (value == 'Nanti') {
                  print('Nanti');
                } else if (value == 'Mulai') {
                  print('Mulai');
                  onMulaiPressed();
                }
              }));
      vercount = 3;
    } else if (vercount == 2) {
      Future.delayed(
          Duration.zero,
          () => Navigator.push(
              context,
              PageTransition(
                  type: Config.PAGE_TRANSITION, child: verifiedscreen())));
      vercount = 3;
    }
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onBackPressed(),
        child: Scaffold(
          //extendBodyBehindAppBar: false,
          backgroundColor: Colors.white,
          //appBar: AppBarCustom(),
          body: IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              BerandaScreen(widget.accountModel),
              RiwayatListScreen(widget.accountModel),
              ProfileMenuScreen(widget.accountModel),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            onTap: (newIndex) => onMenuPressed(newIndex),
            items: [
              BottomNavigationBarItem(
                backgroundColor: Styles.colorPrimary,
                icon: Image.asset(
                  'assets/images/home-run@3x.png',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/images/home-run-active@3x.png',
                  width: 30,
                  height: 30,
                ),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                backgroundColor: Styles.colorPrimary,
                icon: Image.asset(
                  'assets/images/riwayat@3x.png',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/images/riwayat-active@3x.png',
                  width: 30,
                  height: 30,
                ),
                label: "Riwayat",
              ),
              BottomNavigationBarItem(
                backgroundColor: Styles.colorPrimary,
                icon: Image.asset(
                  'assets/images/profile@3x.png',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/images/profile_active@3x.png',
                  width: 30,
                  height: 30,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    if (_currentIndex != 0) {
      _currentIndex = 0;
      setState(() {});
    } else {
      exit(0);
      //sendBroadcast('exit');
    }
    return false;
  }

  Future<void> onMenuPressed(newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  Future<void> onMulaiPressed() async {
    setState(() {
      _currentIndex = 2;
    });
  }
}

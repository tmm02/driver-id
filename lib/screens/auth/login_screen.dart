import 'dart:io';

import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/login_passcode_screen.dart';
import 'package:driverid/screens/auth/panduan_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:driverid/widgets/text_link_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:driverid/screens/auth/panduan_api.dart';

import '../../config.dart';
import '../../styles.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  CommonProvider commonProvider;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isRememberLogin = true;

  @override
  void initState() {
    commonProvider = new CommonProvider();
    Future.delayed(Duration.zero, () async {
      AccountModel accountModel = AccountModel.fromSession(
          await Session.get(Session.ACCOUNT_SESSION_KEY));
      setState(() {
        if (accountModel != null) {
          _username.text = accountModel.email;
          _isRememberLogin = true;
        } else {
          _isRememberLogin = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _username?.dispose();
    _password?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      // appBar: AppBarCustom(
      // ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/HeaderIPCDriverid1.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Center(
            child: Container(
              child: Form(
                key: _key,
                child: ListView(
                  //padding: EdgeInsets.only(top: 100, left: size.width*0.05, right: size.width*0.05),
                  children: <Widget>[
                    //Image.asset('assets/images/HeaderIPCDriverid1.png', width:double.infinity, fit: BoxFit.fitWidth,),
                    SizedBox(
                      height: 320,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: TextFieldWidget(
                        controller: _username,
                        label: "Nomor HP",
                        validator: (value) => usernameValidator(value),
                        textInputType: TextInputType.phone,
                        prefix: Text(
                          '    +62    ',
                          style: TextStyle(fontSize: 15),
                        ),
                        onChanged: (value) => onUsernameChanged(value),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          //FilteringTextInputFormatter.allow(RegExp(r'^0+')),
                        ],
                        //onSaved: (value) => _username.text = value.replaceFirst(new RegExp(r'^0+'), ''),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: ButtonWidget(
                        label: "MULAI",
                        onPressed: () => onLogin(context),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Belum punya akun?'),
                        TextLinkWidget(
                          label: "Daftar Disini",
                          onPressed: () async {
                            final path = 'assets/panduan.pdf';
                            final file = await PDFApi.loadAsset(path);
                            openPDF(context, file);
                          },
                        ),
                      ],
                    ),
                    //TextLinkWidget(label: "Lupa password", onPressed: ()=> onForgetPassword(context), ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String usernameValidator(String value) {
    //_username.text = value.replaceFirst(RegExp(r'^0+'), "");
    if (value.trim().isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    } else if (value.length <= 6) {
      return 'Nomor HP yang di masukkan salah';
    } else if (value.indexOf("0") == 0) {
      return 'Angka 0 tidak boleh ada di depan';
    } else {
      return null;
    }
  }

  void onUsernameChanged(String value) {
    //print(value.replaceFirst(RegExp(r'^0+'), ""));
    if (value.indexOf("0") == 0) {
      setState(() {
        _username.text = '';
      });
    }
  }

  Future<void> onLogin(BuildContext context) async {
    if (_key.currentState.validate()) {
      Navigator.push(
          context,
          PageTransition(
              type: Config.PAGE_TRANSITION,
              child: LoginPasscodeScreen(username: '+62${_username.text}')));
    }
  }

  void onSignUp(BuildContext context) {
    _username.text.replaceFirst(RegExp(r'^0+'), "");
    Navigator.push(context,
        PageTransition(type: Config.PAGE_TRANSITION, child: SignupScreen()));
  }

  void openPDF(BuildContext context, File file) {
    Navigator.push(
        context,
        PageTransition(
            type: Config.PAGE_TRANSITION,
            child: PanduanScreen(
              file: file,
            )));
  }
}

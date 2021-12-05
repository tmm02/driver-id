import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/signup_confirm_screen.dart';
import 'package:driverid/screens/main_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:driverid/widgets/text_link_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';
import 'forgot_password_screen.dart';

class LoginPasscodeScreen extends StatefulWidget {
  final String username;

  const LoginPasscodeScreen({Key key, this.username}) : super(key: key);

  @override
  _LoginPasscodeScreenState createState() => _LoginPasscodeScreenState();
}

class _LoginPasscodeScreenState extends State<LoginPasscodeScreen> {
  final _key = GlobalKey<FormState>();

  final TextEditingController _box1 = TextEditingController();
  final TextEditingController _box2 = TextEditingController();
  final TextEditingController _box3 = TextEditingController();
  final TextEditingController _box4 = TextEditingController();
  final TextEditingController _box5 = TextEditingController();
  final TextEditingController _box6 = TextEditingController();
  String _password;
  CommonProvider _commonProvider;

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    super.initState();
  }

  @override
  void dispose() {
    _box1?.dispose();
    _box2?.dispose();
    _box3?.dispose();
    _box4?.dispose();
    _box5?.dispose();
    _box6?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: "Masuk",
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(
                top: 150, left: size.width * 0.05, right: size.width * 0.05),
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Masukkan PIN'),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      controller: _box1,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      obscureText: true,
                      obscuringCharacter: "*",
                      controller: _box2,
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      controller: _box3,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      controller: _box4,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      controller: _box5,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldWidget(
                      maxChar: 1,
                      controller: _box6,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (value) => onChanged(value),
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ButtonWidget(
                label: "MASUK",
                onPressed: () => onLogin(context),
              ),
              SizedBox(
                height: 15,
              ),
              TextLinkWidget(
                label: "Lupa PIN",
                onPressed: () => onForgetPassword(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(String value) {
    if (value.length > 0) {
      _password = _box1.text +
          _box2.text +
          _box3.text +
          _box4.text +
          _box5.text +
          _box6.text;
      if (_password.length < 6) {
        FocusScope.of(context).nextFocus();
      }
    } else if (value.isEmpty) {
      _password = _box1.text +
          _box2.text +
          _box3.text +
          _box4.text +
          _box5.text +
          _box6.text;
      if (_password.length > 0) {
        FocusScope.of(context).previousFocus();
      }
    }
  }

  Future<void> onLogin(BuildContext context) async {
    if (_key.currentState.validate() &&
        _password != null &&
        _password.isNotEmpty &&
        _password.length == 6) {
      DialogUtil.progressBar(context);
      bool isLogin = await _commonProvider.auth(widget.username, _password);
      //hide progress bar
      //Navigator.of(context).pop();
      if (isLogin) {
        //DialogUtil.progressBar(context);
        AccountModel accountModel = await _commonProvider.getMyProfile();
        Navigator.of(context).pop();
        //await Session.set(Session.REMEMBER_LOGIN, _isRememberLogin ? 'Yes' : 'No');
        Navigator.of(context).pop();
        Navigator.push(
            context,
            PageTransition(
                type: Config.PAGE_TRANSITION, child: MainScreen(accountModel)));
      } else {
        Navigator.of(context).pop();
        DialogUtil.alertDialog(context,
            message: 'Invalid user id and password');
      }
    }
  }

  void onForgetPassword(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: Config.PAGE_TRANSITION, child: ForgotPasswordScreen()));
  }
}

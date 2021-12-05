import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/dropdown_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/radio_group_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';
import 'riwayat_list.dart';

class RiwayatScreen extends StatefulWidget {
  AccountModel accountModel;

  RiwayatScreen(this.accountModel, {Key key}) : super(key: key);

  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final _key = GlobalKey<FormState>();
  CommonProvider _commonProvider;

  final TextEditingController _displayname = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    super.initState();
  }

  @override
  void dispose() {
    _displayname?.dispose();
    _username?.dispose();
    _password?.dispose();
    _confirmPassword?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: "Riwayat",
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(
                top: 100, left: size.width * 0.05, right: size.width * 0.05),
            children: <Widget>[
              TextFieldWidget(
                controller: _username,
                label: "Dari Tanggal",
                textInputType: TextInputType.emailAddress,
                validator: (value) => usernameValidator(value),
                readonly: true,
                onPressed: () => onShowDatePicker(),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: _displayname,
                label: "Sampai Tanggal",
                validator: (value) => displaynameValidator(value),
                readonly: true,
                onPressed: () => onShowDatePicker(),
              ),
              SizedBox(
                height: 20,
              ),
              //TextFieldWidget(controller: _password, label: "Terminal Tujuan", validator: (value)=>passwordValidator(value),),
              DropdownWidget(
                hint: 'Rentang',
                label: 'Rentang',
                options: [
                  {'id': '30 Hari Terakhir', 'name': '30 Hari Terakhir'},
                  {'id': '24 Jam Terakhir', 'name': '24 Jam Terakhir'},
                  {'id': '1 Minggu Terakhir', 'name': '1 Minggu Terakhir'}
                ],
                //value: '30 Hari Terakhir',
                callback: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: "TAMPILKAN",
                onPressed: () => onRegister(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  String displaynameValidator(value) {
    if (value.isEmpty) {
      return 'Name Can Not be Empty';
    } else if (value.length <= 3) {
      return 'Name can not less than 3 character';
    } else {
      return null;
    }
  }

  String usernameValidator(value) {
    if (value.isEmpty) {
      return 'Email Can Not be Empty';
    } else if (!value.contains('@')) {
      return 'Email Not Valid';
    } else {
      return null;
    }
  }

  String passwordValidator(value) {
    if (value.isEmpty) {
      return 'Password Can Not be Empty';
    } else if (value.length < 8) {
      return 'Password to short';
    } else {
      return null;
    }
  }

  String confirmPasswordValidator(value) {
    if (value.isEmpty) {
      return 'Confirm password Can Not be Empty';
    } else if (value != _password.text) {
      return "Confirm password doesn't match";
    } else {
      return null;
    }
  }

  void onShowDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
  }

  onRegister(BuildContext context) async {
    // Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
    //     child: RiwayatListScreen()
    // ));
    /*
    if (_key.currentState.validate()) {
      DialogUtil.progressBar(context);
      String verificationCode = await _commonProvider.register(_displayname.text, _username.text, _password.text);

      //hide progress bar
      Navigator.of(context).pop();

      if(verificationCode != null){
        Navigator.of(context).pop();
        Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
            child: SignupPasscodeScreen(verificationCode, username: _username.text, password: _password.text,)
        ));
      }else{
        DialogUtil.alertDialog(context, message:'Failed to register, maybe email already taken');
      }

    }

     */
  }
}

import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/tc_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';
import 'signup_passcode_screen.dart';

class SignupScreen extends StatefulWidget{

  @override
  _SignupScreenState createState() => _SignupScreenState();

}



class _SignupScreenState extends State<SignupScreen> {

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
  void dispose(){
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
        title: "Daftar",
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(top: 100, left: size.width*0.05, right: size.width*0.05),
            children: <Widget>[
              TextFieldWidget(controller: _username, label: "Nomor HP", validator:(value)=>usernameValidator(value), textInputType: TextInputType.number, prefix: Text('    +62    ', style: TextStyle(fontSize: 15),),
                onChanged: (value)=> onUsernameChanged(value),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 20,),
              TextFieldWidget(controller: _displayname, label: "Nama Lengkap", validator: (value)=>displaynameValidator(value),),
              SizedBox(height: 20,),
              PasswordWidget(controller: _password, label: "PIN", validator: (value)=>passwordValidator(value), textInputType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 20,),
              PasswordWidget(controller: _confirmPassword, label: "Ulangi PIN", validator: (value)=>confirmPasswordValidator(value), textInputType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 20,),
              ButtonWidget(label: "DAFTAR", onPressed: ()=> onRegister(context), )
            ],
          ),
        ),
      ),
    );
  }


  void onUsernameChanged(String value){
    if(value.indexOf("0") == 0){
      setState(() {
        _username.text = '';
      });
    }
  }

  String displaynameValidator(String value){
    if (value.trim().isEmpty) {
      return 'Nama lengkap tidak boleh kosong';
    } else if (value.length <= 1) {
      return 'Nama terlalu pendek';
    } else {
      return null;
    }
  }

  String usernameValidator(String value){
    //_username.text = value.replaceFirst(RegExp(r'^0+'), "");
    if (value.trim().isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }else if(value.length <= 6){
      return 'Nomor HP yang di masukkan salah';
    }else if(value.indexOf("0") == 0){
      return 'Angka 0 tidak boleh ada di depan';
    } else {
      return null;
    }
  }

  String passwordValidator(String value){
    if (value.trim().isEmpty) {
      return 'Pin harus 6 digit dan angka';
    }else if(value.length != 6){
      return 'Pin harus 6 digit dan angka';
    } else {
      return null;
    }
  }

  String confirmPasswordValidator(value){
    if (value.isEmpty) {
      return 'Tidak sama dengan pin yang di masukkan';
    } else if (value != _password.text) {
      return 'Tidak sama dengan pin yang di masukkan';
    } else {
      return null;
    }
  }


  onRegister(BuildContext context) async {
    if (_key.currentState.validate()) {
      dynamic response = await Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
          child: TcScreen()
      ));

      if(response == null){
        return;
      }

      DialogUtil.progressBar(context);
      dynamic result = await _commonProvider.register(_displayname.text, '+62'+_username.text, _password.text);

      //hide progress bar
      Navigator.of(context).pop();

      if(result != null && result['success']){
        print(result['otp']);
        //Navigator.of(context).pop();
        Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
            child: SignupPasscodeScreen(username: '+62'+_username.text, password: _password.text,)
        ));
      }else if(result != null && result['success'] == false){
        DialogUtil.alertDialog(context, message:'${result['message']}');
      }

    }
  }


}



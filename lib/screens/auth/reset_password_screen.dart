import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/reset_password_confirm_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';



class ResetPasswordScreen extends StatefulWidget{
  final String email;
  final String verificationCode;

  const ResetPasswordScreen(this.email, this.verificationCode) : super();

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();

}



class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin{
  final _key = GlobalKey<FormState>();

  CommonProvider _commonProvider;

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();


  @override
  void initState(){
    _commonProvider = new CommonProvider();
    super.initState();
  }

  @override
  void dispose(){
    _newPassword?.dispose();
    _confirmNewPassword?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: "Reset PIN",
      ),
      body: formLayout(size),
    );
  }

  Widget formLayout(Size size ){
    return  Container(
      child: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.only(top: 150, left: size.width*0.05, right: size.width*0.05),
          children: <Widget>[
            //Image.asset('assets/images/img_logo_front.png', height: size.height*0.09, fit: BoxFit.fitHeight,),
            //SizedBox(height: 50,),
            PasswordWidget(label:'PIN Baru', controller: _newPassword, validator: (value)=>newPasswordValidator(value),),
            SizedBox(height: 20,),
            PasswordWidget(label:'Ulangi PIN', controller: _confirmNewPassword, validator: (value)=>confirmNewPasswordValidator(value),),
            SizedBox(height: 20,),
            ButtonWidget(label: "SIMPAN", onPressed: ()=> onChangePassword(context))
          ],
        ),
      ),
    );
  }

  String newPasswordValidator(value){
    if (value.isEmpty) {
      return 'New Password Can Not be Empty';
    } else if (value.length < 8) {
      return 'Password to short';
    } else {
      return null;
    }
  }

  String confirmNewPasswordValidator(value){
    if (value.isEmpty) {
      return 'Confirm password Can Not be Empty';
    } else if (value != _newPassword.text) {
      return "Confirm password doesn't match";
    } else {
      return null;
    }
  }

  onChangePassword(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordConfirmScreen("", "")));

    /*
    if (_key.currentState.validate()) {
      DialogUtil.progressBar(context);

      if(await _commonProvider.resetPassword(widget.email, widget.verificationCode, _newPassword.text)){

        AccountModel accountModel = await _commonProvider.auth(widget.email, _newPassword.text);
        //hide progress bar
        Navigator.of(context).pop();

        if(accountModel != null){
          //close this page
          Navigator.of(context).pop();

          //close login page
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
        }

      }else{
        //hide progress bar
        Navigator.of(context).pop();
        DialogUtil.alertDialog(context, message:'Failed to reset password');
      }

    }

     */
  }

}



import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';



class ResetPasswordConfirmScreen extends StatefulWidget{
  final String email;
  final String verificationCode;

  const ResetPasswordConfirmScreen(this.email, this.verificationCode) : super();

  @override
  _ResetPasswordConfirmScreenState createState() => _ResetPasswordConfirmScreenState();

}



class _ResetPasswordConfirmScreenState extends State<ResetPasswordConfirmScreen> with SingleTickerProviderStateMixin{
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
        showBackButton: false,
      ),
      body: formLayout(size),
    );
  }

  Widget formLayout(Size size ){
    return  Container(
      child: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.only(top: 60, left: size.width*0.15, right: size.width*0.15),
          children: <Widget>[
            Image.asset('assets/images/Completedpana1.png', height: size.height*0.35, fit: BoxFit.fitHeight,),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Text('Berhasil Mengatur ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Ulang PIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Text('Kamu berhasil mengatur ulang PIN'),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Driver ID kamu.'),
            ),
            SizedBox(height: 20,),
            ButtonWidget(label: "OK", onPressed: ()=> onChangePassword(context))
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



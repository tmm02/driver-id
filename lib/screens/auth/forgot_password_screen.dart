import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:driverid/widgets/text_link_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';
import 'forgot_password_passcode_screen.dart';
import 'signup_screen.dart';



class ForgotPasswordScreen extends StatefulWidget{

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();

}



class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _key = GlobalKey<FormState>();
  CommonProvider _commonProvider;

  final TextEditingController _email = TextEditingController();


  @override
  void initState() {
    _commonProvider = new CommonProvider();
    super.initState();
  }


  @override
  void dispose(){
    _email?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: 'Rest PIN',
      ),
      body: Container(
        child:Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(top: 60, left: size.width*0.05, right: size.width*0.05),
            children: <Widget>[
              Image.asset('assets/images/Forgotpasswordrafiki1.png', height: size.height*0.35, fit: BoxFit.fitHeight,),
              Align(
                alignment: Alignment.center,
                child: Text('Lupa PIN?'),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Masukkan Nomor HP Anda yang telah'),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Terdaftar. Kami akan mengirimkan email'),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('untuk melakukan reset PIN'),
              ),
              SizedBox(height: 20,),
              TextFieldWidget(controller: _email, hint: "Masukkan nomor HP Anda", textInputType: TextInputType.text, validator: (value)=>emailValidator(value)),
              SizedBox(height: 20,),
              ButtonWidget(label: "RESET PIN", onPressed: ()=> onSend(context)),
            ],
          ),
        ),
      ),
    );
  }

  String emailValidator(value){
    if (value.isEmpty) {
      return 'Email Can Not be Empty';
    } else if (!value.contains('@')) {
      return 'Email Not Valid';
    } else {
      return null;
    }
  }



  Future<void> onSend(BuildContext context) async {
    Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: ForgotPasswordPasscodeScreen("")
    ));

    /*
    if (_key.currentState.validate()) {
      DialogUtil.progressBar(context);
      String verificationCode = await _commonProvider.requestForgotPassword(_email.text);

      //hide progress bar
      Navigator.of(context).pop();

      if(verificationCode != null){
        Navigator.of(context).pop();
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordPasscodeScreen(_email.text, verificationCode)));
        Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
            child: ForgotPasswordPasscodeScreen(_email.text, verificationCode)
        ));
      }else{
        DialogUtil.alertDialog(context, message:'Email or user id not found');
      }
    }

     */
  }

  void onSignUp(BuildContext context) {
    Navigator.of(context).pop();
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
    Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: SignupScreen()
    ));
  }

}



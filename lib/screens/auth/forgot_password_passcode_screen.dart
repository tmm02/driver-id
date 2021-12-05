import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/reset_password_screen.dart';
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


class ForgotPasswordPasscodeScreen extends StatefulWidget{
  final String verificationCode;
  final String username;
  final String password;

  const ForgotPasswordPasscodeScreen(this.verificationCode, {Key key, this.username, this.password}) : super(key: key);

  @override
  _ForgotPasswordPasscodeScreenState createState() => _ForgotPasswordPasscodeScreenState();

}



class _ForgotPasswordPasscodeScreenState extends State<ForgotPasswordPasscodeScreen> {

  final _key = GlobalKey<FormState>();

  final TextEditingController _box1 = TextEditingController();
  final TextEditingController _box2 = TextEditingController();
  final TextEditingController _box3 = TextEditingController();
  final TextEditingController _box4 = TextEditingController();
  final TextEditingController _box5 = TextEditingController();
  final TextEditingController _box6 = TextEditingController();
  String _verificationCode;
  CommonProvider _commonProvider;

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    super.initState();
  }


  @override
  void dispose(){
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
        title: "Verifikasi",
      ),
      body: Container(
        key: _key,
        child:Form(
          child: ListView(
            padding: EdgeInsets.only(top: 150, left: size.width*0.05, right: size.width*0.05),
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text('Kode Verifikasi telah dikirimkan'),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Melalui SMS ke'),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Text('+6281999999xxx', style: TextStyle(color: Styles.colorPrimary, fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box1, onChanged: (value)=> onChanged(value),),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box2, onChanged: (value)=> onChanged(value),),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box3, onChanged: (value)=> onChanged(value),),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box4, onChanged: (value)=> onChanged(value),),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box5, onChanged: (value)=> onChanged(value),),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: TextFieldWidget(maxChar: 1, controller: _box6, onChanged: (value)=> onChanged(value),),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              TextLinkWidget(label: "Kirim Ulang", onPressed: ()=> {}, ),
              SizedBox(height: 30,),
              ButtonWidget(label: "VERIFIKASI", onPressed: ()=> onSend(context),),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.center,
                child: Text('Mohon menunggu 5 menit'),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('untuk mengirim ulang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(String value){
    if(value.length > 0){
      _verificationCode = _box1.text + _box2.text + _box3.text + _box4.text + _box5.text + _box6.text;
      if(_verificationCode.length < 6){
        FocusScope.of(context).nextFocus();
      }
    }
  }


  Future<void> onSend(BuildContext context) async {
    Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: ResetPasswordScreen("", "")
    ));
    /*
    if(widget.verificationCode == _verificationCode){
      DialogUtil.progressBar(context);
      if(await _commonProvider.codeVerification(widget.username, widget.verificationCode)){
        AccountModel accountModel = await _commonProvider.auth(widget.username, widget.password);
        //close progress bar
        Navigator.of(context).pop();
        if(accountModel != null){
          //close this page
          Navigator.of(context).pop();

          //close login page
          Navigator.of(context).pop();
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreen()));
          Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
              child: MainScreen()
          ));
        }
      }else{
        //close progress bar
        Navigator.of(context).pop();
        DialogUtil.alertDialog(context, message:'Invalid code');
      }
    }else{
      DialogUtil.alertDialog(context, message:'Invalid Code');
    }
     */
  }

}



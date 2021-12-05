import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';



class SignupConfirmScreen extends StatefulWidget{
  const SignupConfirmScreen() : super();

  @override
  _SignupConfirmScreenState createState() => _SignupConfirmScreenState();

}



class _SignupConfirmScreenState extends State<SignupConfirmScreen> with SingleTickerProviderStateMixin{
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
              child: Text('Terima Kasih', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Text('Data pendaftaran Anda sudah kami terima'),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Untuk verifikasi dan aktifasi akun Driver ID.'),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Informasi aktifasi melalui SMS. Sementara'),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Anda bisa masuk dengan fitur terbatas'),
            ),
            SizedBox(height: 20,),
            ButtonWidget(label: "OK", onPressed: ()=> onOkPressed(context))
          ],
        ),
      ),
    );
  }


  onOkPressed(BuildContext context) async {
    Navigator.of(context).pop();
  }

}



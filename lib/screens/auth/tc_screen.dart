import 'package:driverid/providers/common_provider.dart';
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

class TcScreen extends StatefulWidget{

  @override
  _TcScreenState createState() => _TcScreenState();

}



class _TcScreenState extends State<TcScreen> {

  final _key = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: "Syarat & Ketentuan",
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10, left: 10, right: 10, bottom: 80,
            child: ListView(
              children: [
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla quam sit nam risus urna sed et sit aliquet. Non, in condimentum quis lectus enim nam nunc. Pharetra, volutpat cras quam nunc non phasellus consectetur cursus nibh. Blandit sed libero diam amet tempor facilisis. Ante aliquam diam et aliquam nisl. Sed neque pulvinar nulla est vitae morbi. Odio faucibus sit posuere dui. Scelerisque eget nisi vel ultrices. Dictum sed mauris venenatis leo consectetur at mauris, scelerisque arcu. Consequat, purus et id morbi.', style: TextStyle(fontSize: 16),),
                SizedBox(height: 20,),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla quam sit nam risus urna sed et sit aliquet. Non, in condimentum quis lectus enim nam nunc. Pharetra, volutpat cras quam nunc non phasellus consectetur cursus nibh. Blandit sed libero diam amet tempor facilisis. Ante aliquam diam et aliquam nisl. Sed neque pulvinar nulla est vitae morbi. Odio faucibus sit posuere dui. Scelerisque eget nisi vel ultrices. Dictum sed mauris venenatis leo consectetur at mauris, scelerisque arcu. Consequat, purus et id morbi.', style: TextStyle(fontSize: 16),),
                SizedBox(height: 20,),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla quam sit nam risus urna sed et sit aliquet. Non, in condimentum quis lectus enim nam nunc. Pharetra, volutpat cras quam nunc non phasellus consectetur cursus nibh. Blandit sed libero diam amet tempor facilisis. Ante aliquam diam et aliquam nisl. Sed neque pulvinar nulla est vitae morbi. Odio faucibus sit posuere dui. Scelerisque eget nisi vel ultrices. Dictum sed mauris venenatis leo consectetur at mauris, scelerisque arcu. Consequat, purus et id morbi.', style: TextStyle(fontSize: 16),),
              ],
            ),
          ),
          Positioned(
            bottom: 10, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(label: "TOLAK", onPressed: (){
                  Navigator.of(context).pop();
                }, buttonWidth: 100, backgroundColor: Colors.white, fontColor: Styles.colorPrimary, borderColor: Styles.colorPrimary,),
                SizedBox(width: 10,),
                ButtonWidget(label: "TERIMA", onPressed: (){
                  Navigator.pop(context, 'Yes');
                }, buttonWidth: 100, )
              ],
            ),
          ),
        ],
      )
    );
  }




}



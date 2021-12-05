import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/redeem_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/redeem_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:driverid/widgets/menu_list_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:driverid/widgets/text_link_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../config.dart';
import '../../styles.dart';

class RedeemPointScreen extends StatefulWidget {
  RedeemModel redeemModel;

  RedeemPointScreen(this.redeemModel, {Key key}) : super(key: key);

  @override
  _RedeemPointScreenState createState() => _RedeemPointScreenState();
}

class _RedeemPointScreenState extends State<RedeemPointScreen> {

  RedeemProvider _redeemProvider;
  List merchantList = ['1', '2', '3'];

  @override
  void initState() {
    _redeemProvider = new RedeemProvider();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Styles.bgcolor,
        appBar: AppBarCustom(
          title: 'Tukar Poin',
        ),
      body: Container(
        child: Card(
          //color: Styles.colorSecondary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah poin yang di tukarkan', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('${widget.redeemModel.reward_qty} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                SizedBox(height: 20,),
                DeviderWidget(),
                if(widget.redeemModel.merchant_id == '1')
                  Image.asset('assets/images/gopay.png', height: 30, fit: BoxFit.fitHeight,),
                if(widget.redeemModel.merchant_id == '2')
                  Image.asset('assets/images/dana.png', height: 30, fit: BoxFit.fitHeight,),
                if(widget.redeemModel.merchant_id == '3')
                  Image.asset('assets/images/alfa.png', height: 30, fit: BoxFit.fitHeight,),

                SizedBox(height: 20,),
                ButtonWidget(label: 'Berikutnya', buttonWidth: 120, onPressed: ()=>onBerikutPressed(),),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      )
    );

  }

  onBerikutPressed() async {
    DialogUtil.progressBar(context);
    //await _redeemProvider.redeemPoint(widget.redeemModel);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }




}

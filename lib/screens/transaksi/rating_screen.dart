import 'dart:io';

import 'package:driverid/models/terminal_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/form_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/dropdown_widget.dart';
import 'package:driverid/widgets/input_file_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/radio_group_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';

class RatingScreen extends StatefulWidget{
  TransactionModel transactionModel;

  RatingScreen({this.transactionModel, Key key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();

}



class _RatingScreenState extends State<RatingScreen> {

  final _key = GlobalKey<FormState>();
  TransactionProvider _transactionProvider;
  int rating = 3;

  @override
  void initState() {
    _transactionProvider = new TransactionProvider();
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
        title: "Transaksi",
      ),
      body: ListView(
        //padding: EdgeInsets.only(top: 100, left: size.width*0.05, right: size.width*0.05),
        children: <Widget>[
          Image.asset('assets/images/feedbackbg.png', height: size.height/2.5, fit: BoxFit.fitHeight,),
          Align(alignment: Alignment.center, child: Text('BERIKAN PENILAIAN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
          SizedBox(height: 5,),
          Align(alignment: Alignment.center, child: Text('Berikan penilaian anda terhadap'),),
          SizedBox(height: 5,),
          Align(alignment: Alignment.center, child: Text('pelayanan terminal ${widget.transactionModel.terminal_name}'),),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    rating = 1;
                    setState(() {
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/sad.png', width: 40, ),
                      SizedBox(height: 5,),
                      Text('Buruk', style: TextStyle(color: rating == 1 ? Colors.black : Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    rating = 2;
                    setState(() {
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/grinning.png', width: 40, ),
                      SizedBox(height: 5,),
                      Text('Biasa Saja', style: TextStyle(color: rating == 2 ? Colors.black : Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    rating = 3;
                    setState(() {
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/happy.png', width: 40, ),
                      SizedBox(height: 5,),
                      Text('Baik', style: TextStyle(color: rating == 3 ? Colors.black : Colors.grey),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Align(alignment: Alignment.center, child: ButtonWidget(label: 'OK', onPressed: ()=> onOkPressed(), buttonWidth: 180,),),

        ],
      ),
    );
  }

  onOkPressed() async {
    DialogUtil.progressBar(context);
    await _transactionProvider.sendRating(widget.transactionModel, rating);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }


}



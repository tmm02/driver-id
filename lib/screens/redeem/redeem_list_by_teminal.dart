import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/redeem_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/redeem_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/redeem/redeem_point.dart';
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

class RedeemListByTerminalScreen extends StatefulWidget {
  final String viewType;
  //dynamic terminalId;
  dynamic compensationHeader;

  RedeemListByTerminalScreen(this.compensationHeader, {this.viewType, Key key}) : super(key: key);

  @override
  _RedeemListByTerminalScreenState createState() => _RedeemListByTerminalScreenState();
}

class _RedeemListByTerminalScreenState extends State<RedeemListByTerminalScreen> {

  RedeemProvider _redeemProvider;
  ScrollController _listViewController;
  bool _isLoading;
  List<RedeemModel> _redeemList = [];
  bool _isNoMore = false;
  int _limit = 10000;
  List merchantList = [];
  dynamic selectedRewardId;

  @override
  void initState() {
    _redeemProvider = new RedeemProvider();

    _listViewController = ScrollController();
    _listViewController.addListener(onListViewScrollListener);
    _isLoading = false;
    getRedeemList();

    super.initState();
  }

  @override
  void dispose() {
    _listViewController?.dispose();
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
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: //_transactionList.length == 0 ?
          //Container(child: Center(child: Text('Tidak ada data riwayat transaksi yang dapat di tampilkan'),)) :
          ListView.builder(
            controller: _listViewController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _redeemList.length,
            itemBuilder: (context, i) {
              //_redeemList[i].compensation_header_id = widget.compensationHeader;
              return Card(
                //color: Styles.colorSecondary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  //side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  //padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
                  width: double.infinity,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(i == 0)
                        Container(
                          //color: Colors.grey,
                          child: Column(
                            children: [
                              Text('${widget.compensationHeader['terminal_name']}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              Text('${widget.compensationHeader['total_point']} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      //Text('${_redeemList[i].terminal_name}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                      //SizedBox(height: 20,),
                      //Text('${_redeemList[i].reward_qty} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                      //SizedBox(height: 20,),
                      SizedBox(height: 10,),
                      Card(
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Text('Nama Reward ID : ${_redeemList[i].reward_id}'),
                                    Text('Nama Kompensasi : ${_redeemList[i].reward_name}'),
                                    Text('Kompensasi Unit : ${_redeemList[i].reward_unit}'),
                                    Text('${_redeemList[i].qty_point ?? 0} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                                  ],
                                ),
                              ),
                              ButtonWidget(label: 'Pilih', buttonWidth: 90, verticalPadding: 3, horizontalPadding: 3, onPressed: ()=>onRiwayatDetailPressed(_redeemList[i]),),
                              /*
                            Text('${_redeemList[i].reward_qty} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                            Radio(value: _redeemList[i].reward_id, groupValue: merchantList, onChanged: (value){
                              selectedRewardId = value;
                              setState(() {
                              });
                            },),
                             */
                            ],
                          ),
                        ),
                      ),
                      /*
                      Card(
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/dana.png', height: 30, fit: BoxFit.fitHeight,),
                            Expanded(child: Text('')),
                            Text('${_redeemList[i].reward_qty} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                            Radio(value: merchantList[1], groupValue: _redeemList[i].merchant_id, onChanged: (value){
                              _redeemList[i].merchant_id = value;
                              setState(() {
                              });
                            },),
                          ],
                        ),
                      ),
                      Card(
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 5,),
                            Image.asset('assets/images/alfa.png', height: 30, fit: BoxFit.fitHeight,),
                            Expanded(child: Text('')),
                            Text('${_redeemList[i].reward_qty} Poin', style: TextStyle(color: Color.fromRGBO(255, 145, 0, 1), fontSize: 16),),
                            Radio(value: merchantList[2], groupValue: _redeemList[i].merchant_id, onChanged: (value){
                              _redeemList[i].merchant_id = value;
                              setState(() {
                              });
                            },),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      ButtonWidget(label: 'Berikutnya', buttonWidth: 120, onPressed: ()=>onRiwayatDetailPressed(_redeemList[i]),),
                      SizedBox(height: 20,),
                       */
                    ],
                  ),
                ),
              );
            }),
      )
    );
  }

  Future<void> onRiwayatDetailPressed(RedeemModel redeemModel) async {
    DialogUtil.confirmDialog(context, message: 'Tukar point?', dialogCallback: (value) async {
      if(value == 'Yes'){
        DialogUtil.progressBar(context);
        await _redeemProvider.redeemPoint(widget.compensationHeader, redeemModel);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    });
    /*
    if(redeemModel.merchant_id == null || redeemModel.merchant_id == ''){
      DialogUtil.alertDialog(context, message: 'Pilih Agen tukar poin');
      return;
    }
    await Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: RedeemPointScreen(redeemModel)
    ));

    onRefresh();
     */
  }

  void getRedeemList() {
    if (!_isLoading && !_isNoMore) {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        List<RedeemModel> response = await _redeemProvider.getRedeemListByTerminal(widget.compensationHeader['terminal_id']);
        for(int i=0; i<response.length; i++){
          merchantList.add(response[i].reward_id);
        }
        setState(() {
          _redeemList.addAll(response);
          _isLoading = false;
          if (response.length < _limit) {
            _isNoMore = true;
          }
        });
      });
    }
  }


  void onListViewScrollListener() {
    Size size = MediaQuery.of(context).size;
    if (_listViewController.offset >= (_listViewController.position.maxScrollExtent - (size.height * 3)) && !_listViewController.position.outOfRange) {
      setState(() {
        getRedeemList();
      });
    }
  }

  Future onRefresh() async {
    print('onRefresh');
    _isNoMore = false;
    _redeemList.clear();
    getRedeemList();
  }


}

import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/redeem_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/redeem_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
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

class RedeemListScreen extends StatefulWidget {
  final String viewType;
  final dynamic terminalId;

  RedeemListScreen(this.terminalId, {this.viewType, Key key}) : super(key: key);

  @override
  _RedeemListScreenState createState() => _RedeemListScreenState();
}

class _RedeemListScreenState extends State<RedeemListScreen> {

  RedeemProvider _redeemProvider;
  ScrollController _listViewController;
  bool _isLoading;
  List<dynamic> _redeemList = [];
  bool _isNoMore = false;
  int _limit = 10000;

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
        title: 'Tukar Point',
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
              return Card(
                //color: Styles.colorSecondary,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Redeem #${_redeemList[i]['redeem_number']}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),),
                          Text('${_redeemList[i]['redeem_status']}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      DeviderWidget(height: 5,),
                      SizedBox(height: 10,),
                      /*
                      Row(
                        children: [
                          Expanded(
                            child: Text('Truck ID : ${_redeemList[i]['tid'] ?? ''}', style: TextStyle(color: Colors.black, fontSize: 16),),
                          ),
                          Expanded(
                            child: Text('Waktu (TRT) : ${_redeemList[i]['trt'] ?? ''}', style: TextStyle(color: Colors.black, fontSize: 16),),
                          ),
                        ],
                      ),

                       */
                      Row(
                        children: [
                          Expanded(
                            child: Text('Terminal : ${_redeemList[i]['terminal_name']}', style: TextStyle(color: Colors.black, fontSize: 16),),
                          ),
                          Expanded(
                            child: Text('${_redeemList[i]['point_use']} Point', style: TextStyle(color: Colors.black, fontSize: 16),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      )
    );
  }

  /*
  void onRiwayatDetailPressed(TransactionModel transactionModel) {
    Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: RiwayatDetailScreen(transactionModel: transactionModel)
    ));
  }
   */

  void getRedeemList() {
    if (!_isLoading && !_isNoMore) {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        List<dynamic> response = await _redeemProvider.getRedeemList(widget.terminalId);
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

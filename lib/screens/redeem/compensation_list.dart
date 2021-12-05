import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/redeem_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/redeem/redeem_list_by_teminal.dart';
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
import 'compensation_detail_list.dart';
import 'redeem_list.dart';

class CompensationListScreen extends StatefulWidget {
  final String viewType;

  CompensationListScreen({this.viewType, Key key}) : super(key: key);

  @override
  _CompensationListScreenState createState() => _CompensationListScreenState();
}

class _CompensationListScreenState extends State<CompensationListScreen> {

  RedeemProvider _redeemProvider;
  ScrollController _listViewController;
  bool _isLoading;
  List<dynamic> _compensationList = [];
  bool _isNoMore = false;
  int _limit = 10000;

  bool isDone;

  @override
  void initState() {
    _redeemProvider = new RedeemProvider();

    _listViewController = ScrollController();
    _listViewController.addListener(onListViewScrollListener);
    _isLoading = false;

    isDone = widget.viewType == 'done' ? true : false;

    getCompensationList();

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
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: //_transactionList.length == 0 ?
          //Container(child: Center(child: Text('Tidak ada data riwayat transaksi yang dapat di tampilkan'),)) :
          ListView.builder(
            controller: _listViewController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _compensationList.length,
            itemBuilder: (context, i) {
              return Card(
                color: isDone ? Styles.colorSecondary : Styles.colorPrimary,
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
                      Text('${_compensationList[i]['terminal_name']}', style: TextStyle(color: isDone ? Colors.black : Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Text('${isDone ? _compensationList[i]['total_reduction_point'] : _compensationList[i]['total_point']} Poin', style: TextStyle(color: isDone ? Colors.black : Colors.white, fontSize: 16),),
                          ),
                          TextLinkWidget(label: "Lihat", onPressed: ()=> onLihatPressed(_compensationList[i]), color: isDone ? Colors.black : Colors.white,),
                          if(!isDone)
                            ButtonWidget(label: "TUKAR", onPressed: ()=> onTukarPressed(_compensationList[i]), buttonWidth: 80, verticalPadding: 3, backgroundColor: isDone ? Colors.black : Colors.white70, fontColor: Styles.colorPrimary,),
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

  void onTukarPressed(dynamic compensationHeader) {
    Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
        child: RedeemListByTerminalScreen(compensationHeader)
    ));
  }

  void onLihatPressed(dynamic compensationHeader) {
    if(isDone) {
      Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
          child: RedeemListScreen(compensationHeader['terminal_id'])
      ));
    }else{
      Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
          child: CompensationDetailListScreen(compensationHeader['terminal_id'])
      ));
    }
  }

  void getCompensationList() {
    if (!_isLoading && !_isNoMore) {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        List<dynamic> response = await _redeemProvider.getCompensationList();
        setState(() {
          _compensationList.addAll(response);
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
        getCompensationList();
      });
    }
  }

  Future onRefresh() async {
    print('onRefresh');
    _isNoMore = false;
    _compensationList.clear();
    getCompensationList();
  }


}

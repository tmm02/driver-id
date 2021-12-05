import 'dart:async';

import 'package:action_broadcast/action_broadcast.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/transaksi/rating_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/boxdecoration_widget.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';

class RiwayatDetailScreen extends StatefulWidget {
  TransactionModel transactionModel;
  final dynamic transactionId;

  //RiwayatDetailScreen({this.transactionModel, Key key}) : super(key: key);
  RiwayatDetailScreen({this.transactionId, Key key}) : super(key: key);

  @override
  _RiwayatDetailScreenState createState() => _RiwayatDetailScreenState();
}

class _RiwayatDetailScreenState extends State<RiwayatDetailScreen> {
  final _key = GlobalKey<FormState>();
  TransactionProvider _transactionProvider;

  final TextEditingController _driverId = TextEditingController();
  final TextEditingController _tid = TextEditingController();
  final TextEditingController _terminalName = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _totalTrt = TextEditingController();

  Timer loopTimer;
  String prevStatus;
  String currentStatus;

  StreamSubscription receiver;

  @override
  void initState() {
    _transactionProvider = new TransactionProvider();
    // _driverId.text = widget.transactionModel?.driver_id;
    // _tid.text = widget.transactionModel?.tid;
    // _terminalName.text = widget.transactionModel?.terminal_name;
    // _status.text = widget.transactionModel?.status;
    // _totalTrt.text = widget.transactionModel?.total_trt;

    getTransactionDetail();
    //initLoop();
    super.initState();

    receiver = registerReceiver(['transaksi']).listen((intent) {
      switch (intent.action) {
        case 'transaksi':
          // print("TERIMA MESSAGE : ${intent.extras}");
          // print("TERIMA MESSAGE : ${intent.extras['transaction_id']}");
          // print("TERIMA MESSAGE : ${intent.extras['action']}");
          // print("TERIMA MESSAGE : ${intent.extras['status']}");
          //
          dynamic transactionId = intent.extras['transaction_id'];
          String status = intent.extras['status'];
          if (widget.transactionModel != null &&
              transactionId != null &&
              transactionId == widget.transactionModel.transaction_id &&
              status == "selesai") {
            onSelesaiPressed();
          } else {
            getTransactionDetail();
          }
          break;
      }
    });
  }

  @override
  void dispose() {
    _tid?.dispose();
    _driverId?.dispose();
    _terminalName?.dispose();
    _confirmPassword?.dispose();
    loopTimer?.cancel();
    receiver?.cancel();
    super.dispose();
  }

  getTransactionDetail() async {
    widget.transactionModel =
        await _transactionProvider.getTransactionDetail(widget.transactionId);
    _driverId.text = widget.transactionModel?.driver_id;
    _tid.text = widget.transactionModel?.tid;
    _terminalName.text = widget.transactionModel?.terminal_name;
    _status.text = widget.transactionModel?.status;
    _totalTrt.text = widget.transactionModel?.total_trt;

    currentStatus = widget.transactionModel?.status;
    setState(() {});

    print('${prevStatus} ${currentStatus} ');
    // if(prevStatus == 'In Progress' && currentStatus == 'Selesai'){
    //   onSelesaiPressed();
    // }
  }

  initLoop() {
    prevStatus = currentStatus;
    loopTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      prevStatus = currentStatus;
      if (widget.transactionModel?.status == 'In Progress') {
        getTransactionDetail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: "Riwayat",
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(
                top: 100, left: size.width * 0.05, right: size.width * 0.05),
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Transaksi #${widget.transactionModel?.no_booking}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  /*
                  Expanded(
                    child: TextFieldWidget(readonly:true, controller: _driverId, label: "Driver ID", textInputType: TextInputType.emailAddress, ),
                  ),
                  SizedBox(width: 10,),
                   */
                  Expanded(
                    child: TextFieldWidget(
                      readonly: true,
                      controller: _tid,
                      label: "Nomor TID",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      readonly: true,
                      controller: _terminalName,
                      label: "Terminal Tujuan",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  /*
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextFieldWidget(readonly:true, controller: _confirmPassword, label: "Layanan", ),
                  ),
                   */
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  /*
                  Expanded(
                    child: TextFieldWidget(readonly:true, controller: _confirmPassword, label: "RC/SP2", ),
                  ),
                  SizedBox(width: 10,),
                   */
                  Expanded(
                    child: TextFieldWidget(
                      readonly: true,
                      controller: _status,
                      label: "Status",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                readonly: true,
                controller: _totalTrt,
                label: "SLA Terminal (Menit)",
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Detail Transaksi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              BoxDecorationWidget(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: EdgeInsets.all(10),
                bgColor: Styles.colorSecondary,
                borderColor: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Styles.colorPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mulai Transaksi',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${widget.transactionModel?.start_date != null && widget.transactionModel?.start_date != '' ? new DateFormat(Config.DATE_TIME_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(widget.transactionModel?.start_date)) : ''}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Styles.colorPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gate-in Terminal',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${widget.transactionModel?.in_date != null && widget.transactionModel?.in_date != '' ? new DateFormat(Config.DATE_TIME_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(widget.transactionModel?.in_date)) : ''}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Styles.colorPrimary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gate-out Terminal',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${widget.transactionModel?.out_date != null && widget.transactionModel?.out_date != '' ? new DateFormat(Config.DATE_TIME_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(widget.transactionModel?.out_date)) : ''}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DeviderWidget(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(child: Text('')),
                          Text(
                            'Waktu (TRT):',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.transactionModel?.trt_achievement == null ? 0 : widget.transactionModel.trt_achievement} Menit',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text('')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (widget.transactionModel?.status == 'In Progress')
                ButtonWidget(
                  label: 'BATAL',
                  backgroundColor: Colors.red,
                  onPressed: () => onBatalPressed(),
                ),
              SizedBox(
                height: 50,
              ),
              //ButtonWidget(label: 'TRANSAKSI SELESAI', onPressed: ()=> onSelesaiPressed(),),
              //SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  onBatalPressed() {
    DialogUtil.batalkanTransaksiDialog(context,
        message: "Apakah kamu yakin ingin membatalkan transaksi ini?",
        dialogCallback: (value) async {
      if (value == 'Yes') {
        await _transactionProvider.cancelTrans(widget.transactionModel);
        Navigator.of(context).pop();
      }
    });
  }

  onSelesaiPressed() {
    DialogUtil.alertDialog(context, message: "Transaksi Selesai",
        dialogCallback: (value) {
      if (value == 'OK') {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context,
            PageTransition(
                type: Config.PAGE_TRANSITION,
                child:
                    RatingScreen(transactionModel: widget.transactionModel)));
      }
    });
  }
}

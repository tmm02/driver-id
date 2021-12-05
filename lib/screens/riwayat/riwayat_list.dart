import 'package:action_broadcast/action_broadcast.dart';
import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:driverid/widgets/menu_list_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../config.dart';
import '../../styles.dart';

class RiwayatListScreen extends StatefulWidget {
  AccountModel accountModel;

  RiwayatListScreen(this.accountModel, {Key key}) : super(key: key);

  @override
  _RiwayatListScreenState createState() => _RiwayatListScreenState();
}

class _RiwayatListScreenState extends State<RiwayatListScreen> {
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  String qStartDate = '2020-01-01';
  String qEndDate = '2030-12-31';

  TransactionProvider _transactionProvider;
  ScrollController _listViewController;
  bool _isLoading;
  List<TransactionModel> _transactionList = [];
  bool _isNoMore = false;
  int _limit = 10000;

  StreamSubscription _receiver;

  @override
  void initState() {
    _transactionProvider = new TransactionProvider();

    _listViewController = ScrollController();
    _listViewController.addListener(onListViewScrollListener);
    _isLoading = false;
    getTransactionList();

    registerBroadcast();

    super.initState();
  }

  void registerBroadcast() {
    _receiver = registerReceiver(['newTransaction', 'exit']).listen((intent) {
      if (intent.action == 'newTransaction') {
        onRefresh();
      } else if (intent.action == 'exit') {}
    });
  }

  @override
  void dispose() {
    _startDate?.dispose();
    _endDate?.dispose();
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
          showBackButton: false,
          title: 'Riwayat',
          actions: [
            IconButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  showFilterDialog();
                }),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => onRefresh(),
          child: //_transactionList.length == 0 ?
              //Container(child: Center(child: Text('Tidak ada data riwayat transaksi yang dapat di tampilkan'),)) :
              ListView.builder(
                  controller: _listViewController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _transactionList.length,
                  itemBuilder: (context, i) {
                    //_transactionList[i].status = 'gagal';
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              '${_transactionList[i].start_date != null && _transactionList[i].start_date != '' ? new DateFormat(Config.DATE_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(_transactionList[i].start_date)) : ''}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Stack(
                            children: [
                              Card(
                                color: Styles.colorPrimary,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 15),
                                  width: double.infinity,
                                  //height: 200,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.25,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Transaksi',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '#${_transactionList[i]?.no_booking}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                              bottom: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text('Truck ID'),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '${_transactionList[i]?.tid ?? " - "}'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text('Terminal'),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '${_transactionList[i]?.terminal_name ?? " - "}'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text('Waktu (TRT)'),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '${_transactionList[i].start_date != null && _transactionList[i].start_date != '' ? new DateFormat(Config.DATE_TIME_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(_transactionList[i].start_date)) : ''}'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              ButtonWidget(
                                                label: "Lihat",
                                                backgroundColor:
                                                    Styles.colorSecondary,
                                                fontColor: Styles.colorPrimary,
                                                verticalPadding: 4,
                                                elevation: 0,
                                                onPressed: () =>
                                                    onRiwayatDetailPressed(
                                                        _transactionList[i]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                top: 13,
                                child: Text(
                                  '${_transactionList[i].status ?? '-'}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          _transactionList[i].status == 'Batal'
                                              ? Colors.red
                                              : Styles.colorPrimary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
        ));
  }

  Future<void> onRiwayatDetailPressed(TransactionModel transactionModel) async {
    await Navigator.push(
        context,
        PageTransition(
            type: Config.PAGE_TRANSITION,
            //child: RiwayatDetailScreen(transactionModel: transactionModel)
            child: RiwayatDetailScreen(
                transactionId: transactionModel.transaction_id)));
    onRefresh();
  }

  void getTransactionList() {
    if (!_isLoading && !_isNoMore) {
      _isLoading = true;
      Future.delayed(Duration.zero, () async {
        List<TransactionModel> response = await _transactionProvider
            .getTransactionList(startDate: qStartDate, endDate: qEndDate);
        setState(() {
          _transactionList.addAll(response);
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
    if (_listViewController.offset >=
            (_listViewController.position.maxScrollExtent -
                (size.height * 3)) &&
        !_listViewController.position.outOfRange) {
      setState(() {
        getTransactionList();
      });
    }
  }

  Future onRefresh() async {
    print('onRefresh');
    _isNoMore = false;
    _transactionList.clear();
    getTransactionList();
  }

  void showFilterDialog() {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: new Wrap(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Expanded(
                        child: Center(
                            child: Text(
                      'Filter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        onRefresh();
                      },
                      child: Text(
                        'Simpan',
                        style:
                            TextStyle(fontSize: 16, color: Styles.colorPrimary),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  child: Text(
                    'Rentang Waktu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                DeviderWidget(
                  height: 3,
                ),
                MenuListWidget(
                  paddingLeft: 20,
                  label: 'Semua tanggal',
                  onPressed: () {
                    qStartDate = '2020-01-01';
                    qEndDate = '2030-12-31';
                    onRefresh();
                    Navigator.of(context).pop();
                  },
                ),
                MenuListWidget(
                  paddingLeft: 20,
                  label: '24 Jam terakhir',
                  onPressed: () {
                    qStartDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().subtract(Duration(hours: 24)));
                    qEndDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().add(Duration(hours: 24)));
                    onRefresh();
                    Navigator.of(context).pop();
                  },
                ),
                MenuListWidget(
                  paddingLeft: 20,
                  label: '1 Minggu terakhir',
                  onPressed: () {
                    qStartDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().subtract(Duration(days: 7)));
                    qEndDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().add(Duration(hours: 24)));
                    onRefresh();
                    Navigator.of(context).pop();
                  },
                ),
                MenuListWidget(
                  paddingLeft: 20,
                  label: '30 Hari terakhir',
                  onPressed: () {
                    qStartDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().subtract(Duration(days: 30)));
                    qEndDate = new DateFormat(Config.DATE_SERVER_FORMAT)
                        .format(DateTime.now().add(Duration(hours: 24)));
                    onRefresh();
                    Navigator.of(context).pop();
                  },
                ),
                MenuListWidget(
                  paddingLeft: 20,
                  label: 'Pilih tanggal',
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        controller: _startDate,
                        label: "Dari",
                        readonly: true,
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            //minTime: DateTime(2018, 3, 5),
                            //maxTime: DateTime(2019, 6, 7),
                            onChanged: (date) {
                              //print('change $date');
                            },
                            onConfirm: (date) {
                              //print('confirm $date');
                              _startDate.text =
                                  new DateFormat(Config.DATE_FORMAT)
                                      .format(date);
                            },
                            currentTime: _startDate.text.isEmpty
                                ? DateTime.now()
                                : new DateFormat(Config.DATE_FORMAT)
                                    .parse(_startDate.text),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        controller: _endDate,
                        label: "Sampai",
                        readonly: true,
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            //minTime: DateTime(2018, 3, 5),
                            //maxTime: DateTime(2019, 6, 7),
                            onChanged: (date) {
                              //print('change $date');
                            },
                            onConfirm: (date) {
                              //print('confirm $date');
                              _endDate.text = new DateFormat(Config.DATE_FORMAT)
                                  .format(date);
                            },
                            currentTime: _endDate.text.isEmpty
                                ? DateTime.now()
                                : new DateFormat(Config.DATE_FORMAT)
                                    .parse(_endDate.text),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

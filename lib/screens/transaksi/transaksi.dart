import 'dart:io';

import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/terminal_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/form_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/boxdecoration_widget.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
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

class TransaksiScreen extends StatefulWidget {
  AccountModel accountModel;
  TransactionModel transactionModel;

  TransaksiScreen(this.accountModel, {Key key}) : super(key: key);
  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final _key = GlobalKey<FormState>();
  TransactionProvider _transactionProvider;

  final TextEditingController _driverId = TextEditingController();
  final TextEditingController _tid = TextEditingController();
  final TextEditingController _rcsp2 = TextEditingController();
  List optionTerminalList = [];
  int terminalSelectedId = -1;

  CommonProvider _commonProvider;
  bool _loadingPath = false;
  String _directoryPath;
  List<PlatformFile> _paths;
  FileType _pickingType = FileType.any;
  bool _multiPick = false;
  String _extension;
  File photoFile;

  File suratFile;

  @override
  void initState() {
    _transactionProvider = new TransactionProvider();
    _commonProvider = new CommonProvider();
    getTerminalList();
    getAccountSession();
    super.initState();
  }

  void getAccountSession() {
    Future.delayed(Duration.zero, () async {
      /*
      _accountModel = AccountModel.fromSession(await Session.get(Session.ACCOUNT_SESSION_KEY));
      if(_accountModel == null){
        _accountModel = new AccountModel();
      }
      */
      if (widget.accountModel.phone == null ||
          widget.accountModel.phone.isEmpty) {
        widget.accountModel.phone =
            await Session.get(Session.USERID_SESSION_KEY);
      }
      _driverId.text = widget.accountModel?.driver_id;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _tid?.dispose();
    _driverId?.dispose();
    _rcsp2?.dispose();
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
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.only(
                top: 100, left: size.width * 0.05, right: size.width * 0.05),
            children: <Widget>[
              TextFieldWidget(
                controller: _driverId,
                label: "Driver ID",
                readonly: true,
                enabled: false,
              ),
              //SizedBox(height: 20,),
              TextFieldWidget(
                controller: _tid,
                label: "Nomor TID",
                validator: (value) => FormUtil.emptyValidator(value,
                    message: "Truk ID tidak boleh kosong"),
              ),
              SizedBox(
                height: 20,
              ),
              //TextFieldWidget(controller: _password, label: "Terminal Tujuan", validator: (value)=>passwordValidator(value),),
              DropdownWidget(
                hint: 'Terminal Tujuan',
                label: 'Terminal Tujuan',
                options: optionTerminalList,
                callback: (value) {
                  terminalSelectedId = value;
                },
                validator: (value) => FormUtil.emptyValidator(value,
                    message: 'Terminal tidak boleh kosong'),
              ),
              SizedBox(
                height: 20,
              ),
              InputFileWidget(
                label: 'Unggah Surat Jalan',
                buttonLabel: 'Unggah File',
                onPressed: () {
                  openFileExplorer();
                },
                filename: suratFile?.path?.split("/")?.last,
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
                          Icons.fiber_manual_record,
                          color: Colors.grey,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
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
                          Icons.fiber_manual_record,
                          color: Colors.grey,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
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
                          Icons.fiber_manual_record,
                          color: Colors.grey,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
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
              /*
              RadioGroupWidget(
                title: 'Layanan',
                optionList: [
                  {'id':'Delivery', 'value':'Delivery'},
                  {'id':'Receiving', 'value':'Receiving'},
                ],
                groupValue: 'Delivery',
                callback: (value){},
              ),
              SizedBox(height: 20,),
              TextFieldWidget(controller: _rcsp2, label: "RC/SP2",),
               */
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: "MULAI",
                onPressed: () => onMulaiTransaksi(context),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTerminalList() async {
    List<TerminalModel> list = await _transactionProvider.getTerminalList();
    for (TerminalModel terminalModel in list) {
      optionTerminalList.add({
        'id': terminalModel.terminal_id,
        'name': terminalModel.terminal_name
      });
    }
    setState(() {});
  }

  onMulaiTransaksi(BuildContext context) async {
    if (_key.currentState.validate()) {
      DialogUtil.confirmDialog(context,
          message: "Apakah anda yakin lanjutkan transaksi?",
          dialogCallback: (value) async {
        if (value == 'Yes') {
          DialogUtil.progressBar(context);

          String foto_tiket = '';
          if (suratFile != null) {
            dynamic uploadResult =
                await _commonProvider.uploadFile(suratFile.path);
            foto_tiket = uploadResult['path'];
            photoFile = null;
          }

          dynamic result = await _transactionProvider.createTransaction(
              truckId: _tid.text,
              terminalId: terminalSelectedId,
              startDate: DateFormat(Config.DATE_TIME_SERVER_FORMAT)
                  .format(new DateTime.now()),
              fotoTiket: foto_tiket);
          Navigator.of(context).pop();
          if (result != null) {
            if (result['success'] != null && result['success']) {
              onSuksesTransaksiBaru(result);
            } else if (result['message'] != null) {
              DialogUtil.alertDialog(context, message: result['message']);
            }
          }
        }
      });
    }
  }

  onSuksesTransaksiBaru(dynamic result) async {
    Navigator.of(context).pop();

    // DialogUtil.progressBar(context);
    // dynamic result = await _transactionProvider.getActiveTransaction();
    // Navigator.of(context).pop();

    if (result != null &&
        result['transaction_id'] != null &&
        result['transaction_id'] != '') {
      //TransactionModel transactionModel = TransactionModel.fromJson(result);
      Navigator.push(
          context,
          PageTransition(
              type: Config.PAGE_TRANSITION,
              //child: RiwayatDetailScreen(transactionModel: transactionModel,)
              child: RiwayatDetailScreen(
                transactionId: result['transaction_id'],
              )));
    }

    /*
              DialogUtil.successDialog(context, message: "Sukses buat transaksi baru", dialogCallback: (value){
                if("Yes" == value){
                  Navigator.of(context).pop();
                }
              });

               */
  }

  void openFileExplorer({String field}) async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;

    _loadingPath = false;

    suratFile = new File(_paths[0].path);

    setState(() {});
  }
}

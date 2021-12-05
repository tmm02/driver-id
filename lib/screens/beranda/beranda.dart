import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:driverid/models/account_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/profile/profile_menu.dart';
import 'package:driverid/screens/redeem/redeem_tab_menu.dart';
import 'package:driverid/screens/riwayat/riwayat_detail.dart';
import 'package:driverid/screens/transaksi/transaksi.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom_Home.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:driverid/screens/beranda/side_menu.dart';
import 'package:driverid/widgets/menu_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';

import '../../config.dart';
import '../../styles.dart';

class BerandaScreen extends StatefulWidget {
  AccountModel accountModel;

  BerandaScreen(this.accountModel, {Key key}) : super(key: key);

  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _BerandaScreenState extends State<BerandaScreen> {
  bool _isVerified = false;
  String masaBerlaku = '';
  String base64QrCode;
  dynamic totalPoint;
  int Vercount;

  CommonProvider _commonProvider;
  TransactionProvider _transactionProvider;

  @override
  void initState() {
    _isVerified = widget.accountModel.status == 'verified' ? true : false;
    if (widget.accountModel?.date_expired != null &&
        widget.accountModel?.date_expired.isNotEmpty) {
      masaBerlaku = new DateFormat(Config.DATE_FORMAT).format(
          new DateFormat(Config.DATE_SERVER_FORMAT)
              .parse(widget.accountModel?.date_expired));
    }
    if (_isVerified == false) {
      Vercount = 1;
    } else {
      Vercount = 2;
    }

    _transactionProvider = new TransactionProvider();
    _commonProvider = new CommonProvider();

    Future.delayed(Duration.zero, () async {
      base64QrCode = await _commonProvider.genQrcode();
      setState(() {
        //print(base64QrCode);
      });
    });

    Future.delayed(Duration.zero, () async {
      await getMyPoint();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      drawer: SideMenuWidget(widget.accountModel),
      appBar: AppBarCustomHome(
        title: 'Beranda',
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Image.asset('assets/images/profile_card_bg.png'),
                Positioned(
                  left: 20,
                  top: 20,
                  child: Row(
                    children: [
                      if (widget.accountModel?.foto_with_ktp_sim == null)
                        Icon(
                          Icons.account_circle_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                      //Image.asset('assets/images/Ellipse 30.png', height: 80, fit: BoxFit.fitHeight,),
                      if (widget.accountModel?.foto_with_ktp_sim != null)
                        Container(
                          //margin: EdgeInsets.only(top: top),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      '${Config.IMAGE_URL}/${widget.accountModel.foto_with_ktp_sim}'))),
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Driver ID : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.accountModel?.driver_id == null ? ' - ' : widget.accountModel?.driver_id}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/images/nuevo-sol.png',
                                width: 15,
                              ),
                              Text(
                                ' ${totalPoint == null ? 0 : totalPoint} Point',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Masa Berlaku : ${masaBerlaku}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () => onProfileBarcodePressed(),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        'assets/images/barcode.png',
                        width: 40,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Image.asset(
                          _isVerified
                              ? 'assets/images/verified_user_black_24dp.png'
                              : 'assets/images/remove_moderator_black_24dp.png',
                          width: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => onStatusPressed(),
                          child: Text(
                            _isVerified
                                ? 'Akun Sudah Terverifikasi'
                                : 'Status ${widget.accountModel.status}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Layanan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/truck@3x.png'),
                          iconSize: 50,
                          onPressed: () => onTransaksiPressed(),
                        ),
                        Text('Transaksi')
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/coins@3x.png'),
                          iconSize: 50,
                          onPressed: () => onRedeemPressed(),
                        ),
                        Text('Tukar Poin')
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Column(
                      children: [
                        /*
                            IconButton(
                              icon: Image.asset('assets/images/pedigree@3x.png'),
                              iconSize: 50,
                              onPressed: () {},
                            ),
                            Text('Induksi Online')

                             */
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/aturan.png'),
                          iconSize: 50,
                          onPressed: () {
                            OpenFile.open("assets/tc.pdf");
                            //_pdfController.loadDocument(PdfDocument.openAsset('assets/tc.pdf'));
                          },
                        ),
                        Text('Aturan')
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                  ),
                  Container(
                    width: 100,
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onProfileBarcodePressed() {
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.accountModel.name}',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Driver ID : ${widget.accountModel?.driver_id == null ? ' - ' : widget.accountModel?.driver_id}',
                        style: TextStyle(fontSize: 18),
                      ),
                      //Image.asset('assets/images/barcode_big.png', width: size.width*0.6, fit: BoxFit.fitWidth,),
                      if (base64QrCode != null && base64Decode != '')
                        Image.memory(
                          base64Decode(base64QrCode),
                          width: size.width * 0.8,
                          fit: BoxFit.fitWidth,
                        ),

                      if (base64QrCode == null || base64Decode == '')
                        Container(
                          width: size.width * 0.8,
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                  child: Text('QR Code tidak terdeteksi'))),
                        ),

                      Align(
                        alignment: Alignment.center,
                        child: ButtonWidget(
                          label: 'KEMBALI',
                          fontColor: Styles.colorPrimary,
                          backgroundColor: Styles.colorSecondary,
                          borderColor: Colors.transparent,
                          buttonWidth: 100,
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  onTransaksiPressed() async {
    // Navigator.push(context, PageTransition(type: Config.PAGE_TRANSITION,
    //     child: TransaksiScreen()
    // ));
    //
    if (_isVerified == false) {
      DialogUtil.cannotBerandaDialog(context,
          message:
              "Tidak bisa melakukan Transaksi karena akun belum diverifikasi",
          dialogCallback: (value) async {
        if (value == 'Yes') {
          //close media list page
        }
      });
    } else {
      DialogUtil.progressBar(context);
      dynamic result = await _transactionProvider.getActiveTransaction();
      Navigator.of(context).pop();

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
      } else {
        Navigator.push(
            context,
            PageTransition(
                type: Config.PAGE_TRANSITION,
                child: TransaksiScreen(widget.accountModel)));
      }
    }
  }

  onRedeemPressed() {
    if (_isVerified == false) {
      DialogUtil.cannotBerandaDialog(context,
          message:
              "Tidak bisa melakukan Tukar Poin karena akun belum diverifikasi",
          dialogCallback: (value) async {
        if (value == 'Yes') {
          //close media list page
        }
      });
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: Config.PAGE_TRANSITION, child: RedeemTabMenuScreen()));
    }
  }

  onMulaiPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: Config.PAGE_TRANSITION,
            child: ProfileMenuScreen(widget.accountModel)));
  }

  Future<void> getMyPoint() async {
    totalPoint = await _commonProvider.getMyPoint();
  }

  onStatusPressed() async {
    if (widget.accountModel.status == 'rejected' ||
        widget.accountModel.status == 'Rejected') {
      String reason = await Session.get(Session.REASON);
      DialogUtil.alertDialog(context, message: reason);
    }
  }
}

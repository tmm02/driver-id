import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/signup_screen.dart';
import 'package:driverid/screens/auth/tc_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import '../../config.dart';
import '../../styles.dart';
import 'signup_passcode_screen.dart';

class PanduanScreen extends StatefulWidget {
  final File file;

  const PanduanScreen({Key key, @required this.file}) : super(key: key);
  @override
  _PanduanScreenState createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  final _key = GlobalKey<FormState>();
  bool _isButtonenabled;
  bool _check;
  bool _isCheckListBoxenabled;
  CommonProvider _commonProvider;
  Color c;
  Color colorcheck;

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    _isButtonenabled = false;
    _check = false;
    _isCheckListBoxenabled = false;
    colorcheck = const Color.fromRGBO(196, 196, 196, 1);
    c = const Color.fromRGBO(141, 200, 227, 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    Size size = MediaQuery.of(context).size;
    bool _checked = false;
    return Scaffold(
        backgroundColor: Styles.bgcolor,
        appBar: AppBarCustom(
          title: "Panduan",
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Ketahui cara berkendara yang baik dan aman di pelabuhan.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: PDFView(
                filePath: widget.file.path,
                pageFling: false,
                pageSnap: false,
                autoSpacing: false,
                onPageChanged: (int page, int total) {
                  print('page change: $page/$total');
                  if (page == 37) {
                    _isCheckListBoxenabled = true;
                    setState(() {
                      colorcheck = const Color.fromRGBO(0, 0, 0, 1);
                    });
                  }
                },
              ),
            ),
            DeviderWidget(
              height: 10,
            ),
            CheckboxListTile(
              title: Text(
                "Saya Sudah Memahami",
                style: TextStyle(color: colorcheck),
              ),
              value: _check,
              onChanged: (_checked) {
                if (_isCheckListBoxenabled == false) {
                } else {
                  setState(() {
                    _check = _checked;
                  });
                  setState(() {
                    if (_check == false) {
                      _isButtonenabled = false;
                      c = const Color.fromRGBO(141, 200, 227, 1);
                    } else {
                      _isButtonenabled = true;
                      c = const Color.fromRGBO(54, 172, 226, 1);
                    }
                  });
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color.fromRGBO(54, 172, 226, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: ButtonWidget(
                  label: "LANJUT",
                  backgroundColor: c,
                  onPressed: () {
                    if (_isButtonenabled == false) {
                    } else {
                      onSignUp(context);
                    }
                  }),
            ),
          ],
        ));
  }

  void onSignUp(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.push(context,
        PageTransition(type: Config.PAGE_TRANSITION, child: SignupScreen()));
  }
}

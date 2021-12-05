import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../styles.dart';

class verifiedscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 100, 60, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/ok-amico1.png',
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'AKUN SUDAH TERVERIFIKASI',
                style: Styles.BoldTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Akun Anda sudah terverifikasi. Kini Anda bisa menikmati benefit berikut:',
                style: Styles.greyTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 4, 10, 4),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.fiber_manual_record,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(text: "   "),
                      TextSpan(text: "Transaksi", style: Styles.greyTextStyle),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 4, 10, 4),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.fiber_manual_record,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(text: "   "),
                      TextSpan(
                          text: "Riwayat Transaksi",
                          style: Styles.greyTextStyle),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 4, 10, 4),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.fiber_manual_record,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(text: "   "),
                      TextSpan(text: "Tukar poin", style: Styles.greyTextStyle),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonWidget(
                  buttonWidth: 250,
                  label: "OK",
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

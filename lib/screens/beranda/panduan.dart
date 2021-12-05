import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../styles.dart';

class panduanscreen extends StatefulWidget {
  @override
  _panduanscreenState createState() => _panduanscreenState();
}

class _panduanscreenState extends State<panduanscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: 'Panduan',
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/instructionmanual.png",
                width: 350,
                height: 350,
              ),
            ),
            Center(
              heightFactor: 1,
              widthFactor: 1,
              child: Text(
                  "Ketahui cara berkendara yang baik dan aman di pelabuhan.",
                  style: Styles.dialogContentTextStyle,
                  textAlign: TextAlign.center),
            ),
            Center(
              child: ButtonWidget(
                label: "Unduh Dokumen",
                buttonWidth: 250,
                cornerRadius: 15,
                onPressed: () {},
              ),
            ),
            Center(
              child: ButtonWidget(
                label: "Selanjutnya",
                buttonWidth: 250,
                cornerRadius: 15,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

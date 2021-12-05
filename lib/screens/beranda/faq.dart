import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../styles.dart';

class faqscreen extends StatefulWidget {
  @override
  _faqscreenState createState() => _faqscreenState();
}

class _faqscreenState extends State<faqscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: 'Yang Sering Ditanyakan',
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

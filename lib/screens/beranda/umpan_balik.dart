import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../styles.dart';

class umpan_balikscreen extends StatefulWidget {
  @override
  _umpan_balikscreenState createState() => _umpan_balikscreenState();
}

class _umpan_balikscreenState extends State<umpan_balikscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: 'Umpan Balik',
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

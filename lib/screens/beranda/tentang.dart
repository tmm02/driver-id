import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../styles.dart';

class tentangscreen extends StatefulWidget {
  @override
  _tentangscreenState createState() => _tentangscreenState();
}

class _tentangscreenState extends State<tentangscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: 'Tentang',
      ),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

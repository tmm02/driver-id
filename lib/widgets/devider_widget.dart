import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviderWidget extends StatelessWidget {
  final double height;
  final Color lineColor;
  final double thickness;

  const DeviderWidget({
    this.height = 20,
    this.lineColor = const Color.fromRGBO(21, 33, 77, 0.05),
    this.thickness,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: lineColor,
      height: height,
      thickness: thickness ?? 2,
      indent: 5,
      endIndent: 5,
    );
  }
}

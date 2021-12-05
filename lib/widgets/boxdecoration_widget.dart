import 'package:driverid/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxDecorationWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color borderColor;
  final Color bgColor;

  const BoxDecorationWidget({
    this.child, this.margin, this.padding, this.borderColor = Styles.colorPrimary, this.bgColor = Colors.white
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: child,
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}

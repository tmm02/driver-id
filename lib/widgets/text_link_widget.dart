import 'package:driverid/styles.dart';
import 'package:flutter/material.dart';

class TextLinkWidget extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double marginTop;
  final double marginBottom;
  final Color color;

  const TextLinkWidget({
    Key key,
    this.label,
    this.onPressed,
    this.marginTop,
    this.marginBottom,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: marginTop == null ? 1 : marginTop,
          bottom: marginBottom == null ? 1 : marginBottom),
      child: FlatButton(
        onPressed: onPressed,
        color: Colors.transparent,
        padding: EdgeInsets.all(15.0),
        splashColor: Colors.transparent,
        child: Text(label,
            style: TextStyle(
              color: color ?? Styles.colorPrimary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }
}

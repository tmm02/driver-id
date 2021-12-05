import 'package:driverid/styles.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class InputFileWidget extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final Function onPressed;
  final String filename;

  const InputFileWidget({
    Key key,
    this.label,
    this.onPressed, this.filename, this.buttonLabel = 'Unggah',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(filename == null ? '' : filename),
                  ),
                  ButtonWidget(label: buttonLabel, buttonWidth:100, horizontalPadding: 0, onPressed: onPressed, verticalPadding: 2, fontSize: 14,),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6))
              )
          )
        ],
      ),

    );
  }
}

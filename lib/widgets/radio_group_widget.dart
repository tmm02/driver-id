import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class RadioGroupWidget extends StatefulWidget {
  final String title;
  final List optionList;
  final String groupValue;
  final Function(String selectedValue) callback;

  const RadioGroupWidget(
      {Key key, this.title, this.optionList, this.groupValue, this.callback})
      : super(key: key);

  @override
  _RadioGroupWidgetState createState() => _RadioGroupWidgetState();
}

class _RadioGroupWidgetState extends State<RadioGroupWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '${widget.title}', style: TextStyle(fontWeight: FontWeight.bold),
              //style: Styles.listMenuTitleTextStyle,
            ),
          ),
          Column(
            children: widget.optionList
                .map((e) => Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            e['value'],
                            //style: Styles.listMenuLabelTextStyle,
                          ),
                        )),
                        Radio(
                          value: e['id'],
                          groupValue: widget.groupValue,
                          activeColor: Styles.colorPrimary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            widget.callback(value);
                          },
                        )
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

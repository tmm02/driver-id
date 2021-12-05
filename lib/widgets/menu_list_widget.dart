import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';



class MenuListWidget extends StatelessWidget {

  final String label;
  final Function onPressed;
  final String leftAsset;
  final String rightAsset;
  final double paddingLeft;

  const MenuListWidget({
    Key key,
    this.label,
    this.onPressed,
    this.leftAsset,
    this.rightAsset, this.paddingLeft = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(width: paddingLeft,),
          if(leftAsset != null)
          Image.asset(leftAsset, width: 32, height: 32,),
          if(leftAsset != null)
          SizedBox(width: 15,),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 0, right: 15, bottom: 15, top: 15),
                child: Text(label, style: Styles.listMenuLabelTextStyle,),
              )
          ),
          if(rightAsset != null)
          Image.asset(rightAsset, width: 20, height: 20,),
        ],
      ),
    );
  }
}
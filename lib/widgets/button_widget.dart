import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String buttonType;
  final String label;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color backgroundColor;
  final double cornerRadius;
  final String imageAsset;
  final double imageSize;
  final double buttonWidth;
  final double buttonHeight;
  final Icon icon;
  final Color fontColor;
  final Color borderColor;
  final double borderWidth;
  final double elevation;

  const ButtonWidget(
      {Key key,
      this.onPressed,
      this.buttonType,
      this.label,
      this.fontSize,
      this.horizontalPadding,
      this.verticalPadding,
      this.backgroundColor,
      this.cornerRadius,
      this.imageAsset,
      this.imageSize = 40,
      this.buttonWidth,
      this.buttonHeight,
      this.fontColor,
      this.borderColor,
      this.icon,
      this.borderWidth,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (buttonType == 'icon') {
      return iconButton();
    } else if (buttonType == 'link') {
      return textLink();
    } else {
      return buttonDefault();
    }
  }

  Widget buttonDefault() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? Styles.colorPrimary,
          onPrimary: Colors.white, //Text Color
          onSurface: Colors.grey, //Disabled Color
          shadowColor: Colors.black45,
          elevation: 3,
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 20,
              vertical: verticalPadding ?? 12),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(cornerRadius ?? 5),
          ),
          side: BorderSide(
            width: borderWidth ?? 0,
            color: borderColor ?? Colors.transparent,
          )),
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(width: 10),
            //Icon(Icons.edit, color: Colors.white, size: 18,),
            if (icon != null) icon,
            if (imageAsset != null)
              Image.asset(
                imageAsset,
                width: imageSize,
              ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: fontSize ?? 16,
                      color: fontColor ?? Colors.white),
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }

  Widget iconButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: elevation ?? 3,
          primary: backgroundColor ?? Styles.colorPrimary,
          onPrimary: Colors.black, //Text Color
          onSurface: Colors.grey, //Disabled Color
          shadowColor: Colors.black45,
          shape: cornerRadius == null
              ? new CircleBorder()
              : new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(cornerRadius),
                )),
      child: icon ??
          Image.asset(
            imageAsset,
            width: imageSize ?? 40,
          ),
    );
    /*
    return IconButton(
      icon: Icon(Icons.bluetooth),
      color: Colors.grey,
      highlightColor: Colors.red,
      hoverColor: Colors.green,
      focusColor: Colors.purple,
      splashColor: Colors.yellow,
      disabledColor: Colors.amber,
      iconSize: 48,
      onPressed: () {},
    );

     */
    /*
    Widget child = icon;//icon;
    if(imageAsset != null){
      child = Image.asset(imageAsset, width: imageSize,);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.white54, //Text Color
          onSurface: Colors.grey, //Disabled Color
          shadowColor: Colors.black45,
          elevation: 3,
          //padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
          textStyle: TextStyle(
            //color: Colors.black,
            //fontSize: 40,
            //fontStyle: FontStyle.italic
          ),
          //side: BorderSide(color: Colors.red, width: 5),
          //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          //shape: new CircleBorder()
          shape: cornerRadius == null ? new CircleBorder() : new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(cornerRadius),)
      ),
      child: Container(
        //width: buttonWidth ?? 40,
        //height: buttonHeight ?? 40,
        alignment: Alignment.center,
        //decoration: BoxDecoration(shape: BoxShape.circle),
        //child: Icon(Icons.camera, size: 35,),
        child: child,
      ),
      onPressed: onPressed,
    );
     */
  }

  Widget textLink() {
    return InkWell(
        onTap: onPressed,
        child: Container(
          //padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5 ),
          child: Text(label,
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
              )),
        ));
  }
}

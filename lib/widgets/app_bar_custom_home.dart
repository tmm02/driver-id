import 'package:flutter/material.dart';

import 'devider_widget.dart';

class AppBarCustomHome extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final String imageSrc;
  final List<Widget> actions;
  final Color backgroundColor;
  final Color iconColor;
  final bool drawerButton;
  final Function onBackPressed;
  final Widget bottomWidget;
  final bool isProfile;
  final bool isChatPage;

  AppBarCustomHome({
    Key key,
    this.title,
    this.actions,
    this.imageSrc,
    this.backgroundColor,
    this.iconColor,
    this.drawerButton = true,
    this.onBackPressed,
    this.bottomWidget,
    this.isProfile = false,
    this.isChatPage = false,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor == null
          ? Color.fromRGBO(255, 255, 255, 0.8)
          : backgroundColor,
      //brightness: Brightness.light,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment:
            isProfile ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          title == null
              ? SizedBox()
              : isProfile
                  ? Text(
                      title,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
          imageSrc == null
              ? SizedBox()
              : Image.asset(
                  imageSrc,
                  height: 35,
                ),
        ],
      ),
      automaticallyImplyLeading: true,
      leading: drawerButton
          ? IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer())
          : null,
      actions: actions,
      bottom: bottomWidget ??
          PreferredSize(
            child: DeviderWidget(height: 1),
            preferredSize: Size.fromHeight(1.0),
          ),
    );
  }

  void onBackPressedDef(context) {
    Navigator.of(context).pop();
  }
}

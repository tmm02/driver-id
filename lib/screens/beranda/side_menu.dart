import 'dart:convert';

import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/auth/login_screen.dart';
import 'package:driverid/screens/beranda/faq.dart';
import 'package:driverid/screens/beranda/imagegenerator.dart';
import 'package:driverid/screens/beranda/panduan.dart';
import 'package:driverid/screens/beranda/sertifikat.dart';
import 'package:driverid/screens/beranda/tentang.dart';
import 'package:driverid/screens/beranda/umpan_balik.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driverid/models/account_model.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../config.dart';
import '../../../styles.dart';

class SideMenuWidget extends StatefulWidget {
  AccountModel accountModel;
  SideMenuWidget(this.accountModel, {Key key}) : super(key: key);
  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  CommonProvider _commonProvider;

  @override
  void initState() {
    _commonProvider = new CommonProvider();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16),
            if (widget.accountModel?.foto_with_ktp_sim == null)
              Icon(
                Icons.account_circle_outlined,
                size: 80,
                color: Colors.grey,
              ),
            if (widget.accountModel?.foto_with_ktp_sim != null)
              Container(
                //margin: EdgeInsets.only(top: top),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: CachedNetworkImageProvider(
                            '${Config.IMAGE_URL}/${widget.accountModel.foto_with_ktp_sim}'))),
              ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${widget.accountModel?.name == null ? '-' : widget.accountModel?.phone}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            DeviderWidget(),
            buildMenuItem(
              text: 'Panduan',
              icon: Icons.description,
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                        type: Config.PAGE_TRANSITION, child: panduanscreen()));
                setState(() {});
              },
            ),
            buildMenuItem(
              text: 'Sertifikat',
              icon: Icons.verified,
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                        type: Config.PAGE_TRANSITION,
                        child: ImageGenerator(widget.accountModel)));
                setState(() {});
              },
            ),
            buildMenuItem(
              text: 'Umpan Balik',
              icon: Icons.rate_review,
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                        type: Config.PAGE_TRANSITION,
                        child: umpan_balikscreen()));
                setState(() {});
              },
            ),
            buildMenuItem(
              text: 'Yang Sering Ditanyakan',
              icon: Icons.help,
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                        type: Config.PAGE_TRANSITION, child: faqscreen()));
                setState(() {});
              },
            ),
            buildMenuItem(
              text: 'Tentang',
              icon: Icons.info,
              onTap: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                        type: Config.PAGE_TRANSITION, child: tentangscreen()));
                setState(() {});
              },
            ),
            const SizedBox(height: 24),
            DeviderWidget(),
            buildMenuItemRed(
              text: 'Keluar',
              icon: Icons.logout,
            )
          ],
        ),
      ),
    );
  }

  buildMenuItem({String text, IconData icon, Function onTap}) {
    final color = Colors.black;
    final hoverColor = Colors.black87;
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }

  buildMenuItemRed({String text, IconData icon}) {
    final color = Colors.black;
    final hoverColor = Colors.black87;

    return ListTile(
      leading: Icon(
        icon,
        color: Styles.colorDanger,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: () {
        onLogoutPressed(context);
      },
    );
  }

  onLogoutPressed(BuildContext context) {
    DialogUtil.confirmDialog(context, message: 'Keluar dari aplikasi?',
        dialogCallback: (value) async {
      if (value == 'Yes') {
        await Session.remove(Session.TOKEN_SESSION_KEY);
        //close media list page
        Navigator.of(context).pop();
        //Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
}

import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/providers/transaction_provider.dart';
import 'package:driverid/screens/auth/login_screen.dart';
import 'package:driverid/screens/profile/profile.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/devider_widget.dart';
import 'package:driverid/widgets/dropdown_widget.dart';
import 'package:driverid/widgets/menu_list_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/radio_group_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../config.dart';
import '../../styles.dart';

class ProfileMenuScreen extends StatefulWidget {
  AccountModel accountModel;

  ProfileMenuScreen(this.accountModel, {Key key}) : super(key: key);

  @override
  _ProfileMenuScreenState createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  TransactionProvider _transactionProvider;

  @override
  void initState() {
    _transactionProvider = new TransactionProvider();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        showBackButton: false,
        title: "Profile",
      ),
      body: Container(
          padding: EdgeInsets.only(top: 15, left: 30, right: 30),
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                            'Driver ID ${widget.accountModel?.driver_id == null ? ' - ' : widget.accountModel?.driver_id}'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  if (widget.accountModel?.foto_with_ktp_sim == null)
                    Icon(
                      Icons.account_circle_outlined,
                      size: 90,
                      color: Colors.grey,
                    ),
                  //Image.asset('assets/images/Ellipse 30.png', height: 80, fit: BoxFit.fitHeight,),
                  if (widget.accountModel?.foto_with_ktp_sim != null)
                    Container(
                      //margin: EdgeInsets.only(top: top),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                  '${Config.IMAGE_URL}/${widget.accountModel.foto_with_ktp_sim}'))),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeProfile',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/person_outline_black_24dp1.png',
                label: 'Update Profile ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changePin',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/lock_black_24dp.png',
                label: 'Ubah PIN ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeKtp',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/badge_black_24dp.png',
                label: 'Update KTP ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeSim',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/directions_car_black_24dp.png',
                label: 'Update SIM ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeSertifikat',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/card_membership_black_24dp.png',
                label: 'Update Sertifikat ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeIdCard',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/assignment_ind_black_24dp1.png',
                label: 'Update ID Card ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              MenuListWidget(
                onPressed: () async {
                  DialogUtil.progressBar(context);
                  dynamic result =
                      await _transactionProvider.getActiveTransaction();
                  Navigator.of(context).pop();
                  if (result != null &&
                      result['transaction_id'] != null &&
                      result['transaction_id'] != '') {
                    DialogUtil.cannotUpdateDialog(context,
                        dialogCallback: (value) async {
                      if (value == 'Yes') {
                        //close media list page
                      }
                    });
                  } else {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: Config.PAGE_TRANSITION,
                            child: ProfileScreen(
                              widget.accountModel,
                              viewType: 'changeFoto',
                            )));
                    setState(() {});
                  }
                },
                leftAsset: 'assets/images/photo_camera_black_24dp2.png',
                label: 'Update Foto Selfie ',
                rightAsset: 'assets/images/ic_chevron_right.png',
              ),
              DeviderWidget(
                height: 1,
              ),
              SizedBox(
                height: 40,
              ),
              ButtonWidget(
                label: "KELUAR",
                onPressed: () => onLogoutPressed(context),
                backgroundColor: Color(0xffFFE2E5),
                fontColor: Styles.colorDanger,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )),
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

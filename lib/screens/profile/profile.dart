import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:driverid/models/account_model.dart';
import 'package:driverid/providers/common_provider.dart';
import 'package:driverid/screens/util/photo_crop_screen.dart';
import 'package:driverid/utils/dialog_util.dart';
import 'package:driverid/utils/session.dart';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:driverid/widgets/button_widget.dart';
import 'package:driverid/widgets/dropdown_widget.dart';
import 'package:driverid/widgets/input_file_widget.dart';
import 'package:driverid/widgets/password_widget.dart';
import 'package:driverid/widgets/radio_group_widget.dart';
import 'package:driverid/widgets/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'dart:io' as Io;
import 'dart:convert';

import '../../config.dart';
import '../../styles.dart';

class ProfileScreen extends StatefulWidget {
  final String viewType;
  AccountModel accountModel;

  ProfileScreen(this.accountModel, {Key key, this.viewType}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _key = GlobalKey<FormState>();
  CommonProvider _commonProvider;
  //AccountModel _accountModel;

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _perusahaan = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  final TextEditingController _noKtp = TextEditingController();
  final TextEditingController _noSim = TextEditingController();

  final TextEditingController _expYear = TextEditingController();
  final TextEditingController _expMonth = TextEditingController();
  final TextEditingController _dateExpText = TextEditingController();

  DateTime _dateExp;

  bool _loadingPath = false;
  String _directoryPath;
  List<PlatformFile> _paths;
  FileType _pickingType = FileType.any;
  bool _multiPick = false;
  String _extension;
  File photoFile;

  File ktpFile;
  File simFile;
  File sertifikat1File;
  File sertifikat2File;
  File idCardFile;

  @override
  void initState() {
    _commonProvider = new CommonProvider();
    //_accountModel = new AccountModel();
    getAccountSession();

    super.initState();
  }

  void getAccountSession() {
    Future.delayed(Duration.zero, () async {
      /*
      _accountModel = AccountModel.fromSession(await Session.get(Session.ACCOUNT_SESSION_KEY));
      if(_accountModel == null){
        _accountModel = new AccountModel();
      }
      */
      if (widget.accountModel.phone == null ||
          widget.accountModel.phone.isEmpty) {
        widget.accountModel.phone =
            await Session.get(Session.USERID_SESSION_KEY);
      }
      _phone.text = widget.accountModel?.phone?.replaceAll("+62", "");
      _name.text = widget.accountModel?.name;
      _alamat.text = widget.accountModel?.address;
      _perusahaan.text = widget.accountModel?.truck_company;
      _noKtp.text = widget.accountModel?.social_id;
      _noSim.text = widget.accountModel?.sim_number;

      if (widget.accountModel?.date_expired != null &&
          widget.accountModel?.date_expired.isNotEmpty) {
        _dateExpText.text = new DateFormat(Config.DATE_FORMAT).format(
            new DateFormat(Config.DATE_SERVER_FORMAT)
                .parse(widget.accountModel?.date_expired));
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _name?.dispose();
    _phone?.dispose();
    _password?.dispose();
    _confirmNewPassword?.dispose();
    _alamat?.dispose();
    _perusahaan?.dispose();
    _noKtp?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String title = 'Profile';
    List<Widget> child = [];
    if (widget.viewType == 'changeProfile') {
      title = 'Update Profile';
      child = changeProfileLayout();
    } else if (widget.viewType == 'changePin') {
      title = 'Ubah PIN';
      child = changePinLayout();
    } else if (widget.viewType == 'changeKtp') {
      title = 'Update KTP';
      child = changeKtpLayout();
    } else if (widget.viewType == 'changeSim') {
      title = 'Update SIM';
      child = changeSimLayout();
    } else if (widget.viewType == 'changeSertifikat') {
      title = 'Update Sertifikat';
      child = changeSertifikatLayout();
    } else if (widget.viewType == 'changeIdCard') {
      title = 'Update ID Card';
      child = changeIdCardLayout();
    } else if (widget.viewType == 'changeFoto') {
      title = 'Update Foto Selfie';
      child = changeFotoLayout();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Styles.bgcolor,
      appBar: AppBarCustom(
        title: title,
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
              padding: EdgeInsets.only(
                  top: 100, left: size.width * 0.05, right: size.width * 0.05),
              children: child),
        ),
      ),
    );
  }

  List<Widget> changeProfileLayout() {
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _phone,
        label: "Nomor HP",
        readonly: true,
        validator: (value) => usernameValidator(value),
        textInputType: TextInputType.number,
        prefix: Text(
          '    +62    ',
          style: TextStyle(fontSize: 15),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _name,
        label: "Nama Lengkap",
        validator: (value) => emptyValidator(value),
      ),
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _alamat,
        label: "Alamat",
        validator: (value) => emptyValidator(value),
        maxLines: 4,
      ),
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _perusahaan,
        label: "Perusahaan",
        validator: (value) => emptyValidator(value),
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdate(context),
      )
    ];
  }

  List<Widget> changePinLayout() {
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      PasswordWidget(
        label: 'PIN Lama',
        controller: _password,
        validator: (value) => passwordValidator(value),
        textInputType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      SizedBox(
        height: 20,
      ),
      PasswordWidget(
        label: 'PIN Baru',
        controller: _newPassword,
        validator: (value) => passwordValidator(value),
        textInputType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      SizedBox(
        height: 20,
      ),
      PasswordWidget(
        label: 'Ulangi PIN Baru',
        controller: _confirmNewPassword,
        validator: (value) => confirmPasswordValidator(value),
        textInputType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdatePin(context),
      )
    ];
  }

  List<Widget> changeKtpLayout() {
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _noKtp,
        label: "Nomor KTP",
        textInputType: TextInputType.number,
        validator: (value) => emptyValidator(value),
      ),
      SizedBox(
        height: 20,
      ),
      InputFileWidget(
        label: 'Unggah KTP',
        buttonLabel: 'Unggah File',
        onPressed: () {
          openFileExplorer();
        },
        filename: ktpFile?.path?.split("/")?.last,
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdate(context),
      )
    ];
  }

  List<Widget> changeSimLayout() {
    Size size = MediaQuery.of(context).size;
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      TextFieldWidget(
        controller: _noSim,
        label: "Nomor SIM",
        validator: (value) => emptyValidator(value),
      ),
      SizedBox(
        height: 20,
      ),
      /*
      Row(
        children: [
          Expanded(
            child: TextFieldWidget(controller: _expYear, label: "Masa Berlaku", ),
          ),
          SizedBox(width: 10,),
          Container(
            width: size.width * 0.25,
            child: TextFieldWidget(controller: _expMonth, label: "", ),
          )
        ],
      ),
       */
      TextFieldWidget(
        controller: _dateExpText,
        label: "Masa Berlaku",
        readonly: true,
        onPressed: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            onChanged: (date) {},
            onConfirm: (date) {
              _dateExpText.text =
                  new DateFormat(Config.DATE_FORMAT).format(date);
              _dateExp = date;
            },
            currentTime: _dateExpText.text.isEmpty
                ? DateTime.now()
                : new DateFormat(Config.DATE_FORMAT).parse(_dateExpText.text),
          );
        },
      ),
      SizedBox(
        height: 20,
      ),
      InputFileWidget(
        label: 'Unggah SIM',
        buttonLabel: 'Unggah File',
        onPressed: () {
          openFileExplorer();
        },
        filename: simFile?.path?.split("/")?.last,
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdate(context),
      )
    ];
  }

  List<Widget> changeSertifikatLayout() {
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      InputFileWidget(
        label: 'Unggah Sertifikat 1',
        buttonLabel: 'Unggah File',
        onPressed: () {
          openFileExplorer(field: 'sertifikat1');
        },
        filename: sertifikat1File?.path?.split("/")?.last,
      ),
      SizedBox(
        height: 20,
      ),
      InputFileWidget(
        label: 'Unggah Sertifikat 2',
        buttonLabel: 'Unggah File',
        onPressed: () {
          openFileExplorer(field: 'sertifikat2');
        },
        filename: sertifikat2File?.path?.split("/")?.last,
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdate(context),
      )
    ];
  }

  List<Widget> changeIdCardLayout() {
    return <Widget>[
      InputFileWidget(
        label: 'Unggah ID Card',
        buttonLabel: 'Unggah File',
        onPressed: () {
          openFileExplorer();
        },
        filename: idCardFile?.path?.split("/")?.last,
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "SIMPAN",
        onPressed: () => onSubmitUpdate(context),
      )
    ];
  }

  List<Widget> changeFotoLayout() {
    Size size = MediaQuery.of(context).size;
    return <Widget>[
      Container(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 1,
                radius: Radius.circular(100),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(),
                        Icon(
                          Icons.photo_camera_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                        Text(
                          'Foto Selfie',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          'Memegang KTP',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    if (widget.accountModel?.foto_with_ktp_sim != null)
                      Container(
                        //margin: EdgeInsets.only(top: top),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                    '${Config.IMAGE_URL}/${widget.accountModel.foto_with_ktp_sim}'))),
                      ),
                    if (photoFile != null)
                      Container(
                        width: double.infinity,
                        child: Image.file(
                          photoFile,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),

                    /*
                    if(photoFile == null && widget.accountModel.foto_with_ktp_sim != null && widget.accountModel.foto_with_ktp_sim.isNotEmpty)
                      Container(
                        width: double.infinity,
                        child: Image.memory(base64Decode(widget.accountModel.foto_with_ktp_sim), width: double.infinity, fit: BoxFit.fitWidth,)
                      ),
                     */
                  ],
                )),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      ButtonWidget(
        label: "AMBIL FOTO",
        onPressed: () async {
          openImagePicker(ImageSource.camera);
        },
      ),
      SizedBox(
        height: 20,
      ),
      if (photoFile != null)
        ButtonWidget(
          label: "SIMPAN",
          onPressed: () => onSubmitUpdate(context),
        )
    ];
  }

  String usernameValidator(value) {
    if (value.trim().isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    } else if (value.length <= 6) {
      return 'Nomor HP yang di masukkan salah';
    } else if (value.indexOf("0") == 0) {
      return 'Angka 0 tidak boleh ada di depan';
    } else {
      return null;
    }
  }

  String emptyValidator(value) {
    if (value.isEmpty) {
      return 'Tidak boleh kosong';
    } else {
      return null;
    }
  }

  String passwordValidator(value) {
    if (value.trim().isEmpty) {
      return 'Pin harus 6 digit dan angka';
    } else if (value.length != 6) {
      return 'Pin harus 6 digit dan angka';
    } else {
      return null;
    }
  }

  String confirmPasswordValidator(value) {
    if (value.isEmpty) {
      return 'Tidak sama dengan pin baru yang di masukkan';
    } else if (value != _newPassword.text) {
      return 'Tidak sama dengan pin baru yang di masukkan';
    } else {
      return null;
    }
  }

  onSubmitUpdate(BuildContext context) async {
    if (_key.currentState.validate()) {
      DialogUtil.progressBar(context);

      if (_phone.text.isNotEmpty) widget.accountModel.phone = _phone.text;
      if (_name.text.isNotEmpty) widget.accountModel.name = _name.text;
      if (_alamat.text.isNotEmpty) widget.accountModel.address = _alamat.text;
      if (_perusahaan.text.isNotEmpty)
        widget.accountModel.truck_company = _perusahaan.text;
      if (_noKtp.text.isNotEmpty) widget.accountModel.social_id = _noKtp.text;
      if (_noSim.text.isNotEmpty) widget.accountModel.sim_number = _noSim.text;
      if (_dateExp != null)
        widget.accountModel.date_expired =
            new DateFormat(Config.DATE_SERVER_FORMAT).format(_dateExp);

      if (photoFile != null) {
        dynamic uploadResult = await _commonProvider.uploadFile(photoFile.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.foto_with_ktp_sim = uploadResult['path'];
        }
        photoFile = null;
      }

      if (ktpFile != null) {
        dynamic uploadResult = await _commonProvider.uploadFile(ktpFile.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.social_id_foto = uploadResult['path'];
        }
        ktpFile = null;
      }

      if (simFile != null) {
        dynamic uploadResult = await _commonProvider.uploadFile(simFile.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.sim_foto = uploadResult['path'];
        }
        simFile = null;
      }

      if (sertifikat1File != null) {
        dynamic uploadResult =
            await _commonProvider.uploadFile(sertifikat1File.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.sertifikasi_1 = uploadResult['path'];
        }
        sertifikat1File = null;
      }

      if (sertifikat2File != null) {
        dynamic uploadResult =
            await _commonProvider.uploadFile(sertifikat2File.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.sertifikasi_2 = uploadResult['path'];
        }
        sertifikat2File = null;
      }

      if (idCardFile != null) {
        dynamic uploadResult =
            await _commonProvider.uploadFile(idCardFile.path);
        if (uploadResult != null && uploadResult['path'] != null) {
          widget.accountModel.id_card_company = uploadResult['path'];
        }
        idCardFile = null;
      }

      // print(widget.accountModel.foto_with_ktp_sim);

      dynamic result = await _commonProvider.updateProfile(widget.accountModel);
      Navigator.of(context).pop();
      if (result != null && result['success'] != null && result['success']) {
        // DialogUtil.toast(result['message']);
        DialogUtil.successUpdateDialog(context,
            message: "Berhasil update profile", dialogCallback: (value) async {
          if (value == 'Yes') {
            //close media list page
            Navigator.of(context).pop();
          }
        });
      } else {
        DialogUtil.successDialog(context, message: "Gagal update profile");
      }
      //hide progress bar
    }
  }

  void openFileExplorer({String field}) async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;

    _loadingPath = false;

    if (widget.viewType == 'changeProfile') {
    } else if (widget.viewType == 'changePin') {
    } else if (widget.viewType == 'changeKtp') {
      ktpFile = new File(_paths[0].path);
    } else if (widget.viewType == 'changeSim') {
      simFile = new File(_paths[0].path);
    } else if (widget.viewType == 'changeSertifikat') {
      if (field == 'sertifikat1') sertifikat1File = new File(_paths[0].path);
      if (field == 'sertifikat2') sertifikat2File = new File(_paths[0].path);
    } else if (widget.viewType == 'changeIdCard') {
      idCardFile = new File(_paths[0].path);
    } else if (widget.viewType == 'changeFoto') {}

    setState(() {});
  }

  Future<void> openImagePicker(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    final PickedFile pickedFile =
        await imagePicker.getImage(source: imageSource, imageQuality: 20);

    File tempFile;

    setState(() {
      if (pickedFile != null) {
        tempFile = new File(pickedFile.path);
      }
    });

    if (tempFile == null) {
      return;
    }

    Map results = await Navigator.push(
        context,
        PageTransition(
            type: Config.PAGE_TRANSITION,
            child: PhotoCropScreen(
              imageFile: tempFile,
            )));
    if (results != null && results.containsKey('imageFile')) {
      setState(() {
        photoFile = results['imageFile'];
      });
    }
  }

  onSubmitUpdatePin(BuildContext context) async {
    if (_key.currentState.validate()) {
      DialogUtil.progressBar(context);

      //print(_password.text);
      //print(_newPassword.text);
      //print(_confirmNewPassword.text);

      dynamic result =
          await _commonProvider.ubahPin(_password.text, _newPassword.text);
      Navigator.of(context).pop();
      if (result != null && result['message'] != null) {
        DialogUtil.successDialog(context, message: result['message']);
      } else {
        DialogUtil.successDialog(context, message: "Gagal ubah pin");
      }
      //hide progress bar
    }
  }
}

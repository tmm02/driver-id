import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:dio/dio.dart';

import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:driverid/models/account_model.dart';
import 'package:flutter/painting.dart';

import 'package:flutter/services.dart';

import '../../../config.dart';
import '../../../styles.dart';

class sertifikat extends StatefulWidget {
  final Random rd;
  final int numColors;
  sertifikat(this.accountModel, {Key key, this.rd, this.numColors})
      : super(key: key);
  AccountModel accountModel;

  @override
  _sertifikatState createState() => _sertifikatState();
}

class _sertifikatState extends State<sertifikat> {
  ByteData imgBytes;
  ui.Image image;
  String textparagraph;
  String iddriver;
  String linkcert;
  bool loading = false;
  // ui.Paragraph paragraph;

  @override
  void initState() {
    super.initState();

    loadImage('assets/images/certificate.png');
    textparagraph =
        "${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}";
    iddriver =
        '${widget.accountModel?.social_id == null ? ' - ' : widget.accountModel?.social_id}';
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    setState(() => this.image = image);
  }

  Future<AccountModel> getMyProfile() async {
    final url = Uri.parse('http://116.193.190.125:3000/cert');
    final response = await http.post(url, body: {
      'nama': textparagraph,
      'ktp': iddriver,
    });

    print('${response.body}');

    setState(() {
      linkcert = '${response.body}.png';
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          title: 'Sertifikat',
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  child: Text('generate certificate'),
                  onPressed: () {
                    generateImage();
                    getMyProfile();
                  },
                ),
              ),
              imgBytes != null
                  ? Center(
                      child: Image.memory(
                      Uint8List.view(imgBytes.buffer),
                      width: 400,
                      height: 300,
                      alignment: Alignment.center,
                    ))
                  : Container(),
              linkcert != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RaisedButton(
                          child: Text('download cert'),
                          onPressed: downloadFile),
                    )
                  : Container(),
            ],
          ),
        ));
  }

  void generateImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..style = PaintingStyle.fill;

    final textStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: 48,
    );
    final paragraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr, textAlign: TextAlign.center);
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(textparagraph);
    final paragraphBuilder2 = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(iddriver);
    final constraints = ui.ParagraphConstraints(width: 1300);
    final paragraph = paragraphBuilder.build();
    final paragraph2 = paragraphBuilder2.build();
    paragraph.layout(constraints);
    paragraph2.layout(constraints);
    final offset = Offset(-60, 400);
    canvas.drawImage(image, Offset(13, 0), paint);
    canvas.drawParagraph(paragraph, offset);
    canvas.drawParagraph(paragraph2, ui.Offset(-60, 480));

    final picture = recorder.endRecording();
    final img = await picture.toImage(1280, 917);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);

    setState(() {
      imgBytes = pngBytes;
    });
  }

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
        } else {
          return false;
        }
      } else {}
    } catch (e) {}
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile("$linkcert", "sertifikat.png");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }
}

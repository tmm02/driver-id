import 'dart:ui';

import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:driverid/models/account_model.dart';
import 'package:flutter/painting.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../../../config.dart';
import '../../../styles.dart';

class sertifikatscreen extends StatefulWidget {
  AccountModel accountModel;

  sertifikatscreen(this.accountModel, {Key key}) : super(key: key);
  @override
  _sertifikatscreenState createState() => _sertifikatscreenState();
}

class _sertifikatscreenState extends State<sertifikatscreen> {
  ui.Image image;
  String textparagraph;
  // ui.Paragraph paragraph;

  @override
  void initState() {
    super.initState();

    loadImage('assets/images/certificate.png');
    textparagraph =
        "${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}";
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    setState(() => this.image = image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Sertifikat',
      ),
      body: Center(
        child: image == null
            ? CircularProgressIndicator()
            : Container(
                height: 400,
                width: 400,
                child: FittedBox(
                  child: SizedBox(
                    width: image.width.toDouble(),
                    height: image.height.toDouble(),
                    child: CustomPaint(
                      painter: ImagePainter(image, textparagraph),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final String textparagraph;

  // final ui.Paragraph paragraph;

  const ImagePainter(this.image, this.textparagraph);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final recorder = ui.PictureRecorder();
    // final canvas =
    //     Canvas(recorder, Rect.fromPoints(Offset(0.0, 0.0), Offset(370, 370)));
    final paint = Paint();
    final textStyle = ui.TextStyle(
      color: Colors.black,
      fontSize: 24,
    );
    final paragraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr, textAlign: TextAlign.center);
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(textparagraph);
    final constraints = ui.ParagraphConstraints(width: 370);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    final offset = Offset(0, 85);

    canvas.drawImage(image, Offset.zero, paint);
    canvas.drawParagraph(paragraph, offset);
    // final picture = recorder.endRecording();
    // final img = await picture.toImage(200, 200);
    // final pngBytes = await img.toByteData(format: ImageByteFormat.png);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

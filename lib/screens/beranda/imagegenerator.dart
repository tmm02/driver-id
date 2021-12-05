import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:driverid/models/account_model.dart';
import 'package:flutter/painting.dart';

import 'package:flutter/services.dart';

import '../../../config.dart';
import '../../../styles.dart';

class ImageGenerator extends StatefulWidget {
  final Random rd;
  final int numColors;
  ImageGenerator(this.accountModel, {Key key, this.rd, this.numColors})
      : super(key: key);
  AccountModel accountModel;

  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  ByteData imgBytes;
  ui.Image image;
  String textparagraph;
  String iddriver;
  // ui.Paragraph paragraph;

  @override
  void initState() {
    super.initState();

    loadImage('assets/images/certificate.png');
    textparagraph =
        "${widget.accountModel?.name == null ? '-' : widget.accountModel?.name}";
    iddriver =
        '${widget.accountModel?.driver_id == null ? ' - ' : widget.accountModel?.driver_id}';
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text('generate certificate'),
                    onPressed: generateImage),
              ),
              imgBytes != null
                  ? Center(
                      child: Image.memory(
                      Uint8List.view(imgBytes.buffer),
                      width: 400,
                      height: 300,
                      alignment: Alignment.center,
                    ))
                  : Container()
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
    final img = await picture.toImage(1300, 900);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);

    setState(() {
      imgBytes = pngBytes;
    });
  }
}

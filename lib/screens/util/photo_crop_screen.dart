import 'dart:io';
import 'package:driverid/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';


class PhotoCropScreen extends StatefulWidget {
  final File imageFile;

  const PhotoCropScreen({this.imageFile}) : super();

  @override
  _PhotoCropScreenState createState() => _PhotoCropScreenState();
}

class _PhotoCropScreenState extends State<PhotoCropScreen> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBarCustom(
        backgroundColor: Colors.black45,
        iconColor: Colors.white70,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Crop.file(
                widget.imageFile,
                key: cropKey,
                aspectRatio: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Crop Image',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () => _cropImage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    print('hahaha');
    final area = cropKey.currentState.area;
    if (area == null) {
      return;
    }

    final file = await ImageCrop.cropImage(
      file: widget.imageFile,
      area: area,
    );

    Navigator.of(context).pop({'imageFile': file});
  }
}

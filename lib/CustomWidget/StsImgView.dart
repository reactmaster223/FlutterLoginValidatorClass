import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart/Assets/Assets.dart';

class StsImgView extends StatefulWidget{

  static final int LOCAL_IMG = 102;

  late dynamic image;
  late double width;
  late double height;


  StsImgView({required this.image, required this.width, required this.height});

  @override
  _StsImgViewState createState() => _StsImgViewState();
}

class _StsImgViewState extends State<StsImgView> {
  @override
  Widget build(BuildContext context) {

    double width = widget.width;
    double height = widget.height;

    if (widget.image is XFile){

      final XFile imgFile = widget.image as XFile;

      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image.file(File(imgFile.path), width: width, height: height, fit: BoxFit.cover,)
      );
    }

    if (widget.image is File) {

      final imgFile = widget.image as File;

      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image.file(File(imgFile.path), width: width, height: height, fit: BoxFit.cover,)
      );
    }

    if (widget.image is String) {

      final imgPath = widget.image as String;
      if (imgPath.isNotEmpty){
        return FadeInImage.assetNetwork(
            placeholder: Assets.LOADING_GIF_PATH,
            width: width, height: height,
            image: widget.image, fit: BoxFit.cover);
      }

      return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(5)), child: Image(
          image: Assets.DEFAULT_IMG, width: width, height: height, fit: BoxFit.cover));
    }

    /*final Asset image = widget.image as Asset;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: AssetThumb(
          asset: image,
          width: width.toInt(),
          height: height.toInt()),
    );*/

    final AssetImage image = widget.image as AssetImage;

    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Image(
            image: image,
            width: width,
            height: height, fit: BoxFit.cover));
  }
}
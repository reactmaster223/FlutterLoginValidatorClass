import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shopsmart/Assets/Assets.dart';
import 'package:shopsmart/Common/APIConst.dart';
import 'package:shopsmart/Common/Common.dart';
import 'package:shopsmart/CustomWidget/StsImgView.dart';
import 'package:shopsmart/Model/CardModel.dart';
import 'package:shopsmart/Utils/LogUtils.dart';
import 'package:shopsmart/Utils/Utils.dart';

class TakePhotoPage extends StatefulWidget {
  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late dynamic picture = Assets.DEFAULT_IMG;
  final ImagePicker _picker = ImagePicker();

  late final ProgressDialog progressDialog;

  Future<void> takePhotoFromGallery(ImageSource imgSource) async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: imgSource);
    final croppedFile = await cropImage(image);
    setState(() {
      picture = croppedFile;
    });
    debugPrint('hre');
  }

  @override
  void initState() {
    super.initState();

    progressDialog = ProgressDialog(context, isDismissible: false);
    progressDialog.style(
        progressWidget: Container(
            padding: EdgeInsets.all(13),
            child: CircularProgressIndicator(color: Colors.orange)));
  }

  void savePhoto() async {
    await progressDialog.show();
    final temp = picture as File;
    Common.firebaseAPI.uploadMoodPicture(temp).then((value) {
      progressDialog.hide();

      LogUtils.log('filePath ===> ${value}');

      if (value.isNotEmpty) {
        saveCard(value);
      } else {
        showToast(APIConst.NETWORK_ERROR);
      }
    }).onError((error, stackTrace) {
      LogUtils.log('File Upload Error ====> ${error.toString()}');
      showToast(APIConst.NETWORK_ERROR);
      progressDialog.hide();
    });
  }

  void saveCard(String imgPath) async {
    if (Common.uid.isNotEmpty) {
      final data = {APIConst.image: imgPath};

      Common.firebaseAPI.updateCard(Common.uid, data).then((value) {
        if (value) {
          Common.uid = '';
          Common.cardModel = new CardModel();
          Navigator.pop(context);
        } else {
          showToast(APIConst.NETWORK_ERROR);
        }
      }).onError((error, stackTrace) {
        LogUtils.log('Error ===> ${error.toString()}');
        showToast(APIConst.NETWORK_ERROR);
      });
    } else {
      Common.cardModel = new CardModel();
      Common.cardModel.image = imgPath;
      Common.firebaseAPI.saveCard(Common.cardModel).then((value) {
        if (value) {
          Navigator.pop(context);
        } else {
          showToast(APIConst.NETWORK_ERROR);
        }
      }).onError((error, stackTrace) {
        LogUtils.log('Error ===> ${error.toString()}');
        showToast(APIConst.NETWORK_ERROR);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: StsImgView(
                    image: picture,
                    width: MediaQuery.of(context).size.width,
                    height: 300)),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  takePhotoFromGallery(ImageSource.camera);
                },
                child: Text(
                  'Take photo from Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 20),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  takePhotoFromGallery(ImageSource.gallery);
                },
                child: Text(
                  'Take photo from Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  savePhoto();
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

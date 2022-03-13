import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopsmart/Common/APIConst.dart';
import 'package:shopsmart/Common/Common.dart';
import 'package:shopsmart/Model/CardModel.dart';

class FirebaseAPI {
  static const String TB_CARD = 'tb_card';
  CollectionReference fbBarcode = FirebaseFirestore.instance.collection(TB_CARD);
  FirebaseStorage fbStorage = FirebaseStorage.instance;

  Future<String> uploadMoodPicture(File file) async{

    String imgPath = '';
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    Reference ref =  fbStorage.ref().child(fileName);

    UploadTask uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(()  async {
      await ref.getDownloadURL().then((value) {
        imgPath = value;
      }).onError((error, stackTrace) {
        imgPath = '';
      });
    });

    return imgPath;
  }

  Future<bool> updateCard(String uid, Map<String, dynamic> data) async{

    var result = false;
    await fbBarcode.doc(uid).update(data).then((value) {
      result = true;
    }).onError((error, stackTrace) {
      result = false;
    });

    return result;
  }

  Future<bool> saveCard(CardModel model) async{

    var result = false;
    await fbBarcode.add(model.toJSON()).then((value){
      Common.uid = value.id;
      result = true;
    }).catchError((error){
      result = false;
    });
    return result;
  }
}
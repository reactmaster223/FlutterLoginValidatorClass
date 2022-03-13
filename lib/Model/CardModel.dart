import 'package:shopsmart/Common/APIConst.dart';

class CardModel {
  String barcodeData = '';
  String image = '';


  CardModel();

  factory CardModel.fromJSON(Map<String, dynamic> res){
    CardModel model = new CardModel();
    model.barcodeData = res[APIConst.barcodeData];
    model.image = res[APIConst.image];
    return model;
  }

  Map<String, dynamic> toJSON(){
    return {
      APIConst.barcodeData : barcodeData,
      APIConst.image : image
    };
  }
}
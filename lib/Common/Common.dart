import 'package:shopsmart/Common/FirebaseAPI.dart';
import 'package:shopsmart/Model/CardModel.dart';

class Common {
  static final FirebaseAPI firebaseAPI = new FirebaseAPI();
  static String uid = '';
  static CardModel cardModel = new CardModel();
}
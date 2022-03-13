import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shopsmart/Common/APIConst.dart';
import 'package:shopsmart/Common/Common.dart';
import 'package:shopsmart/Model/CardModel.dart';
import 'package:shopsmart/Utils/LogUtils.dart';
import 'package:shopsmart/Utils/Utils.dart';

class BarcodeDetailPage extends StatefulWidget {
  String barcode;

  BarcodeDetailPage(this.barcode);

  @override
  State<BarcodeDetailPage> createState() => _BarcodeDetailPageState();
}

class _BarcodeDetailPageState extends State<BarcodeDetailPage> {
  late final ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context, isDismissible: false);
    progressDialog.style(
        progressWidget: Container(
            padding: EdgeInsets.all(13),
            child: CircularProgressIndicator(color: Colors.orange)));
  }

  void saveBarcode() async {
    await progressDialog.show();

    if (Common.uid.isNotEmpty) {
      final data = {APIConst.barcodeData: widget.barcode};
      Common.firebaseAPI.updateCard(Common.uid, data).then((value) {
        progressDialog.hide();
        if (value) {
          Common.uid = '';
          Common.cardModel = new CardModel();
          Navigator.pop(context);
        } else {
          showToast(APIConst.NETWORK_ERROR);
        }
      }).onError((error, stackTrace) {
        progressDialog.hide();
        LogUtils.log('Error ===> ${error.toString()}');
        showToast(APIConst.NETWORK_ERROR);
      });
    } else {
      Common.cardModel = new CardModel();
      Common.cardModel.barcodeData = widget.barcode;

      Common.firebaseAPI.saveCard(Common.cardModel).then((value) {
        progressDialog.hide();
        if (value) {
          Navigator.pop(context);
        } else {
          showToast(APIConst.NETWORK_ERROR);
        }
      }).onError((error, stackTrace) {
        progressDialog.hide();
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 100),
            child: BarcodeWidget(
              data: widget.barcode,
              barcode: Barcode.code128(),
              drawText: false,
            ),
          ),
          SizedBox(height: 30),
          Text(
            widget.barcode,
            style: TextStyle(fontSize: 25),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 52,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 100),
            child: ElevatedButton(
                onPressed: () {
                  saveBarcode();
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

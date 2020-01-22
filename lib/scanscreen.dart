import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String barcodevalue;

  @override
  void initState() {
    barcodevalue = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RaisedButton(
                color: Colors.purple,
                child: Text('Scan Barcode'),
                onPressed: scanbarcode,
              ),
            ),
            Text(barcodevalue, textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  Future<void> scanbarcode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcodevalue = barcode;
      });
    } on PlatformException catch(e) {
      if(e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          this.barcodevalue = 'Camera Permission Not Granted';
        });
      } else {
        setState(() {
          this.barcodevalue = 'Unknown Error $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcodevalue = "null (User returned using the 'back' button before scanning anything, Result) ";
      });
    }
    catch (e) {
      setState(() {
        this.barcodevalue = 'Unknown Error $e';
      });
    }
  }
}

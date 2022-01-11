//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class HomeScanQR extends StatefulWidget {
  const HomeScanQR({Key? key}) : super(key: key);

  @override
  _HomeScanQRState createState() => _HomeScanQRState();
}

class _HomeScanQRState extends State<HomeScanQR> {
  String qrValue = "Codigo Qr";

  Future _qrScanner() async {
    
  }
  
  void scanQr() async {
    var camaraStatus = await Permission.camera.status;

    if (camaraStatus.isGranted) {
      String camaraScanResult = await scanner.scan().toString(); //para manejar valores nulos
      setState(() {
        qrValue = camaraScanResult;
        print("=============================");
        print("este es el valor obtenido de qrValue es: " + qrValue); //para inspeccion
        print("=============================");
      });
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String camaraScanResult = await scanner.scan().toString(); //para manejar valores nulos
        setState(() {
          qrValue = camaraScanResult;
          print("=============================");
          print("este es el valor obtenido de qrValue es: " + qrValue); //para inspeccion
          print("=============================");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Qr Sacan'),
      ),
      body: Center(
        child: Container(
          child: Text(
            qrValue,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => scanQr(),
        child: Icon(Icons.camera),
      ),
    );
  }
}

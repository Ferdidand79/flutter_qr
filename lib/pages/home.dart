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
  String qrValue = "Selecciona el botton scan";
  //TextEditingController controller = TextEditingController();
  late TextEditingController _outputController;
  late String respuesta;

  @override
  initState(){
    super.initState();
    this._outputController = new TextEditingController();
  }

  Future scanQr() async {
    var camaraStatus = await Permission.camera.status;

    if (camaraStatus.isGranted) {
      String? camaraScanResult =
          await scanner.scan(); //para manejar valores nulos
      qrValue = camaraScanResult!;
      print("=============================");
      print("este es el valor obtenido de qrValue es: " +
          qrValue); //para inspeccion
      print("=============================");
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String? camaraScanResult =
            await scanner.scan(); //para manejar valores nulos
        qrValue = camaraScanResult!;
        print("=============================");
        print("este es el valor obtenido de qrValue es: " +
            qrValue); //para inspeccion
        print("=============================");
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 210,
              width: 210,
              child: Image.asset("assets/images/qr.png",
              fit: BoxFit.cover,),
            ),
            Container(
              margin: const EdgeInsets.only(
              right: 0, top: 50, left: 0, bottom: 0),
              child: Text(
                qrValue,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
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

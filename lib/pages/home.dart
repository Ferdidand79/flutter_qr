import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomeScanQR extends StatefulWidget {
  const HomeScanQR({Key? key}) : super(key: key);

  @override
  _HomeScanQRState createState() => _HomeScanQRState();
}

class _HomeScanQRState extends State<HomeScanQR> {
  String qrValue = "Codigo Qr";
  

  void scanQr() async {
    String camaraScanResult = await scanner.scan().toString();//para manejar valores nulos
    setState(() {
      qrValue = camaraScanResult;
    });
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

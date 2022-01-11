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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal:45),
              child: TextField( //https://programmerclick.com/article/2173416205/
                enabled: false,
                //focusNode: ,
                decoration: InputDecoration(
                  //hintText: "ingrese el nombre"
                  /// El mensaje en el cuadro de entrada se muestra cuando el cuadro de entrada no se enfoca
                  labelText: "Datos iderntificados",
                  labelStyle: TextStyle(color: Colors.blue),
                  /// Texto que se muestra debajo del cuadro de entrada
                  helperText: "esto se rescato del Qr",
                  helperStyle: TextStyle(color: Colors.green),
                  /// Texto que se muestra debajo del cuadro de entrada
                  errorText: "No llego valor",
                  errorStyle: TextStyle(color: Colors.red),
                  /// El cuadro de entrada solo se mostrará cuando se adquiera el foco.
                  prefixText: "prefix",
                  prefixStyle: TextStyle(color: Colors.deepPurple),
                  /// El cuadro de entrada solo se mostrará cuando se adquiera el foco. Detrás del texto de entrada
                  suffixText: "suf ",
                  suffixStyle: TextStyle(color: Colors.black),
                  /// El texto que se muestra en la esquina inferior derecha del cuadro de entrada de texto
                  counterText: "count",
                  counterStyle: TextStyle(color: Colors.deepPurple[800]),
                  /// El pequeño icono antes de ingresar texto
                  prefixIcon: Icon(Icons.phone),
                  /// El pequeño icono detrás del texto de entrada
                  suffixIcon: Icon(Icons.close),

                  /// UnderlineInputBorder solo tiene el borde inferior El valor predeterminado es el borde inferior
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),

                  /// Establece el estilo del borde cuando se puede editar el cuadro de entrada
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),


                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    )
                  ),
                ),
              ),
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

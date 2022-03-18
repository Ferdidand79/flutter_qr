//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qr/widget/flatButton_style.dart';
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
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
    //this.qrValue;

    print("==============initdState===============");
    print("este es el valor obtenido de qrValue ess: " +
        qrValue); //para inspeccion
    print("=======================================");
  }

  Future scanQr() async {
    var camaraStatus = await Permission.camera.status;

    if (camaraStatus.isGranted) {
      String? camaraScanResult =
          await scanner.scan(); //para manejar valores nulos
      setState(() {
        //sin esto solo funciona la caja con respuesta
        qrValue = camaraScanResult!;
        respuesta = camaraScanResult;
      });

      this._outputController.text = camaraScanResult!;

      print("=============================");
      print("este es el valor obtenido de QRRValue esS: " +
          qrValue); //para inspeccion
      print("=============================");

      print("este es el valor obtenido de respuesta de Qres: " +
          respuesta); //para inspeccion
      print("=============================");
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String? camaraScanResult =
            await scanner.scan(); //para manejar valores nulos
        setState(() {
          //sin esto solo funciona la caja con respuesta
          qrValue = camaraScanResult!;
          respuesta = camaraScanResult;
        });
        this._outputController.text = camaraScanResult!;
        print("=============================");
        print("este es el valor obtenido de qrValue es: " +
            qrValue); //para inspeccion
        print("=============================");
        print("este es el valor obtenido de respuesta es: " +
            respuesta); //para inspeccion
        print("=============================");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Qr Sacan'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--IMAGEN SUSPERIOR--//
            SizedBox(
              height: 210,
              width: 210,
              child: GestureDetector(
                child: Image.asset(
                  "assets/images/qr.png",
                  fit: BoxFit.cover,
                ),
                onTap: () => scanQr(),
              ),
            ),

            //--CUADRO DE TEXTO--//
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 45),
              child: TextField(
                //https://programmerclick.com/article/2173416205/
                enabled: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
                  //prefixText: "prefix",
                  //prefixStyle: TextStyle(color: Colors.deepPurple),
                  /// El cuadro de entrada solo se mostrará cuando se adquiera el foco. Detrás del texto de entrada
                  //suffixText: "suf ",
                  //suffixStyle: TextStyle(color: Colors.black),
                  /// El texto que se muestra en la esquina inferior derecha del cuadro de entrada de texto
                  counterText: "count",
                  counterStyle: TextStyle(color: Colors.deepPurple[800]),

                  /// El pequeño icono antes de ingresar texto
                  prefixIcon: Icon(Icons.car_rental_outlined),

                  /// El pequeño icono detrás del texto de entrada
                  //suffixIcon: Icon(Icons.car_repair),

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
                      )),
                ),
                obscureText: false,
                //value: respuesta ?? '',
                onChanged: (value) {
                  respuesta = value;
                },
                controller: _outputController,
              ),
            ),

            //--TEXTO INICIAL--//
            Container(
              margin:
                  const EdgeInsets.only(right: 45, top: 0, left: 45, bottom: 0),
              child: Text(
                "texto: " + qrValue,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(right: 0, top: 10, left: 0, bottom: 0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _outputController.clear();
                    qrValue = "Datos identificados";
                  });
                  /*Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomeScanQR();
                  }));*/
                },
                style: flatButtonStyle,
                /*shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red, width: 2),
                ),
                color: Colors.transparent,*/
                child: Text("borrar"),
                //textColor: Colors.red,
              ),
            ),
          ],
        ),
      ),

      //--BOTON FLOTANTE--//
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => scanQr(),
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }
}

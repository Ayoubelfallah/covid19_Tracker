import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:proj/pages/nextpage.dart';

class QRCODE extends StatelessWidget {
  Future<void> scanQR(BuildContext context) async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      String qrText = qrResult.rawContent ?? 'Aucune donnée scannée';
      // Une fois que le code QR est scanné, vous pouvez utiliser qrText comme vous le souhaitez.
      // Par exemple, vous pouvez naviguer vers une autre page avec les données scannées.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPage(data: qrText)),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        // L'utilisateur a refusé l'accès à la caméra.
        print('Permission refusée');
      } else {
        // Une erreur inattendue s'est produite.
        print('Erreur: $e');
      }
    } on FormatException {
      // L'utilisateur a appuyé sur le bouton retour avant de scanner quoi que ce soit.
      print('Vous avez annulé le scan');
    } catch (e) {
      // Une erreur inattendue s'est produite.
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner de code QR'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => scanQR(context),
          child: Text('Scanner'),
        ),
      ),
    );
  }
}

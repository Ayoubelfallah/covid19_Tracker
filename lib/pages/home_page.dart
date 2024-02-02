import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/auth.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:proj/pages/qrcode.dart';
import 'package:proj/pages/testreport.dart';
import 'package:proj/pages/trucking.dart'; // Importer FlutterUdid

class HomePage extends StatelessWidget { 
  HomePage({Key? key}): super(key: key);
  final User? user = Auth().currentUser;


Future<void> signOut() async {
  await Auth().signOut();
}



Widget _title(){
  return const Text('Firebase Auth');
}

// Widget _userUid(){
//   return Text(user?.email ?? 'User email');
// }
// Widget _userUid(){
//   String udid = 'Loading...'; // Assurez-vous de définir correctement _udid
//   return Text('UDID: $udid');
// }


// Déclaration de la méthode asynchrone pour récupérer l'UDID
Future<String> _getUDID() async {
  String udid = await FlutterUdid.udid;
  return udid;
}

// Utilisation de la méthode _getUDID dans _userUid
Widget _userUid(){
  return FutureBuilder<String>(
    future: _getUDID(), // Appel de la méthode _getUDID
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('UDID: Loading...'); // Afficher "Loading..." pendant le chargement
      } else {
        if (snapshot.hasData) {
          return Text('UDID: ${snapshot.data}'); // Afficher l'UDID récupéré
        } else {
          return Text('UDID: Error'); // Afficher "Error" en cas d'erreur de récupération
        }
      }
    },
  );
}


Widget _signOutButton(){
  return ElevatedButton(
    onPressed: signOut, 
    child: const Text('Sign Out'),
    );
}


@override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: _title(),
  ),
  body: Container(
    height: double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _userUid(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCODE()),
                );
              },
              child: const Text('Scan QR code'),
            ),
                  ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TRACKING()),
                );
              },
              child: const Text('Tracking'),
            ),
                  ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TESTREPORT()),
                );
              },
              child: const Text('Test report'),
            ),
                    _signOutButton(),

      ],
    ),
  ),
);
}
}
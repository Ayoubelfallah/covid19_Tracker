import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerNom = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  
  var signInWithEmailAndPassword;

  Future<void> sauvegarderUtilisateur(
      String nom, String email, String motDePasse) async {
    try {
      await FirebaseFirestore.instance.collection('utilisateurs').add({
        'nom': nom,
        'email': email,
        'motDePasse': motDePasse,
      });
    } catch (e) {
      print("Erreur lors de la sauvegarde de l'utilisateur: $e");
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await sauvegarderUtilisateur(
        _controllerNom.text,
        _controllerEmail.text,
        _controllerPassword.text,
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'No ? $errorMessage');
  }

    Widget _submitButton(){
      return ElevatedButton(
        onPressed: 
        isLogin ? signInWithEmailAndPassword: createUserWithEmailAndPassword,
        child: Text(isLogin ? 'login' : 'Register'),
        );
    }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
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
            _entryField('nom', _controllerNom),
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import'../auth.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}): super(key: key);
  
//   @override
//   State<LoginPage> createState() => _LoginPageState();


// }
// class _LoginPageState extends State<LoginPage> {

//   String? errorMessage = '';
//   bool isLogin = true;

//     final TextEditingController _controllerNom = TextEditingController();


//   final TextEditingController _controllerEmail = TextEditingController();

//   final TextEditingController _controllerPassword = TextEditingController();

// Future <void> signInWithEmailAndPassword() async{
//   try {
//     await Auth().signInWithEmailAndPassword(
//       email: _controllerEmail.text, 
//       password: _controllerPassword.text

      
//       );


//   } on FirebaseAuthException catch (e) {
//     setState(() {
      
//       errorMessage = e.message;
//     });
//   }
// }

// Future <void> createUserWithEmailAndPassword() async{
//   try {
//     await Auth().createUserWithEmailAndPassword(
//       nom: _controllerNom.text,
//       email: _controllerEmail.text, 
//       password: _controllerPassword.text
      
//       );


//   } on FirebaseAuthException catch (e) {
//     setState(() {
      
//       errorMessage = e.message;
//     });
//   }}

//    Widget _title(){
//     return const Text ('Firebase Auth');
//    }

//     Widget _entryField(
//       String title,
//       TextEditingController controller,
//     ){
//       return TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: title,
//         ),
//       );
//     }


//     Widget _errorMessage(){
//       return Text ( errorMessage == '' ? '' : 'No ? $errorMessage');

//     }
//     Widget _submitButton(){
//       return ElevatedButton(
//         onPressed: 
//         isLogin ? signInWithEmailAndPassword: createUserWithEmailAndPassword,
//         child: Text(isLogin ? 'login' : 'Register'),
//         );
//     }


//     Widget _loginOrRegisterButton() {
//       return TextButton(
//         onPressed: () {
//           setState(() {
//           isLogin = !isLogin;
//         });
//       },
//       child: Text(isLogin ? 'Register instead': 'Login instead'),
// ); // TextButton
// }



//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: _title(),
//       ), // AppBar
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _entryField('nom', _controllerNom),

//           _entryField('email', _controllerEmail),
//           _entryField('password', _controllerPassword),
//           _errorMessage(),
//           _submitButton(),
//           _loginOrRegisterButton(),
//           ], // <Widget>[]
//         ), // Column
//       ), // Container
//     ); // Scaffold
//   }
// }
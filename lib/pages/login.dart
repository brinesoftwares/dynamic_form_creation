// import 'package:flutter/material.dart';
// // import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_starter/pages/home.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class LoginPage extends StatefulWidget {
//   static String tag = 'login-page';
//   @override
//   _LoginPageState createState() => new _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final box = GetStorage();
//   bool loading = false;

//   @override
//   Widget build(BuildContext context) {
//     final logo = Hero(
//       tag: 'hero',
//       child: CircleAvatar(
//         backgroundColor: Colors.transparent,
//         radius: 48.0,
//         child: Image.asset('assets/images/app_icon/flutter.png'),
//       ),
//     );

//     final email = TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       autofocus: false,
//       initialValue: 'alucard@gmail.com',
//       decoration: InputDecoration(
//         hintText: 'Email',
//         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
//       ),
//     );

//     final password = TextFormField(
//       autofocus: false,
//       initialValue: 'some password',
//       obscureText: true,
//       decoration: InputDecoration(
//         hintText: 'Password',
//         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
//       ),
//     );

//     final loginButton = Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         onPressed: () {
//           setState(() {
//             loading = true;
//           });
//           login();
//         },
//         padding: EdgeInsets.all(12),
//         color: Colors.lightBlueAccent,
//         child: loading
//             ? SizedBox(
//                 height: 20,
//                 // child: SpinKitThreeBounce(
//                 //   color: Colors.white,
//                 //   size: 25.0,
//                 // ),
//               )
//             : Text('Log In', style: TextStyle(color: Colors.white)),
//       ),
//     );

//     final forgotLabel = FlatButton(
//       child: Text(
//         'Forgot password?',
//         style: TextStyle(color: Colors.black54),
//       ),
//       onPressed: () {},
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.only(left: 24.0, right: 24.0),
//           children: <Widget>[
//             logo,
//             SizedBox(height: 48.0),
//             email,
//             SizedBox(height: 15.0),
//             password,
//             SizedBox(height: 25.0),
//             loginButton,
//             forgotLabel
//           ],
//         ),
//       ),
//     );
//   }

//   void login() {
//     Future.delayed(const Duration(milliseconds: 3000), () {
//       box.write('login', true);
//       // Get.off(HomePage());
//       setState(() {
//         loading = false;
//       });
//     });
//   }
// }

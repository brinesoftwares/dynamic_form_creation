import 'package:flutter/material.dart';
import 'package:flutter_starter/create_dynamic_form.dart';
import 'package:flutter_starter/dynamic_form.dart';
import 'package:flutter_starter/imagepicker.dart';
// import 'package:flutter_starter/pages/intro.dart';
// import 'package:flutter_starter/pages/login.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

void main() async{
  // await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final box = GetStorage();

  // Widget goto(){
  //   if(box.hasData('intro')) {
  //     if(box.hasData('login')){
  //       return HomePage();
  //     }
  //     else{
  //       return LoginPage();
  //     }
  //   }
  //   else{
  //     return Intro();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Josefin",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:const CreateDynamicForm(),
      defaultTransition: Transition.rightToLeftWithFade,
    );
  }
}


class Fbcss extends StatelessWidget {
  const Fbcss({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
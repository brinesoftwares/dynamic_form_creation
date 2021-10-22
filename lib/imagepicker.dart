// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class MyHomePage extends StatefulWidget {
//   final String? title;

//   MyHomePage({this.title});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? imageFile;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("widget.title!"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       ListTile(
//                         leading: const Icon(Icons.photo),
//                         title: const Text('Gallery'),
//                         onTap: () {
//                           Navigator.pop(context);
//                           _pickImage(fromCamera: false);
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.music_note),
//                         title: const Text('Camera'),
//                         onTap: () {
//                           Navigator.pop(context);
//                           _pickImage(fromCamera: true);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Stack(
//               children: [
//                 Container(
//                   child: imageFile != null
//                       ? Image.file(imageFile!)
//                       : Image.asset("assets/images/no_img.png"),
//                 ),
//                 Positioned(
//                   right: 1,
//                   child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           imageFile = null;
//                         });
//                       },
//                       icon: const CircleAvatar(
//                           backgroundColor: Colors.black,
//                           radius: 14,
//                           child: Icon(
//                             Icons.clear_rounded,
//                             color: Colors.white,
//                             size: 18,
//                           ))),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future _pickImage({@required bool? fromCamera}) async {
//     XFile? image = await ImagePicker().pickImage(
//         source: fromCamera! ? ImageSource.camera : ImageSource.gallery);
//     if (image != null) {
//       _cropImage(image.path);
//     }
//   }

//   Future _cropImage(path) async {
//     File? croppedFile = await ImageCropper.cropImage(
//         sourcePath: path,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.2));
//     if (croppedFile != null) {
//       setState(() {
//         imageFile = croppedFile;
//       });
//     }
//   }
// }

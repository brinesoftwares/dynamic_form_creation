// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_starter/services/api_services/api.dart';
// import 'package:flutter_starter/widgets/custom_shimmer.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _loading = true;
//   final api = ApiServices();
//   List data = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     await api.post("test.php", {"user": "brine", "pass": "1234"}).then((value) {
//       print(value["data"]);
//       setState(() {
//         data = value["data"];
//         _loading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loading List'),
//       ),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             Expanded(
//                 child: _loading
//                     ? CustomShimmer()
//                     : ListView.builder(
//                         itemBuilder: (_, i) => Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: FadeIn(
//                             duration: Duration(seconds: 4),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 100.0,
//                                   height: 100.0,
//                                   color: Colors.red,
//                                 ),
//                                 const Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 8.0),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Container(
//                                         width: double.infinity,
//                                         height: 22.0,
//                                         color: Colors.white,
//                                         child: Text(data[i]["title"]),
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 2.0),
//                                       ),
//                                       Container(
//                                         width: double.infinity,
//                                         height: 60.0,
//                                         color: Colors.white,
//                                         child: Text(data[i]["content"]),
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 2.0),
//                                       ),
//                                       Container(
//                                         width: 120.0,
//                                         height: 22.0,
//                                         color: Colors.white,
//                                         child: Text(data[i]["date"]),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         itemCount: data.length,
//                       )),
//           ],
//         ),
//       ),
//     );
//   }
// }

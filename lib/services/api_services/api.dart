// import 'package:dio/dio.dart';

// class ApiServices {
//   Response? response;
//   Dio dio = new Dio();
//   final url = "http://testapi.inst.link/";

//   Future<Map> get(String _endPoint) async {
//     try {
//       response = await dio.get(url + _endPoint);
//       return response!.data;
//     } catch (e) {
//       return {"status":false,"message":"Server/URL error","data":[]};
//     }
//   }

//   Future<Map> post(String _endPoint, Map _data) async {
//     try {
//       response = await dio.post(url + _endPoint, data: _data);
//       return response!.data;
//     } catch (e) {
//       print(e);
//       return {"status":false,"message":"Server/URL error","data":[]};
//     }
//   }
// }

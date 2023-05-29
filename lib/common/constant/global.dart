import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
const String url="http://192.168.1.67:5000";
showsnackbar(BuildContext context,String message){
  ScaffoldMessenger.of(context)
  .showSnackBar(SnackBar(content: Text(message)));
}
const String userurl="https://res.cloudinary.com/dsqtxanz6/image/upload/v1682761190/zu41cdfdrp95xzvq9o6o.png";
 Future<http.Response> handleerror(
    {required http.Response res,
    required VoidCallback callback,
    required BuildContext context}) async {
  switch (res.statusCode) {
    case 200:
      callback();
      break;
    case 400:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
      hideLoading();
      break;
    case 500:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
      hideLoading();
      break;
    default:
      showsnackbar(context, jsonDecode(res.body)["mes"]);
      hideLoading();
  }
  return res;
}
  void showLoading([String? message]) {
    Get.dialog(
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Container(
                height: 100,
                alignment: Alignment.centerLeft,
                child:const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    
                  ),
                )
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                message ?? 'Please Wait',
                style: const TextStyle(fontSize: 16),
              )
            ]),
          ),
        ),
        barrierDismissible: false);
  }

  //hide loading
   void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

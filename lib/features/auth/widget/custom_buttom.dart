import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onclick;
  const CustomButton({super.key, required this.text, required this.onclick});

  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap:onclick,
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration:const BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Center(
                      child: Text(text,style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                  ),
                ),
              );
  }
}
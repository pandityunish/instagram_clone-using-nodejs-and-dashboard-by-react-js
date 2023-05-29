import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/color.dart';
import 'package:instagramclone/features/auth/widget/custom_buttom.dart';

import '../repository/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey=GlobalKey<FormState>();
  TextEditingController emailcontroller=TextEditingController();
    TextEditingController namecontroller=TextEditingController();

  TextEditingController passwordcontroller=TextEditingController();
  AuthRepository authRepository=Get.put(AuthRepository()); 
  @override
  void dispose() {
  emailcontroller.dispose();
  passwordcontroller.dispose();
  namecontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbgcolor,
        elevation: 0,
        centerTitle: true,
        title:const Text("Create an account",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        iconTheme:const IconThemeData(color: Colors.black),
      ),
      bottomSheet: Container(
        color: kbgcolor,
        height: 40,
        width: Get.width,
        child: TextButton(onPressed: () {
          Get.to(()=>const RegisterScreen());
        }, child:const Text("Already have an Account?")),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: Get.height*0.07,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: namecontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if( value!.isEmpty){
                        return "Please enter your Name";
                      }
                      return null;
                    },
                    decoration:const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4,color: Colors.black)
                      ),
                      
                    ),
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 8,).copyWith(bottom: 8),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if( value!.isEmpty){
                        return "Please enter your email";
                      }
                      return null;
                    },
                    decoration:const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4,color: Colors.black)
                      ),
                      
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,),
                child: Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if( value!.isEmpty){
                        return "Please enter your password";
                      }else if(value.length<8){
                        return "Your password must be greater than 8";
                      }
                      return null;
                    },
                    decoration:const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4,color: Colors.black)
                      ),
                      
                    ),
                  ),
                ),
              ),
           SizedBox(height: Get.height*0.05,),
             CustomButton(text: "Login", onclick: () {
               if(_formkey.currentState!.validate()){
                authRepository.createuser(context: context, 
                name: namecontroller.text.trim(), 
                email: emailcontroller.text.trim(),
                 password: passwordcontroller.text.trim());
               }
             },),
            
            ],
          ),
        ),
      )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/common/constant/color.dart';
import 'package:instagramclone/features/auth/repository/auth_repository.dart';
import 'package:instagramclone/features/auth/screens/register_screen.dart';
import 'package:instagramclone/features/auth/widget/custom_buttom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey=GlobalKey<FormState>();
  bool isloading=false;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  AuthRepository authRepository=Get.put(AuthRepository()); 
  @override
  void dispose() {
  emailcontroller.dispose();
  passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: kbgcolor,
        height: 40,
        width: Get.width,
        child: TextButton(onPressed: () {
          Get.to(()=>const RegisterScreen());
        }, child:const Text("Don't have an Account?")),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: Get.height*0.1,),
              Image.asset("assets/instagram.png",height: 80),
            const  SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
             const SizedBox(height: 30,),
             CustomButton(text:isloading==false? "Login":"Loading", onclick: () async{
               if(_formkey.currentState!.validate()){
                setState(() {
                  isloading=true;
                 
                });
                authRepository.loginuser(context: context,
                 email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
                 setState(() {
                  isloading=false;
                });
               }
             },),
             TextButton(onPressed: () {
               
             }, child:const Text("Forgot password?"))
            ],
          ),
        ),
      )),
    );
  }
}
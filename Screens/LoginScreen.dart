import 'package:bhs_vendor/Screens/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Assets/Login.png"),
                      fit: BoxFit.cover)),
              // child: Image.asset(
              //
              //   height: MediaQuery.of(context).size.height * 0.5,
              //   width: MediaQuery.of(context).size.width * 1,
              // ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Mobile Number',
                hintText: 'Enter Mobile Number',

              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              phoneController.text.length==10?
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(phoneController.text))):
                  Fluttertoast.showToast(msg: "Enter valid number");
            },
            child: Container(

              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10)
              ),
              height: 50,
              width: MediaQuery.of(context).size.width*0.9,
              child: Center(child: Text("Login / Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
            ),
          ),
          SizedBox(height: 20,),
          Text("By Clicking Continue, You Agree To Our Terms And Conditions",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}

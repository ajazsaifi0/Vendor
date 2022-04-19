import 'package:bhs_vendor/Constants.dart';
import 'package:bhs_vendor/Screens/Dashboard.dart';
import 'package:bhs_vendor/Screens/SignUp.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:bhs_vendor/Helper/HelperFunction.dart';
import '../Services/Api.dart';
class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  OTPScreen(this.phoneNumber);


  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? _enteredOTP;
  String? Message;
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
  var api=new Api();
  CheckUser() async{
    var RequestBody={
      "mobile_no":widget.phoneNumber.toString()
    };
    dynamic response= await api.ApiCallingWithRequestBody("/vendor/Check.php",RequestBody);
    if(response["message"]=="not-exist"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(widget.phoneNumber,Constants.State,Constants.Address)));
    }else{
      setState(() {
        Constants.Id=response["data"][0]["Id"];
        Constants.name=response["data"][0]["name"];
        Constants.Specialization=response["data"][0]["specialization"];
        Constants.State=response["data"][0]["state"];
        Constants.Address=response["data"][0]["address"];
        Constants.aadhar_no=response["data"][0]["aadhar_no"];
        Constants.aadhar_front=response["data"][0]["aadhar_front"];
        Constants.aadhar_back=response["data"][0]["aadhar_back"];
        Constants.pan_front=response["data"][0]["pan_front"];
        Constants.pan_back=response["data"][0]["pan_back"];
        Constants.mobile_no=response["data"][0]["mobile_no"];
        Constants.pan_no=response["data"][0]["pan_no"];
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(widget.phoneNumber.toString())));
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: "+91"+widget.phoneNumber.toString(),
        timeOutDuration: const Duration(seconds: 60),
        onLoginSuccess: (userCredential, autoVerified) async {
          // _showSnackBar(
          //   context,
          //   'Phone number verified successfully!',
          // );
          //getEmailAndPassword();

          debugPrint(
            autoVerified
                ? "OTP was fetched automatically"
                : "OTP was verified manually",
          );

          CheckUser();

          debugPrint("Login Success UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException) {
          _showSnackBar(
            context,
            'Something went wrong (${authException.message})',
          );

          debugPrint(authException.message);
          // handle error further if needed
        },
        builder: (context, controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: const Text("Verify Phone Number"),
              actions: [
                if (controller.codeSent)
                  TextButton(
                    child: Text(
                      controller.timerIsActive
                          ? "${controller.timerCount.inSeconds}s"
                          : "RESEND",
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: controller.timerIsActive
                        ? null
                        : () async => await controller.sendOTP(),
                  ),
                const SizedBox(width: 5),
              ],
            ),
            body: controller.codeSent
                ? ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "We've sent an SMS with a verification code to "+ widget.phoneNumber.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: controller.timerIsActive ? null : 0,
                  child: Column(
                    children: const [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 50),
                      Text(
                        "Listening for OTP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Divider(),
                      Text("OR", textAlign: TextAlign.center),
                      Divider(),
                    ],
                  ),
                ),
                const Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  onChanged: (String v) async {
                    _enteredOTP = v;
                    if (_enteredOTP?.length == 6) {
                      final isValidOTP = await controller.verifyOTP(
                        otp: _enteredOTP!,
                      );
                      // Incorrect OTP
                      if (!isValidOTP) {
                        _showSnackBar(
                          context,
                          "Please enter the correct OTP sent to "+widget.phoneNumber.toString(),
                        );
                      }else{
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                      }
                    }
                  },
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator.adaptive(),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    "Sending OTP",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

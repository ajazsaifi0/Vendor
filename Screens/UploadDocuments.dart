import 'dart:convert';
import 'dart:io';
import 'package:bhs_vendor/Constants.dart';
import 'package:bhs_vendor/Screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bhs_vendor/Helper/HelperFunction.dart';
import '../Services/Api.dart';
class UploadDocuments extends StatefulWidget {
  final String? Name;
  final String? phoneNumber;
  final String? Specialization;
  final String? State;
  final String? Address;
  UploadDocuments(this.Name,this.phoneNumber,this.Specialization,this.State,this.Address);

  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  TextEditingController adhaarController=new TextEditingController();
  TextEditingController panNumber=new TextEditingController();
  File? PanFront;
  File? PanBack;
  File? AdharFront;
  File? AdharBack;
  String? BasePanF;
  String? BasePanB;
  String? BaseAdharF;
  String? BaseAdharB;
  var api=new Api();
  bool _isloading=false;
  //get pan front
  _getPanFFromGallery() async {
    PickedFile? PanF = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) ;
    if (PanF != null) {
    setState(() {
    PanFront=File(PanF.path);
    BasePanF = base64Encode(PanFront!.readAsBytesSync());
    });

    }else{
      Fluttertoast.showToast(msg: "No Image Selected");
    }
  }
  //get pan back
  _getPanBFromGallery() async {
    PickedFile? PanB = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) ;
    if (PanB != null) {
      setState(() {
        PanBack=File(PanB.path);
        BasePanB = base64Encode(PanBack!.readAsBytesSync());
      });
    }else{
      Fluttertoast.showToast(msg: "No Image Selected");
    }
  }
  //get front adhar
  _getAdharFFromGallery() async {
    PickedFile? AdharF = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) ;
    if (AdharF != null) {
      setState(() {
        AdharFront=File(AdharF.path);
        BaseAdharF = base64Encode(AdharFront!.readAsBytesSync());
      });
    }else{
      Fluttertoast.showToast(msg: "No Image Selected");
    }
  }
  //get back adhar
  _getAdharBFromGallery() async {
    PickedFile? AdharB = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) ;
    if (AdharB != null) {
      setState(() {
        AdharBack=File(AdharB.path);
        BaseAdharB = base64Encode(AdharBack!.readAsBytesSync());
      });
    }else{
      Fluttertoast.showToast(msg: "No Image Selected");
    }
  }
  //upload all of the data
  UploadData() async{
    var requestBody={
      "name":widget.Name,
      "mobile_no":widget.phoneNumber.toString(),
      "state":widget.State,
      "specialization":widget.Specialization,
      "address":widget.Address,
      "aadhar_no":adhaarController.text,
      "pan_no":panNumber.text,
      "user_image":BaseAdharF,
      "user_image2":BaseAdharB,
      "user_image3":BasePanF,
      "user_image4":BasePanB
    };
    dynamic response= await api.ApiCallingWithRequestBody("/vendor/upload.php", requestBody);
    if(response["MESSAGE"]=="UPLOAD SUCEED"){
      getdata();

    }else{
      Fluttertoast.showToast(msg: response["MESSAGE"]);
    }
  }
  // storeDataInSp()async{
  //   await sf.saveUserLoggedInState(true);
  //   await sf.saveMobileNumberInSharedPrefrence("+91"+widget.phoneNumber.toString());
  // }
  //getting the user data
  getdata() async{
    var requestBody={
      "mobile_no":widget.phoneNumber.toString()
    };
    dynamic response= await api.ApiCallingWithRequestBody("/vendor/Check.php", requestBody);
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
   // storeDataInSp();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(widget.phoneNumber.toString())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading==false?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height:MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo,
                child: Center(child: Text("Verify yourself!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:180),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                          child: Row(
                            children: [
                              Text("Pan Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: panNumber,
                            decoration: InputDecoration(
                                hintText: 'Pan Number',
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onChanged: (value) {
                              // do something
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PanFront==null?Icon(Icons.add):
                                        Container(),
                                    PanFront==null? Text("Upload Front Photo PAN",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.center,):
                                    Image.file(File(PanFront!.path),height: 120,width: 120,)
                                  ],
                                ),
                              ),
                              onTap: (){
                                _getPanFFromGallery();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  PanBack==null?Icon(Icons.add):
                                        Container(),
                                    PanBack==null? Text("Upload Back Photo PAN",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.center,):
                                    Image.file(File(PanBack!.path),height: 120,width: 120,)
                                  ],
                                ),
                              ),
                              onTap: (){
                                _getPanBFromGallery();
                              },
                            )

                          ],
                        ),


                        //  Permanent Address
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                          child: Row(
                            children: [
                              Text("Aadhar Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: adhaarController,
                            decoration: InputDecoration(
                                hintText: 'Aadhar Number',
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onChanged: (value) {
                              // do something
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AdharFront==null?Icon(Icons.add):
                                    Container(),
                                    AdharFront==null? Text("Upload Front Photo of Adhar",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.center,):
                                    Image.file(File(AdharFront!.path),height: 120,width: 120,)
                                  ],
                                ),
                              ),
                              onTap: (){
                                _getAdharFFromGallery();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AdharBack==null?Icon(Icons.add):
                                    Container(),
                                    AdharBack==null? Text("Upload Front Photo of Adhar",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.center,):
                                    Image.file(File(AdharBack!.path),height: 120,width: 120,)
                                  ],
                                ),
                              ),
                              onTap: (){
                                _getAdharBFromGallery();
                              },
                            )

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            if(panNumber.text!=""&&adhaarController.text!=""&&
                            BaseAdharF!=null&&BaseAdharB!=null&&BasePanF!=null&&BasePanB!=null) {
                              debugPrint(BaseAdharF);
                              setState(() {
                                _isloading = true;
                              });
                              UploadData();
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                            }else{
                              Fluttertoast.showToast(msg: "All fields are mandatory to fill");
                            }
                          },
                          child: Container(

                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Center(child: Text("CONTINUE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ):Center(child: CircularProgressIndicator(color: Colors.blue,))
    );
  }
}

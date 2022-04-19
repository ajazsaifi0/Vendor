import 'package:bhs_vendor/Constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MyDocuments extends StatefulWidget {
  const MyDocuments({Key? key}) : super(key: key);

  @override
  _MyDocumentsState createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  TextEditingController panNumber=new TextEditingController();
  TextEditingController adhaarController=new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      panNumber.text=Constants.pan_no;
      adhaarController.text=Constants.aadhar_no;
    });
    print(Constants.pan_front);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:30),
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
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
                                Image.network("https://bengalhomeservices.com/vendor/images/"+Constants.pan_front)
                              ],
                            ),
                          ),
                          onTap: (){
                           // _getPanFFromGallery();
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
                                Image.network("https://bengalhomeservices.com/vendor/images/"+Constants.pan_back)

                              ],
                            ),
                          ),
                          onTap: (){
                           // _getPanBFromGallery();
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
                                Image.network("https://bengalhomeservices.com/vendor/images/"+Constants.aadhar_front)

                              ],
                            ),
                          ),
                          onTap: (){
                          //  _getAdharFFromGallery();
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
                               Image.network("https://bengalhomeservices.com/vendor/images/"+Constants.aadhar_back)
                              ],
                            ),
                          ),
                          onTap: (){
                            //_getAdharBFromGallery();
                          },
                        )

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

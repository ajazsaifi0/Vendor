import 'package:bhs_vendor/Constants.dart';
import 'package:bhs_vendor/Screens/UploadDocuments.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUp extends StatefulWidget {
String? phoneNumber;
String? State;
String? Address;
SignUp(this.phoneNumber,this.State,this.Address);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController SpecializationController = new TextEditingController();
  TextEditingController StateController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  String? _currentSelectedValue;
  var _Categories = [
    "Air Conditioner",
    "Refrigerator",
    "Wachine Machine",
    "Microwave",
    "Geyser",
    "Chimney",
    "Television",
    "Water Purifier",
    "Desktop/Laptop",
    "Lift/Elevator Repair"
  ];
@override
  void initState() {
    // TODO: implement initState
  setState(() {
    StateController.text=widget.State.toString();
    addressController.text=widget.Address.toString();

  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Stack(
          children: [
            Container(
              height:MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              color: Colors.indigo,
              child: Center(child: Text("Tell us about yourself!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
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
                            Text("What is your Name?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onChanged: (value) {
                            // do something
                          },
                        ),
                      ),
                      //Specialization
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                        child: Row(
                          children: [
                            Text("What is your Specialization?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                // labelStyle: textStyle,
                                  errorStyle:
                                  TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Please select expense',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0))),
                              isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _Categories.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: TextField(
                      //     controller: SpecializationController,
                      //     decoration: InputDecoration(
                      //         hintText: 'Specialization',
                      //         contentPadding: const EdgeInsets.all(15),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(30))),
                      //     onChanged: (value) {
                      //       // do something
                      //     },
                      //   ),
                      // ),
                    //  state
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                        child: Row(
                          children: [
                            Text("Where do you live?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: StateController,
                          decoration: InputDecoration(
                              hintText: 'State',
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onChanged: (value) {
                            setState(() {
                              Constants.State=StateController.text;
                            });
                          },
                        ),
                      ),
                    //  Permanent Address
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                        child: Row(
                          children: [
                            Text("Whats your permanent address?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                              hintText: 'Address',
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onChanged: (value) {
                            setState(() {
                              Constants.Address=addressController.text;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (nameController.text != "" &&
                              _currentSelectedValue != null &&
                              StateController.text != "" &&
                              addressController.text != "") {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    UploadDocuments(
                                        nameController.text, widget.phoneNumber,
                                        SpecializationController.text,
                                        Constants.State, Constants.Address)));
                          }else{
                            Fluttertoast.showToast(msg: "all fields are mandatory to fill");
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
      ),
    );
  }
}

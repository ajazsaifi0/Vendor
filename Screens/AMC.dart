
import 'package:bhs_vendor/Constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AMC extends StatefulWidget {
  const AMC({Key? key}) : super(key: key);

  @override
  _AMCState createState() => _AMCState();
}

class _AMCState extends State<AMC> {
  String? num1;
  TextEditingController Cust_NameController = new TextEditingController();
  TextEditingController Phone_NumberController = new TextEditingController();
  TextEditingController Email_AddressController = new TextEditingController();
  TextEditingController Address_Controller = new TextEditingController();
  TextEditingController City_Controller = new TextEditingController();
  TextEditingController Pin_Controller = new TextEditingController();
  TextEditingController NoofDevice_Controller = new TextEditingController();
  TextEditingController Capacity_Controller = new TextEditingController();
  TextEditingController Tenure_Controller = new TextEditingController();
  TextEditingController Model_Controller = new TextEditingController();
  TextEditingController Purchase_Controller = new TextEditingController();
  TextEditingController Price_Controller = new TextEditingController();

  String? _currentSelectedValue;
  var _currencies = [
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
 // late Razorpay _razorpay;
 //  void handlePaymentSuccess() {
 //    Navigator.push(
 //        context, MaterialPageRoute(builder: (context) => PaymentSucessful()));
 //  }
 //
 //  void handlePaymentError() {
 //    Fluttertoast.showToast(msg: "Something Goes Wrong");
 //  }
 //
 //  void handleExternalWallet() {
 //    Fluttertoast.showToast(msg: "Something Goes Wrong");
 //  }
 //
 //  void openCheckout() {
 //    var options = {
 //      "key": "rzp_test_bwIcLIC1EVQXtp",
 //      "amount": 1197 * 100,
 //      "name": "BHS",
 //      "description": "Pay Securely for your services",
 //      "prefill": {"contact": "123456789", "email": 'test@razorpay.com'},
 //      "external": {
 //        "wallets": ["paytm"]
 //      }
 //    };
 //    try {
 //      _razorpay.open(options);
 //    } catch (e) {
 //      print(e.toString());
 //    }
 //  }

  void UploadData() async {
    String url =
        "https://bengal-home-services-default-rtdb.firebaseio.com/BookingsRequested.json";
    var requestbody = {
      "AMC DATA FOR $num": {
        "Cust_name": Cust_NameController.text,
        "phone_number": Phone_NumberController.text,
        "Email_Address": Email_AddressController.text,
        "City": City_Controller.text,
        "Pin_Code": Pin_Controller.text,
        "Product_Details": {
          "Device_Type": _currentSelectedValue,
          "No_of_Devices": NoofDevice_Controller.text,
          "Capacity": Capacity_Controller.text,
          "Tenure": Tenure_Controller.text,
          "Model/Serial_No": Model_Controller.text,
          "Purchase_Year": Purchase_Controller.text,
          "Price": Price_Controller.text
        }
      }
    };
    var response = await http.post(Uri.parse(url), body: requestbody);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Details has been Saved Please make Payment");
     // openCheckout();
    } else {
      Fluttertoast.showToast(msg: "Something Goes Wrong");
    }
  }

  // getMyNum() async {
  //   String? mynum = await HelperFunctions.getUserNameFromSharedPrefrence();
  //   setState(() {
  //     num1 = mynum;
  //
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
   // getMyNum;
    setState(() {
      Tenure_Controller.text="1 year";
      Price_Controller.text = "1197";
      num1=Constants.mobile_no;
    });
    // _razorpay = new Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("AMC Form")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CUSTOMER DETAILS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Cust_NameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Phone_NumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'phone Number',
                  hintText: 'Enter Your phone Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Email_AddressController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                  hintText: 'Enter Your Email Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Address_Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: City_Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                  hintText: 'Enter Your City',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Pin_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pin Code',
                  hintText: 'Enter Your Pincode',
                ),
              ),
            ),
            Text(
              "PRODUCT DETAILS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        // labelStyle: textStyle,
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
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
                        items: _currencies.map((String value) {
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: NoofDevice_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No. of Device',
                  hintText: 'Enter No. of Device',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Capacity_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Capacity',
                  hintText: 'Enter Capacity',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                enabled: false,
                controller: Tenure_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tenure',
                  hintText: 'Enter Tenure',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Model_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Model/Serial No',
                  hintText: 'Enter Model/Serial No',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Purchase_Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Purchase Year',
                  hintText: 'Enter Purchase Year',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: TextField(
                controller: Price_Controller,
                enabled: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                  hintText: 'price',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  UploadData();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}

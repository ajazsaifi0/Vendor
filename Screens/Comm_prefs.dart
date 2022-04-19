
import 'package:bhs_vendor/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comm_Prefs extends StatefulWidget {
  @override
  _Comm_PrefsState createState() => _Comm_PrefsState();
}

class _Comm_PrefsState extends State<Comm_Prefs> {
  bool _loading = false;
  //String _chosenNumber=Constants.MobileNum;
  //List<String> _dropdownItems = <String>[Constants.MobileNum,];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late String? myNum;
  late String _errorText;
  bool SMSPER = true;
  bool WHATSAPPPER = true;
  bool PrePurchaseUpdatesOnSMS = true;
  bool PrePurchaseUpdatesOnWhatsapp = true;
  bool PrePurchaseUpdatesOnCall = true;
  bool NewsUpdateOnSMS = true;
  bool NewsUpdateOnWhatsapp = true;
  bool NewsUpdateOnCall = true;
  bool Unsubscribe = false;
  @override
  void initState() {
    // TODO: implement initState
  setState(() {
    myNum=Constants.mobile_no;
  });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _loading
          ? Center(
              child: Container(
                color: Colors.black,
                height: 50.0,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
              child: Container(
                // color: Color(0xffe6f0ff),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white60,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xfff0f5ff)),
                                child: Center(
                                  child: Icon(Icons.arrow_back_ios_rounded),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Communication preferences",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 800,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffe6f0ff),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "Select Communication Preferences for ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text:Constants.mobile_no,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: " ✔",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 18)),
                                TextSpan(
                                    text: " (Uncheck the Boxes To Unsubscribe)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Policy Updates ----",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Policy Updates: Important Updates for your purchased policies including payment,issuance,claims and renewal reminders.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: SMSPER,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    SMSPER = value!;
                                                    if (SMSPER == true) {
                                                      Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("SMS")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this.WHATSAPPPER,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.WHATSAPPPER = value!;
                                                    if (this.WHATSAPPPER ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("Whatsapp")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 12),
                                                child: Icon(
                                                  Icons.lock,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Call",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Pre Purchase Updates ----",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Information on products you have shown an interest in including Quotes,Brochures,Illustrations.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this
                                                    .PrePurchaseUpdatesOnSMS,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.PrePurchaseUpdatesOnSMS =
                                                        value!;
                                                    if (this.PrePurchaseUpdatesOnSMS ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("SMS")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this
                                                    .PrePurchaseUpdatesOnWhatsapp,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.PrePurchaseUpdatesOnWhatsapp =
                                                        value!;
                                                    if (this.PrePurchaseUpdatesOnWhatsapp ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("Whatsapp")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this
                                                    .PrePurchaseUpdatesOnCall,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.PrePurchaseUpdatesOnCall =
                                                        value!;
                                                    if (this.PrePurchaseUpdatesOnCall ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Call",
                                                style: TextStyle(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "News & Offers ----",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "News,Promos and events for you",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this.NewsUpdateOnSMS,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.NewsUpdateOnSMS =
                                                        value!;
                                                    if (this.NewsUpdateOnSMS ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("SMS")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value:
                                                    this.NewsUpdateOnWhatsapp,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.NewsUpdateOnWhatsapp =
                                                        value!;
                                                    if (this.NewsUpdateOnWhatsapp ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text("Whatsapp")],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: this.NewsUpdateOnCall,
                                                activeColor: Colors.blue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    this.NewsUpdateOnCall =
                                                        value!;
                                                    if (this.NewsUpdateOnCall ==
                                                        true) {
                                                      this.Unsubscribe = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Call",
                                                style: TextStyle(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: this.Unsubscribe,
                          activeColor: Colors.blue,
                          onChanged: (bool? value) {
                            setState(() {
                              this.Unsubscribe = value!;
                              if (this.Unsubscribe == true) {
                                this.NewsUpdateOnSMS = false;
                                this.NewsUpdateOnWhatsapp = false;
                                this.NewsUpdateOnCall = false;
                                this.PrePurchaseUpdatesOnCall = false;
                                this.PrePurchaseUpdatesOnWhatsapp = false;
                                this.PrePurchaseUpdatesOnSMS = false;
                                this.SMSPER = false;
                                this.WHATSAPPPER = false;
                              } else {
                                this.NewsUpdateOnSMS = true;
                                this.NewsUpdateOnWhatsapp = true;
                                this.NewsUpdateOnCall = true;
                                this.PrePurchaseUpdatesOnCall = true;
                                this.PrePurchaseUpdatesOnWhatsapp = true;
                                this.PrePurchaseUpdatesOnSMS = true;
                                this.SMSPER = true;
                                this.WHATSAPPPER = true;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Unsubscribe from all",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        "However, if you've purchased a policy from us, we will still Email/Call to update you about your policy",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Text(
                          "Disclaimer: The information displayed on My Account is only for information sake and are updates to the customer as received from the insurer and Policybazaar shall not be liable and/or responsible for the accuracy, completeness, legality, or reliability of the information contained in this My Account section. BHS Insurance Brokers Private Limited (formerly known as BHS Insurance Web Aggregator Private Limited)"),
                    )
                  ],
                ),
              ),
            )),
    );
  }
}

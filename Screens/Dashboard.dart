import 'package:bhs_vendor/Helper/HelperFunction.dart';
import 'package:bhs_vendor/Constants.dart';
import 'package:bhs_vendor/Screens/CancelledBookingDetails.dart';
import 'package:bhs_vendor/Screens/DetailScreen.dart';
import 'package:bhs_vendor/Screens/MyDocuments.dart';
import 'package:bhs_vendor/Screens/ProfileDetailScreen.dart';
import 'package:bhs_vendor/Services/Api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AMC.dart';
import 'AboutUs.dart';
import 'Comm_prefs.dart';
import 'Privacypolicy.dart';
import 'TermsandConditon.dart';
class Dashboard extends StatefulWidget {
 String? phoneNumber;
 Dashboard(this.phoneNumber);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> Categories=["ALL","CURRENT","COMPLETE","CANCELLED"];
  int Selected_index=0;
  int Selected_index2=0;
  var api=new Api();
  List<String> profileCards = [
    "My Personal Details",
    "Download User Application",
    "My Orders",
    "My Documents",
    //"Manage Address",
    //"Schedule Booking",
    "Refer & Earn",
    //"Download Invoice",
    //"My Wallet",
    //"Payment Options",
    "Share BHS",
    "Whatsapp Us",
    "AMC",
    "Communication preferences",
    //"Plus Membership",
    "Privacy Policy",
    "Rate us",
  ];
  List<IconData> profileCardsLeading = [
    Icons.info,
    Icons.person,
    Icons.info,
    Icons.description,
    Icons.description,
    //Icons.info,
   // Icons.rate_review,
    Icons.account_balance_wallet,
   // Icons.description,
   // Icons.account_balance_wallet,
   // Icons.eleven_mp,
    Icons.alarm_on_sharp,
    Icons.description,
    Icons.phonelink_ring,
   // Icons.person,
    Icons.info,
    Icons.rate_review,
  ];
  List<String> name=[];
  List<String> service=[];
  List<String> service_type=[];
  List<String> u_remark=[];
  List<String> v_remark=[];
  List<String> location=[];
  List<String> slot=[];
  List<String> date=[];
  List<String> payment_method=[];
  List<String> price=[];
  List<String> status=[];
  List<String> plus_member=[];
  List<String> vendor_id=[];
  List<String> mobile_no=[];
  List<String> quantity=[];
  List<String> Job_Id=[];
  List<String> user_Id=[];
  getdata() async{
    storeDataInSp();
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
  getJobData();
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
  }
  storeDataInSp()async{
    await sf.saveUserLoggedInState(true);
    await sf.saveMobileNumberInSharedPrefrence(widget.phoneNumber.toString());
  }
  //get job data
  getJobData()async{
    var requestBody={
      "service":Constants.Specialization,
    };
    dynamic res=await api.ApiCallingWithRequestBody("/common/booking_data.php", requestBody);
    if(res["message"]=="exist"){
      for(int i=0;i<res["data"].length;i++){
        setState(() {
          Job_Id.add(res["data"][i]["Id"]);
          name.add(res["data"][i]["name"]);
          service.add(res["data"][i]["service"]);
          service_type.add(res["data"][i]["service_type"]);
          u_remark.add(res["data"][i]["u_remark"]);
          v_remark.add(res["data"][i]["v_remark"]);
          location.add(res["data"][i]["location"]);
          slot.add(res["data"][i]["slot"]);
          date.add(res["data"][i]["date"]);
          payment_method.add(res["data"][i]["payment_method"]);
          price.add(res["data"][i]["price"]);
          status.add(res["data"][i]["status"]);
          plus_member.add(res["data"][i]["plus_member"]);
          vendor_id.add(res["data"][i]["vendor_id"]);
          mobile_no.add(res["data"][i]["mobile_no"]);
          quantity.add(res["data"][i]["quantity"]);
          user_Id.add(res["data"][i]["user_id"]);
        });
        print(name[i]);

      }
    }else{
      Fluttertoast.showToast(msg: "No Bookings");
    }
  }
  //Accept Booking
  AcceptBooking(int i,String v_remark) async{
    var RequestBody={
      "v_remark":v_remark,
      "vendor_id":Constants.Id,
      "Id":Job_Id[i]
    };
    dynamic res=await api.ApiCallingWithRequestBody("/vendor/accept.php", RequestBody);
    if(res["MESSAGE"]=="UPLOAD SUCEED"){
      print("job uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(Constants.mobile_no)));

    }else{
      Fluttertoast.showToast(msg: res["MESSAGE"]);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  int initialIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Selected_index==0?Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Container(
              height: 80,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dashboard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                    Icon(Icons.notifications,color: Colors.white,)
                  ],
                ),
              ),
            ),
              // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
              ToggleSwitch(
                minHeight: 50,
                minWidth: 120,
                initialLabelIndex: Selected_index2,
                changeOnTap: true,
                totalSwitches: 4,
                labels: ["ALL","CURRENT","COMPLETE","CANCELLED"],
                onToggle: (index) {
                  setState(() {

                    Selected_index2=index!;
                    print(Selected_index2);
                  });
                },
              ),
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: Categories.length, itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           //Selected_index=index+1;
          //         });
          //       },
          //       child: Card(
          //         elevation: 5,
          //         child: Container(
          //           height: 30,
          //           width: 100,
          //           //width: MediaQuery.of(context).size.width * 0.6,
          //           child: Center(child: Text(Categories[index].toUpperCase(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700),)),
          //
          //         ),
          //       ),
          //     );
          //   }),
          // ),
              name!=[]&&Selected_index2==0?
              //For All Jobs
              Container(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: name.length, itemBuilder: (context, index) {
                      return v_remark[index]!="Accepted"&&v_remark[index]!="Completed"&&u_remark[index]!="Cancelled"? GestureDetector(
                        onTap: (){
                          setState(() {
                            //Selected_index=index+1;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                name[index],service[index],service_type[index],u_remark[index],
                                v_remark[index],location[index],slot[index],date[index],payment_method[index],
                                price[index],status[index],plus_member[index],vendor_id[index],mobile_no[index],
                                quantity[index],Job_Id[index],user_Id[index]
                            )));
                          });
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 160,
                            width: 100,
                            //width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(name[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today_rounded,color: Colors.grey,size: 20,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(slot[index]+"\n        "+date[index].substring(0,11),style: TextStyle(color: Colors.grey),)

                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Service Type",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Text(service_type[index].substring(0,service_type[index].length-6))
                                      ],
                                    ),
                                    ElevatedButton(onPressed: (){
                                        AcceptBooking(index,"Accepted");
                                    }, child: Text("Accept")),
                                    //ElevatedButton(onPressed: (){}, child: Text("Reject")),
                                  ],
                                )
                              ],
                            ),

                          ),
                        ),
                      ):Container();
                    }),
                  ],
                ),
              ):
              name!=[]&&Selected_index2==1?
              Container(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: name.length, itemBuilder: (context, index) {
                      return v_remark[index]=="Accepted"&&vendor_id[index]==Constants.Id? GestureDetector(
                        onTap: (){
                          setState(() {
                            //Selected_index=index+1;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                name[index],service[index],service_type[index],u_remark[index],
                                v_remark[index],location[index],slot[index],date[index],payment_method[index],
                                price[index],status[index],plus_member[index],vendor_id[index],mobile_no[index],
                                quantity[index],Job_Id[index],user_Id[index]
                            )));
                          });
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 160,
                            width: 100,
                            //width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(name[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today_rounded,color: Colors.grey,size: 20,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(slot[index]+"\n        "+date[index].substring(0,11),style: TextStyle(color: Colors.grey),)

                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Service Type",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Text(service_type[index].substring(0,service_type[index].length-6))
                                      ],
                                    ),
                                    //ElevatedButton(onPressed: (){}, child: Text("Reject")),
                                    Text(v_remark[index],style: TextStyle(color: Colors.red,fontSize: 18),)
                                  ],
                                )
                              ],
                            ),

                          ),
                        ),
                      ):Container();
                    }),
                  ],
                ),
              ):
              name!=[]&&Selected_index2==2?
              Container(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: name.length, itemBuilder: (context, index) {
                      return v_remark[index]=="Completed"&&vendor_id[index]==Constants.Id? GestureDetector(
                        onTap: (){
                          setState(() {
                            //Selected_index=index+1;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                name[index],service[index],service_type[index],u_remark[index],
                                v_remark[index],location[index],slot[index],date[index],payment_method[index],
                                price[index],status[index],plus_member[index],vendor_id[index],mobile_no[index],
                                quantity[index],Job_Id[index],user_Id[index]
                            )));
                          });
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 160,
                            width: 100,
                            //width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(name[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today_rounded,color: Colors.grey,size: 20,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(slot[index]+"\n        "+date[index].substring(0,11),style: TextStyle(color: Colors.grey),)

                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Service Type",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Text(service_type[index].substring(0,service_type[index].length-6))
                                      ],
                                    ),
                                    //ElevatedButton(onPressed: (){}, child: Text("Reject")),
                                    Text(v_remark[index],style: TextStyle(color: Colors.red,fontSize: 18),)
                                  ],
                                )
                              ],
                            ),

                          ),
                        ),
                      ):Container();
                    }),
                  ],
                ),
              ):
              Selected_index2==3?CancelledBooking()
              :Center(child: CircularProgressIndicator(color: Colors.blue,))


            ],
          ):Selected_index==1?Column(
            children: [
              Container(
                height: 80,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Notifications",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                      Icon(Icons.notifications,color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.local_offer,color: Colors.indigo,),
                      Column(
                        children: [
                          Text("Summer Offer Get Upto 30% on your next booking \noffer code #19023444",textAlign: TextAlign.center,)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ):Column(
            children: [

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       widget.username.toUpperCase(),
              //       style: TextStyle(
              //           color: Colors.blueAccent,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w600,
              //           fontFamily: "AkayaKanadaka"),
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //widget.phoneNumber!,
                      Constants.mobile_no,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "AkayaKanadaka"),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 1,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profileCards.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(
                            profileCardsLeading[i],
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Text(
                            profileCards[i],
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (profileCards[i].contains("Personal")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileDetailScreen()));
                        } else if (profileCards[i].contains("Whatsapp Us")) {
                          await launch("https://web.whatsapp.com/");
                        } else if (profileCards[i].contains("Share BHS") ||
                            profileCards[i].contains("Rate us") ||
                            profileCards[i].contains("Refer") ||
                            profileCards[i].contains("Vendors")) {
                           await launch(
                               "https://play.google.com/store/apps/details?id=com.kiloo.subwaysurf&hl=en_US&gl=US");
                        } else if (profileCards[i].contains("Plus Membership")) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PlusMember()));
                        } else if (profileCards[i].contains("Privacy Policy")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()));
                        } else if (profileCards[i]
                            .contains("About Bengal Home Services")) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AboutUs()));
                        } else if (profileCards[i]
                            .contains("Terms and Conditions")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsandCondition()));
                        } else if (profileCards[i].contains("Communication")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Comm_Prefs()));
                        } else if (profileCards[i].contains("Manage")) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => UpdateAddress()));
                        } else if (profileCards[i].contains("My Orders") ||
                            profileCards[i].contains("Booking")) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(Constants.mobile_no)));
                        } else if (profileCards[i].contains("AMC")) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AMC()));
                        } else if (profileCards[i].contains("Documents")) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyDocuments()));
                        }else {
                          Fluttertoast.showToast(msg: "Coming Soon");
                        }
                        // else if (profileCards[i].contains("Reminders")) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => Reminders()));
                        // } else if (profileCards[i].contains("Communication")) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => Comm_Prefs()));
                        // }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.black,),
                label: 'Home',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications,color: Colors.black,),
                label: 'Search',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black,),
              label: 'Account',
                backgroundColor: Colors.white
            ),
          ],
          type: BottomNavigationBarType.fixed,
         currentIndex: Selected_index,
          selectedItemColor: Colors.indigo,
          showUnselectedLabels: true,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      Selected_index = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants.dart';
import '../Services/Api.dart';
import 'Dashboard.dart';
class DetailScreen extends StatefulWidget {
  String? name;
  String? service;
  String? service_type;
  String? u_remark;
  String? v_remark;
  String? location;
  String? slot;
  String? date;
  String? payment_method;
  String? price;
  String? status;
  String? plus_member;
  String? vendor_id;
  String? mobile_no;
  String? quantity;
  String? Id;
  String? user_id;
  DetailScreen(this.name,this.service,this.service_type,this.u_remark,this.v_remark,this.location,
      this.slot,this.date,this.payment_method,this.price,this.status,this.plus_member,this.vendor_id,
      this.mobile_no,this.quantity,this.Id,this.user_id);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  var api=new Api();
  AcceptBooking(String v_remark) async{
    var RequestBody={
      "v_remark":v_remark,
      "vendor_id":Constants.Id,
      "Id":widget.Id
    };
    dynamic res=await api.ApiCallingWithRequestBody("/vendor/accept.php", RequestBody);
    if(res["MESSAGE"]=="UPLOAD SUCEED"){
      print("job uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(Constants.mobile_no)));

    }else{
      Fluttertoast.showToast(msg: res["MESSAGE"]);
    }
  }
  CancelBooking() async{
    var RequestBody={
      "v_remark":"",
      "vendor_id":"1",
      "Id":widget.Id
    };
    dynamic res=await api.ApiCallingWithRequestBody("/vendor/accept.php", RequestBody);
    if(res["MESSAGE"]=="UPLOAD SUCEED"){
      print("job uploaded");
      AfterCancelApi();
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(Constants.mobile_no)));

    }else{
      Fluttertoast.showToast(msg: res["MESSAGE"]);
    }
  }
  AfterCancelApi() async{
    var requestBody = {
      "name": widget.name,
      "user_id": widget.user_id,
      "vendor_id":Constants.Id,
      "u_remark": "Booked",
      "service": widget.service,
      "service_type": widget.service_type,
      "slot": widget.slot,
      "location":widget.location,
      "payment_method": widget.payment_method,
      "status": widget.status,
      "price": widget.price,
      "plus_member": "NO",
      "date": widget.date,
      "quantity":widget.quantity,
      "mobile_no":widget.mobile_no,
      "v_remark":"Cancelled"
    };
    dynamic res=await api.ApiCallingWithRequestBody("/vendor/cancel.php", requestBody);
    if(res["MESSAGE"]=="UPLOAD SUCEED"){
      print("job Cancelled");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(Constants.mobile_no)));

    }else{
      Fluttertoast.showToast(msg: res["MESSAGE"]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Booking Summary",style: TextStyle(color: Colors.black),),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                    ),
                  ),
                  Column(
                    children: [
                      Text(widget.name.toString()+"\n"+widget.mobile_no.toString(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Icon(Icons.calendar_today_rounded,color: Colors.grey,),
                         Text(widget.slot.toString()+"\n           "+widget.date.toString().substring(0,11))
                       ],
                     )
                    ],
                  )
                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Service type",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Text(widget.service_type.toString().substring(0,widget.service_type.toString().length-6))
                    ],
                  ),
                   widget.v_remark=="Accepted"?
                  ElevatedButton(onPressed: (){
                    CancelBooking();
                  }, child: Text("Cancel Booking")):Container()
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.location_on_sharp,size: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Location",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        ),
                        Text(widget.location.toString(),style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded,size: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Booking Date",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        ),
                        Text(widget.date.toString().substring(0,11),style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.timelapse,size: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Booking Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        ),
                        Text(widget.slot.toString(),style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.credit_card_outlined,size: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Amount Paid",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        ),
                        Text(widget.price.toString(),style: TextStyle(fontSize: 25,color: Colors.indigo,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.credit_card_outlined,size: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Payment Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ],
                        ),
                        Text(widget.payment_method.toString(),style: TextStyle(fontSize: 18),),

                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.cleaning_services,size: 30,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Service Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              ],
                            ),
                            Text(widget.service_type.toString().substring(0,widget.service_type.toString().length-6),style: TextStyle(fontSize: 16),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.car_repair,size: 30,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Booking Status",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              ],
                            ),
                            Text(widget.u_remark.toString(),style: TextStyle(fontSize: 16),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Amount Details",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 25),),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Amount:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Extra Charge:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("GST:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Total Amount:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text("WHEN WOULD YOU LIKE TO BOOK THIS SERVICE?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.calendar_today,size: 40,color: Colors.indigo,),
                Text(widget.date.toString().substring(0,10),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                ElevatedButton(onPressed: (){}, child: Text("Save the date"))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(title: Text("Have you collected the total Amount?"),actions: <Widget>[
                      FlatButton(onPressed: () {
                      AcceptBooking("Completed");
                      },
                      child: Text("Yes"),),
                      FlatButton(onPressed: () {
                        Navigator.pop(context);
                      },child: Text("No"),)
                    ],) ;
                  },
                );
              },
              child:  widget.v_remark=="Accepted"? Container(

                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 50,
                width: MediaQuery.of(context).size.width*0.9,
                child: Center(child: Text("Marked As Completed",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
              ):Container(),
            ),
          ],
        ),
      ),
    );
  }
}

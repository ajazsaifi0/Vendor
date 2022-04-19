import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants.dart';
import '../Services/Api.dart';
import 'DetailScreen.dart';
class CancelledBooking extends StatefulWidget {
  const CancelledBooking({Key? key}) : super(key: key);

  @override
  _CancelledBookingState createState() => _CancelledBookingState();
}

class _CancelledBookingState extends State<CancelledBooking> {
  var api=new Api();
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
  getJobData()async{
    var requestBody={
      "vendor_id":Constants.Id,
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
  @override
  void initState() {
    // TODO: implement initState
    getJobData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return name!=[]?Container(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: name.length, itemBuilder: (context, index) {
            return  GestureDetector(
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
            );
          }),
        ],
      ),
    ):Center(child: CircularProgressIndicator(color: Colors.blue,));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmsman/Backend/Controllers/home_con.dart';
import 'package:helmsman/Frontend/Utils/app_helper.dart';

class UserDetailsSrc extends StatefulWidget {
  var uId, uName;
  UserDetailsSrc({super.key,this.uId, this.uName});

  @override
  State<UserDetailsSrc> createState() => _UserDetailsSrcState();
}

class _UserDetailsSrcState extends State<UserDetailsSrc> {

  final HomeController homeCon = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeCon.fetchUsersDetails('${widget.uId}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                ),
                Text('${widget.uName}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    )
                ),
                child: Obx((){
                  if(homeCon.isLoading.value){
                    return Center(child: CircularProgressIndicator(color: ColorHelper.primaryColor,),);
                  }
                  else{
                    var userD = homeCon.userDModel.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    child: Image(image: NetworkImage('${userD.image}')),
                                  ),
                                  SizedBox(height: 5),
                                  Text('${userD.username?.toUpperCase()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${userD.firstName} ${userD.maidenName} ${userD.lastName}'),
                                    Text('${userD.email}'),
                                    Text('${userD.phone}'),
                                    Text('${userD.address?.country}'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      '${userD.address?.address}, ${userD.address?.city}, ${userD.address?.state}, ${userD.address?.postalCode}, ${userD.address?.country}',
                                   textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Company',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      '${userD.company?.name},\n${userD.company?.department},\n${userD.company?.title}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      '${userD.company?.address?.address},\n${userD.company?.address?.city},${userD.address?.state},\n ${userD.company?.address?.postalCode}, ${userD.company?.address?.country}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helmsman/Frontend/Src/Dashboard/user_details_src.dart';
import 'package:helmsman/Frontend/Src/splash_sscr.dart';
import 'package:helmsman/Frontend/Utils/app_helper.dart';
import '../../../Backend/Controllers/home_con.dart';

class DashboardSrc extends StatefulWidget {
  const DashboardSrc({super.key});

  @override
  State<DashboardSrc> createState() => _DashboardSrcState();
}

class _DashboardSrcState extends State<DashboardSrc> {

  final box = GetStorage();
  final HomeController homCon = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 15, 10),
                  child: Text('Helmsman',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                IconButton(onPressed: () async{
                  await box.remove('accessToken');
                  Get.offAll(()=>SplashScr());
                }, icon: Icon(Icons.logout,color: Colors.white,))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (query) {
                  homCon.searchUsers(query);
                },
                decoration: DecoIn().decoInput,
              ),
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
                child: Obx(() {
                  if (homCon.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(homCon.userModel.value.users!.isEmpty){
                    return Center(child: Text('User not found'));
                  }
                  else {
                    return ListView.builder(
                      itemCount: homCon.userModel.value.users?.length,
                      itemBuilder: (context, index) {
                        var userData = homCon.userModel.value.users;
                        return InkWell(
                          onTap: (){
                            Get.to(()=>UserDetailsSrc(uId: userData?[index].id,uName: '${userData?[index].firstName} ${userData?[index].lastName}',));
                          },
                          child: ListTile(
                            title: Text('${userData?[index].firstName} ${userData?[index].lastName}'),
                            subtitle: Text('${userData?[index].email}'),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image(image: NetworkImage('${userData?[index].image}')),
                            ),
                          ),
                        );
                      },
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

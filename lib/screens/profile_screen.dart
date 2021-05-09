import 'package:flutter/material.dart';
import 'package:max_cours_shop_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
          body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
        child: Consumer<AuthProvider>(
                  builder:(context,data,_)=> Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  IconButton(padding: EdgeInsets.only(top: 50),icon: Icon(Icons.edit), onPressed: (){})
                ],
              ),
              SizedBox(
                height:25
              ),
              Text(data.user.userName,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(
                height:25
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(data.user.email),
              ),
              SizedBox(
                height:15
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(data.user.phoneNumber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
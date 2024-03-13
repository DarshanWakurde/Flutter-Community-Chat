import 'package:chatapp/main.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';


var username=TextEditingController();
var roomid=TextEditingController();
class UserInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }

}

class UserInfoState extends State<UserInfo>{
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text("Chat App "),
          ),
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.155,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 12),
                    controller: username,
                    decoration: InputDecoration(
                      label: Text("Username"),
                      contentPadding: EdgeInsets.all(25),
                      
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blueAccent)
                      )
                    ),
                  ),
                ),
              ),

SizedBox(height: 5,),
Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.155,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 12),
                    controller: roomid,
                    decoration: InputDecoration(
                      label: Text("Roomid"),
                      contentPadding: EdgeInsets.all(25),
                      
                      
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blueAccent)
                      )
                    ),
                  ),
                ),
              ),


              ElevatedButton(onPressed: (){

              
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=>ChatWidget(uname:username.text.toString(),roomid: roomid.text.toString(),)  
                        )
                        );

              }, child: Text(
                'Start Chat',
                style: TextStyle(fontSize: 15),
              )
              )
              ]),
          ) ,
        );

  }


}
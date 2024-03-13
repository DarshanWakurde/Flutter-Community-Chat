// ignore_for_file: prefer_const_constructors
import 'package:chatapp/UserName.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

late Map<String,String> datmsg;
  List<Widget> chatMessages = [];

  List message=[];
var bottomscroll=ScrollController();

var commentName=TextEditingController();

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData.fallback(),
      home: UserInfo(),
    ),
  );
}



class ChatWidget extends StatefulWidget{
String uname,roomid;
ChatWidget({required this.uname,required this.roomid});

  @override
  State<StatefulWidget> createState() {
   return ChatWidgetState();
  }



}


class ChatWidgetState extends State<ChatWidget>{





 late IO.Socket socket;

@override
  void initState() {
    


getMessage();

   
    super.initState();
  }



void getMessage(){



  socket =IO.io('http://192.168.0.110:5000/', IO.OptionBuilder().setTransports(['websocket']).build());




socket.onConnect((_) {
   
      print('connection established');

      socket.emit('roomid',widget.roomid);


    });

    socket.on(widget.roomid, (messages) {
      List<Widget> _chatMessages = [];
      for (var message in messages) {
        print(message);

        _chatMessages.add(ChatMessageWidget(
            username: message['username'],
            message: message['message'],
            name: widget.uname,
            ));
      }
      setState(() {
        chatMessages = _chatMessages.reversed.toList();
      
      });
    });

    socket.on(widget.roomid, (message) {
      print(message);
      setState(() {
        chatMessages = [
          ...chatMessages,
          ChatMessageWidget(
              username: message['username'],
              message: message['message'],
              name: widget.uname,
              )
        ];
      });

      
 
    });
}
  @override
  Widget build(BuildContext context) {
return Scaffold(
        appBar: AppBar(
          title: Text('Chat App',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
               
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-190,
                    color: Colors.transparent,
                    child: ListView(
                      reverse: true,
                        controller: bottomscroll,
                         children: chatMessages,
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        
                        ),
                        
                  ),
                
                
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: TextField(
                            controller: commentName,
                            decoration: InputDecoration(
                              isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                hintText: 'text here',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    // Handle clear
                                    commentName.clear();
                                  },
                                ))),
                      )),
                      GestureDetector(
                        onTap: () {
                          String message = commentName.text;
                          socket.emit(widget.roomid,
                              {"username": widget.uname, "message": message});
                                      bottomscroll.animateTo(bottomscroll.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                          commentName.clear();
                          setState(() { chatMessages;
                          getMessage();});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }




//   Container getlistContainer(){

// return  Container(
//       margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height*0.25),
    

//       child:getList() ,

//       );


//   }



//   ListView getList(){

// return ListView.builder(itemBuilder: (context,ind){


//   // return Text(message[ind]['message']);
          
//           return Card(
//               child: Container(
//                child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [Padding(
//                       padding: EdgeInsets.all(8),
//                       child: CircleAvatar(radius: 12,backgroundColor: Colors.black,child:Text(widget.uname[0],style: TextStyle(color: Colors.white),))),Container(width: 12,),Text(message[ind]['username'])],
                    
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
//                     child: Text('Comment:- '+message[ind]['message'],style: TextStyle(fontSize: 15),)),
//                 ],
//                ), 
//               ),
//           );


//       },
//       itemCount: message.length,
//       controller: bottomscroll,

//       );

//   }


}





class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {required this.username,
      required this.message,
      required this.name,
      
      super.key});

  final String username;
  final String name;
  final String message;


  @override
  Widget build(BuildContext context) {

    if(username==name){
       return Container(
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.2, 5, 0, 5),
      child: Card(
        color: Colors.blueAccent,
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(username[0],style: TextStyle(color: Colors.white),),
                    radius: 20,
                  ),
                ),

                Text(username,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 104, 158, 253)),)
              ],),

              Padding(
                padding: EdgeInsets.fromLTRB(15,0,15,5),
                child: Text("msg: "+message)),


        ],)
      ),
    );
    }

    else{
  return Container(
       margin: EdgeInsets.fromLTRB(0, 5, MediaQuery.of(context).size.width*0.2, 5),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(username[0],style: TextStyle(color: Colors.white),),
                    radius: 20,
                  ),
                ),

                Text(username,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.blueAccent),)
              ],),

              Padding(
                padding: EdgeInsets.fromLTRB(15,0,15,5),
                child: Text("msg: "+message)),


        ],)
      ),
    );
    }
   
  }
}



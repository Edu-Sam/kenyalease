import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widget/module.dart';
import '../../constants/module.dart';


class ChatScreen extends StatefulWidget{
  ChatScreen({Key? key,required this.currentUser,required this.recepientID,
  required this.message_title,required this.property_name,
  required this.sender_name}) : super(key: key);
  String? currentUser;
  String? recepientID;
  String? sender_name;
  String? message_title;
  String? property_name;


  @override
  _ChatScreenState createState()=> _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{

  TextEditingController chat_controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    print("Current user: " + widget.currentUser!.toString() + ":  Receipient ID :" +
    widget.recepientID.toString());
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,color: Colors.black54,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(widget.message_title.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,),
            onPressed: (){

            },
          )
        ],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white
              //    color: Colors.blue,
                  /*borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  )*/
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users').doc(widget.currentUser).collection('messages').doc(
                        widget.recepientID
                    ).collection('chats').orderBy('date', descending: true).snapshots(),
                    builder: (context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data!.docs.length < 1){
                          return Center(
                            child: Text('No messages'),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            reverse: true,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index){
                              bool isMe = snapshot.data!.docs[index]['senderId'] ==widget.currentUser;
                              // bool isMe = snapshot.data!.docs[index].data(index).
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: SingleMessage(isMe: isMe, message: snapshot.data!.docs[index]['message'],
                                sent_date: snapshot.data!.docs[index]['date'].toString(),
                                  sender_name: widget.sender_name!,
                                ),
                              );
                            });
                      } return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            )),
            Container(

              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(child: Container(
                    height: 48,
                    child: TextField(
                      controller: chat_controller,
                      decoration: InputDecoration(
                          labelText: 'Type your message',
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade200),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(24)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade100),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(24)
                          )
                      ),
                    ),
                  )),
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () async{
                      String message =  chat_controller.text;
                        chat_controller.clear();
                      await FirebaseFirestore.instance.collection('users').doc(widget.currentUser).collection('messages').doc(widget.recepientID).collection('chats').add({
                        "senderId": widget.currentUser,
                        "receiverId": widget.recepientID,
                        "message_title":widget.message_title,
                        "property_name":widget.property_name,
                        "sender_name":widget.sender_name,
                        "message": message,
                        "type":"text",
                        "date":DateTime.now().toString()
                      }).then((value) async{
                        await FirebaseFirestore.instance.collection('users').doc(widget.currentUser).collection('messages').doc(widget.recepientID).set({
                          'last_msg':message,
                          "message_title":widget.message_title,
                          "property_name":widget.property_name,
                          "date":DateTime.now().toString()
                        });
                      });

                      await FirebaseFirestore.instance.collection('users').doc(widget.recepientID).collection('messages').doc(widget.currentUser).collection('chats').add({
                        "senderId": widget.currentUser,
                        "receiverId": widget.recepientID,
                        "message_title":widget.message_title,
                        "property_name":widget.property_name,
                        "sender_name":widget.sender_name,
                        "message": message,
                        "type":"text",
                        "date":DateTime.now().toString()
                      }).then((value) async{
                      /* await  FirebaseFirestore.instance.collection('users').doc(widget.currentUser).collection('messages').doc(widget.recepientID).set({
                          'last_msg':message,
                          "message_title":widget.message_title,
                          "property_name":widget.property_name,
                          "date":DateTime.now().toString()
                        });*/
                        await  FirebaseFirestore.instance.collection('users').doc(widget.recepientID).collection('messages').doc(widget.currentUser).set({
                          'last_msg':message,
                          "message_title":widget.message_title,
                          "property_name":widget.property_name,
                          "date":DateTime.now().toString()
                        });
                      });

                    },
                    child: Container(
                      padding:  EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConstants.thirdColorDark
                      ),
                      child:  Icon(Icons.send, color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
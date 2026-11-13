import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:somalease/constants/app_constants.dart';
import 'package:somalease/view/Chat/chat_screen.dart';
import '../../models/module.dart';


class ChatCatalogue extends StatefulWidget{
  ChatCatalogue({Key? key}) : super(key: key);

  @override
  _ChatCatalogueState createState()=> _ChatCatalogueState();
}

class _ChatCatalogueState extends State<ChatCatalogue>{

  List<int> messages=[1,2,3,4,5,6,7,8,9];

  @override
  Widget build(BuildContext context) {
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
        title: Text("Messages",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
             StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('users')
                     .doc(Provider.of<Preferences>(context,listen: false).user!.user_id.toString()).collection('messages')
                 .snapshots(),
                 builder: (context, AsyncSnapshot snapshot){

                    if(snapshot.hasData){
                      if(snapshot.data!.docs.length < 1){
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: Center(
                            child: Text('No messages'),
                          ),
                        );
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            DocumentSnapshot chat_docs=snapshot.data!.docs[index];

                            //String message_title=snapshot.data!.docs[index].collection("chats").docs[0]['message_title'];
                            var message_title=chat_docs['message_title'];
                            var property_name=chat_docs['property_name'];
                            var last_msg=chat_docs['last_msg'];
                            var date=chat_docs['date'];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                ChatScreen(currentUser: Provider.of<Preferences>(context,listen: false)
                                    .user!.user_id.toString(),
                                    recepientID: chat_docs.id.toString(),
                                    message_title: message_title,
                                    property_name: property_name, sender_name: Provider.of<Preferences>(context,listen: false)
                                        .user!.firstname + ' ' + Provider.of<Preferences>(context,listen: false)
                                        .user!.lastname.toString())));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade300))
                                ),
                                // height: 120,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: Text(message_title,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                color: Colors.black87
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: Text(date.toString().substring(0,10),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                color: Colors.black87
                                            ),),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text(property_name,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.grey.shade700
                                        ),),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text(last_msg,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.grey.shade700
                                        ),),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    else{
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
                          ),
                        ),
                      );
                    }
             })
            ],
          ),
        ),
      ),
    );
  }
}
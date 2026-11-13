import 'package:flutter/material.dart';
import 'package:somalease/constants/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool isMe;
  final String? sent_date;
  final String sender_name;
  SingleMessage({ required this.isMe, required this.message,required this.sent_date,
  required this.sender_name});

  @override
  Widget build(BuildContext context) {
    print("Isme is " + isMe.toString());

    return Container(
      padding: const EdgeInsets.all(16),
      //   margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      //   constraints: const BoxConstraints(maxWidth: 200),
      decoration: BoxDecoration(
       //   color: isMe ? Colors.black : Colors.orange,
          color: isMe ?   AppConstants.messageColor :AppConstants.messageRecepientColor ,
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text('$message', style: TextStyle(color: Colors.grey.shade700),),
          ),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Text(dateToFormat(sent_date!),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppConstants.thirdColorDark
              ),)
            ],
          )
        ],
      )
    );
   /* return Container(
      //width: MediaQuery.of(context).size.width,
      child: Row(
        //   mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 0.0),
           child:  Container(
             padding: const EdgeInsets.all(16),
             //   margin: const EdgeInsets.all(16),
             width: MediaQuery.of(context).size.width,
             //   constraints: const BoxConstraints(maxWidth: 200),
             decoration: BoxDecoration(
                 color: isMe ? Colors.black : Colors.orange,
                 borderRadius: const BorderRadius.all(Radius.circular(12))
             ),
             child: Text('$message', style: TextStyle(color: Colors.white),),
           ),
         )
        ],
      ),
    );*/
  }

  String dateToFormat(String date){

    String new_date= date.substring(8,10)+  "/" + date.substring(5,7) + "/" + date.substring(0,4);
    print("Date to be parsed is " + new_date);
    DateTime new_date_time = DateTime.parse(date.substring(0,19));
    String new_converted_date= DateFormat('hh:mm a').format(new_date_time);
    print("new date: " + new_date + " " + new_converted_date.toString());
    /*DateFormat date_format=DateFormat("yyyy-MM-dd");
    String formatted_date= date_format.format(new_date_time);
    formatted_date=formatted_date + " " + DateTime.now().toString().substring(10,19);
    print("The new date is " + formatted_date);*/
    return new_date + " " + new_converted_date.toString();
  }
}
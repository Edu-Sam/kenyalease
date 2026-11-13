import 'package:flutter/material.dart';
//import '../widgets/module.dart';
import 'package:provider/provider.dart';
import 'module.dart';
class Validation{

  String field_tag='Field is required',special_tag='No special characters allowed in field',
      password_length_tag='Password must be longer than 8 characters';
  //ErrorContainer errorContainer=ErrorContainer();




  String? emailValidator(String value) {
    if(value.isNotEmpty){
      /*Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';*/
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex =  RegExp(pattern);
      if (!regex.hasMatch(value)) {
        /*errorContainer.showValidationDialog(1,context,onRetry: (){


      });*/
        return 'Incorrect email format';
        //return 'Email format is invalid';
      }
      else {
        return null;
      }
    }

    else{
      return 'Field is required';
    }
  }

  String? nameValidator(String value){

    String value1=value.trimRight();
    if(value.isNotEmpty){
      Pattern letter=r'[a-zA-Z]{3}$';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~])";
      String pattern=r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-.,/%]$';
      //Pattern pattern=r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-.,/%]$';
      //   Pattern pattern= r'^(?=.*?[a-zA-Z]).{5,}[^0-9](?=.*?[^!@#\$&*~.])';
      //Alternative to the above pattern is to dissallow /s which matches the whitespace character


      RegExp regex= RegExp(pattern);
      if(value1.isEmpty){
        //return 'Field is required';
        return field_tag;
      }
      else{
        if(regex.hasMatch(value1)){
          return special_tag;
          //  return 'No special characters allowed in field';
        }
        else{
          return null;
        }
      }


    }
    else{
      //  return 'Field is required';
      return field_tag;
    }

  }

  String? name1Validator(String value){

    String value1=value.trimRight();
    if(value1.isNotEmpty){
      return null;
    }
    else{
      //  return 'Field is required';
      return field_tag;
    }

  }
  /*String pwdValidator(String value,BuildContext context) {
    /*  if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }*/
    if(value.length > 5){
      Pattern letter='r[a-zA-z]{5,}';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~,.\" ])";
      Pattern special1='[\W]';
      Pattern pattern= r'(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])';
      //  Pattern pattern1= r'(?:(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])| (?=.*?[0-9])(?=.*?[!@#\$&*~.])(?=.*?[a-zA-z]).{5,})$';
      Pattern pattern1=r'^(?:(?=.*[a-zA-z]).{5,}|(?=.*[\d\W])|(?=.*\W])(?=.*\d)(?:(?=.*[a-zA-z]).{5,}(?=.*[\d])(?=.*[\W])|(?=.*\W)(?=.*\d)(?=.*[a-zA-z]).{5,})|(?=.*\W)(?=.*[a-zA-z]).{5,}(?=.*\d))$';
//(?=.*[\d\W])
      RegExp regSpecial=new RegExp(special);
      RegExp regex=new RegExp(pattern1);
      if(value.isEmpty){
        return 'Please Enter password';
      }
      else{
        if(!regex.hasMatch(value)){
          return 'Invalid password.Password must include a symbol or a number and have atleast 5 characters';
        }
        else{
          return null;
        }
      }
    }
    else{
      return 'password must be longer than 8 characters';
    }
  }*/

  String? pwdValidator(String value) {
    if (value.length < 8) {
      //  return 'Password must be longer than 8 characters';
      return password_length_tag;
    } else {
      return null;
    }

  }



  String? phoneValidator(String value){
    String new_value;
    //Pattern pattern=r'^[0-9]+$';
    String pattern=r'^[0-9]+$';

    if((value.startsWith("+")) && value.length==13){
      new_value=value.substring(4,13);
    }

    else if(value.length==10){
      new_value=value;
    }

    else{
      return 'Please enter a valid phone number';
    }

    RegExp regExp= RegExp(pattern);
    if(value.isEmpty){
      return 'Mobile number is empty';
    }
    else if(!regExp.hasMatch(new_value)){
      return 'please enter valid mobile number';
    }

    return null;

  }


  String? nationalIdNumber(String value){
    //Pattern pattern=r'^[0-9]+$';
    String pattern=r'^[0-9]+$';

    RegExp regExp=RegExp(pattern);
    if(value.length==0){
      return 'National ID number is empty';
    }
    else if(!regExp.hasMatch(value)){
      return 'please enter valid national ID number';
    }


    return null;
  }
  String? bankAccountValidator(String value,BuildContext context){
    if(value.length > 7){
      // Pattern pattern=r'^(?=.*?[0-9])';
      String pattern=r'^(?=.*?[0-9])';

      RegExp regex= RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter bank account';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid bank account';
      }

      else{
        return null;
      }
    }

    else{
      return 'Account Number must be atleast 8 characters';
    }
  }


  String? businessNoValidator(String value,BuildContext context){
    if(value.length > 5){

      // Pattern pattern=r'^(?=.*?[0-9])';
      String pattern=r'^(?=.*?[0-9])';


      RegExp regex= RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter business number';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid business number';
      }

      else{
        return null;
      }
    }

    else{
      return 'Business Number must be atleast 6 characters';
    }
  }

  String? checkDate(String value,BuildContext context){
    if(value.isEmpty){
      return 'Select appropriate date';
    }
    return null;
  }

  String? checkTime(String value,BuildContext context){
    if(value.isEmpty){
      return 'Select appropriate time';
    }
    return null;
  }

  String concatenateNumber(String code,String number){

    if(number.startsWith("0")){
      String new_value=number.substring(1,number.length);
      String new_value1=code+new_value;
      return new_value1;
    }

    else{
      String new_value=code + number;
      return new_value;
    }



  }

}
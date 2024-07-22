import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tepmare_warehouse_man_app/config/constants.dart';

Future<dynamic> scanItem(BuildContext context)async{
  await showDialog(context: context, builder: (context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
    );
  });
}
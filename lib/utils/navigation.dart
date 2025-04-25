import 'package:flutter/material.dart';

class Navigation{
  void emptyStack(context, Widget nextPage){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(_) => nextPage), (route)=>false);
    
  }
}
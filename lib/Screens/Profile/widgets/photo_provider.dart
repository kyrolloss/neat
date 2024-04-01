import 'package:flutter/material.dart';
class PhotoProvider extends ChangeNotifier{
  String? imageUrl;

  void setImageUrl(String url){
    imageUrl = url ;
    notifyListeners();
  }
}